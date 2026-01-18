/**
 * GitHub API Service
 * @module services/githubService
 * 
 * Handles all interactions with the GitHub REST API to fetch pull request data
 */

import { GITHUB_CONFIG } from '../config/github-config.js';
import { GITHUB_API, STORAGE_KEYS } from '../config/constants.js';

/**
 * GitHub API Service with caching, error handling, and rate limit management
 */
class GitHubService {
    constructor() {
        this.baseUrl = GITHUB_CONFIG.API_BASE_URL;
        this.owner = GITHUB_CONFIG.REPO_OWNER;
        this.repo = GITHUB_CONFIG.REPO_NAME;
        this.token = GITHUB_CONFIG.ACCESS_TOKEN;
        this.rateLimit = {
            remaining: null,
            limit: null,
            reset: null
        };
    }

    /**
     * Check if the service is properly configured
     * @returns {boolean} True if configuration is valid
     */
    isConfigured() {
        return this.token &&
            this.token !== 'YOUR_SELLIO_BOT_TOKEN_HERE' &&
            this.owner &&
            this.repo;
    }

    /**
     * Get authorization headers for API requests
     * @returns {Object} Headers object
     */
    getHeaders() {
        return {
            'Accept': 'application/vnd.github.v3+json',
            'Authorization': `token ${this.token}`,
            'User-Agent': 'Sellio-Dashboard'
        };
    }

    /**
     * Update rate limit information from response headers
     * @param {Response} response - Fetch API response
     */
    updateRateLimit(response) {
        this.rateLimit.remaining = parseInt(response.headers.get('x-ratelimit-remaining'));
        this.rateLimit.limit = parseInt(response.headers.get('x-ratelimit-limit'));
        this.rateLimit.reset = parseInt(response.headers.get('x-ratelimit-reset'));
    }

    /**
     * Get current rate limit status
     * @returns {Object} Rate limit information
     */
    getRateLimitStatus() {
        return {
            ...this.rateLimit,
            resetDate: this.rateLimit.reset ? new Date(this.rateLimit.reset * 1000) : null,
            isLow: this.rateLimit.remaining !== null &&
                this.rateLimit.remaining < GITHUB_API.RATE_LIMIT_WARNING_THRESHOLD
        };
    }

    /**
     * Make a request to GitHub API with error handling
     * @param {string} endpoint - API endpoint
     * @returns {Promise<Object>} Response data
     */
    async makeRequest(endpoint) {
        const url = `${this.baseUrl}${endpoint}`;

        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), GITHUB_API.TIMEOUT_MS);

        try {
            const response = await fetch(url, {
                headers: this.getHeaders(),
                signal: controller.signal
            });

            clearTimeout(timeoutId);
            this.updateRateLimit(response);

            if (!response.ok) {
                if (response.status === 401) {
                    throw new Error('GitHub authentication failed. Please check your access token.');
                } else if (response.status === 403) {
                    throw new Error('GitHub API rate limit exceeded. Please try again later.');
                } else if (response.status === 404) {
                    throw new Error('Repository not found. Please check the owner and repo name.');
                } else {
                    throw new Error(`GitHub API error: ${response.status} ${response.statusText}`);
                }
            }

            return await response.json();
        } catch (error) {
            clearTimeout(timeoutId);
            if (error.name === 'AbortError') {
                throw new Error('Request timed out. Please check your network connection.');
            }
            throw error;
        }
    }

    /**
     * Fetch all pull requests from the repository
     * @returns {Promise<Array>} Array of pull requests
     */
    async fetchPullRequests() {
        const allPRs = [];
        const sinceDate = new Date();
        sinceDate.setDate(sinceDate.getDate() - GITHUB_API.DAYS_LOOKBACK);

        let page = 1;
        let hasMore = true;

        console.log(`📡 Fetching pull requests from ${this.owner}/${this.repo}...`);

        while (hasMore && page <= GITHUB_API.MAX_PAGES) {
            const endpoint = `/repos/${this.owner}/${this.repo}/pulls?state=all&per_page=${GITHUB_API.PER_PAGE}&page=${page}&sort=updated&direction=desc`;

            try {
                const prs = await this.makeRequest(endpoint);

                if (!prs || prs.length === 0) {
                    hasMore = false;
                    break;
                }

                // Filter PRs by date
                const filteredPRs = prs.filter(pr => {
                    const prDate = new Date(pr.created_at);
                    return prDate >= sinceDate;
                });

                allPRs.push(...filteredPRs);

                console.log(`  📄 Fetched page ${page}: ${prs.length} PRs (${filteredPRs.length} within date range)`);

                // If we got fewer filtered PRs, we've likely passed our date range
                if (filteredPRs.length < prs.length) {
                    hasMore = false;
                } else if (prs.length < GITHUB_API.PER_PAGE) {
                    hasMore = false;
                }

                page++;
            } catch (error) {
                console.error(`❌ Error fetching page ${page}:`, error.message);
                throw error;
            }
        }

        console.log(`✅ Total PRs fetched: ${allPRs.length}`);
        return allPRs;
    }

    /**
     * Fetch reviews for a specific pull request
     * @param {number} prNumber - Pull request number
     * @returns {Promise<Array>} Array of reviews
     */
    async fetchPRReviews(prNumber) {
        const endpoint = `/repos/${this.owner}/${this.repo}/pulls/${prNumber}/reviews`;
        return await this.makeRequest(endpoint);
    }

    /**
     * Fetch review comments for a specific pull request
     * @param {number} prNumber - Pull request number
     * @returns {Promise<Array>} Array of review comments
     */
    async fetchPRComments(prNumber) {
        const endpoint = `/repos/${this.owner}/${this.repo}/pulls/${prNumber}/comments`;
        return await this.makeRequest(endpoint);
    }

    /**
     * Fetch issue comments for a specific pull request
     * @param {number} prNumber - Pull request number
     * @returns {Promise<Array>} Array of issue comments
     */
    async fetchPRIssueComments(prNumber) {
        const endpoint = `/repos/${this.owner}/${this.repo}/issues/${prNumber}/comments`;
        return await this.makeRequest(endpoint);
    }

    /**
     * Transform GitHub PR data to dashboard format
     * @param {Object} githubPR - GitHub API PR object
     * @param {Array} reviews - PR reviews
     * @param {number} commentCount - Total comment count
     * @returns {Object} Transformed PR object
     */
    transformPRData(githubPR, reviews = [], commentCount = 0) {
        // Determine status
        let status = 'pending';
        if (githubPR.state === 'closed') {
            status = githubPR.merged_at ? 'merged' : 'closed';
        }

        // Find first approval
        const approvals = reviews.filter(r => r.state === 'APPROVED');
        const firstApproval = approvals.length > 0
            ? approvals.sort((a, b) => new Date(a.submitted_at) - new Date(b.submitted_at))[0]
            : null;

        // Calculate time to first approval
        let timeToFirstApproval = null;
        let firstReviewer = null;
        if (firstApproval) {
            const createdAt = new Date(githubPR.created_at);
            const approvedAt = new Date(firstApproval.submitted_at);
            timeToFirstApproval = Math.floor((approvedAt - createdAt) / (1000 * 60)); // minutes
            firstReviewer = firstApproval.user.login;
        }

        // Extract unique reviewers
        const reviewers = [...new Set(reviews.map(r => r.user.login))];

        // Extract unique commenters
        const commenters = [...new Set(reviews.map(r => r.user.login))];

        return {
            number: githubPR.number,
            title: githubPR.title,
            url: githubPR.html_url,
            author: githubPR.user.login,
            status: status,
            createdAt: githubPR.created_at,
            mergedAt: githubPR.merged_at,
            approvedAt: firstApproval ? firstApproval.submitted_at : null,
            mergedBy: githubPR.merged_by ? githubPR.merged_by.login : null,
            additions: githubPR.additions || 0,
            deletions: githubPR.deletions || 0,
            comments: commentCount,
            approvals: approvals.length,
            reviewers: reviewers,
            commenters: commenters,
            timeToFirstApproval: timeToFirstApproval,
            firstReviewer: firstReviewer
        };
    }

    /**
     * Fetch complete PR data with reviews and comments
     * @returns {Promise<Array>} Array of transformed PR objects
     */
    async fetchPRData() {
        if (!this.isConfigured()) {
            throw new Error('GitHub service is not properly configured. Please check github-config.js');
        }

        console.log('🚀 Starting GitHub data fetch...');
        const startTime = Date.now();

        // Fetch all PRs
        const pullRequests = await this.fetchPullRequests();

        // For performance, we'll fetch detailed data for a subset of PRs
        // Prioritize recent and open PRs
        const prsToEnrich = pullRequests.slice(0, 50); // Limit to avoid rate limits
        const transformedPRs = [];

        console.log(`📊 Enriching ${prsToEnrich.length} PRs with review data...`);

        for (let i = 0; i < prsToEnrich.length; i++) {
            const pr = prsToEnrich[i];

            try {
                // Fetch reviews and comments in parallel
                const [reviews, reviewComments, issueComments] = await Promise.all([
                    this.fetchPRReviews(pr.number),
                    this.fetchPRComments(pr.number),
                    this.fetchPRIssueComments(pr.number)
                ]);

                const totalComments = reviewComments.length + issueComments.length;
                const transformed = this.transformPRData(pr, reviews, totalComments);
                transformedPRs.push(transformed);

                if ((i + 1) % 10 === 0) {
                    console.log(`  ⏳ Progress: ${i + 1}/${prsToEnrich.length} PRs enriched`);
                }
            } catch (error) {
                console.warn(`⚠️ Failed to enrich PR #${pr.number}:`, error.message);
                // Add PR without enrichment
                transformedPRs.push(this.transformPRData(pr, [], 0));
            }
        }

        // For remaining PRs, add them without enrichment
        if (pullRequests.length > prsToEnrich.length) {
            const remainingPRs = pullRequests.slice(prsToEnrich.length);
            console.log(`📋 Adding ${remainingPRs.length} additional PRs without detailed enrichment`);

            remainingPRs.forEach(pr => {
                transformedPRs.push(this.transformPRData(pr, [], 0));
            });
        }

        const duration = ((Date.now() - startTime) / 1000).toFixed(2);
        console.log(`✅ Completed in ${duration}s. Total PRs: ${transformedPRs.length}`);

        // Cache the results
        this.cacheData(transformedPRs);

        return transformedPRs;
    }

    /**
     * Cache PR data to localStorage
     * @param {Array} data - PR data to cache
     */
    cacheData(data) {
        try {
            localStorage.setItem(STORAGE_KEYS.GITHUB_CACHE, JSON.stringify(data));
            localStorage.setItem(STORAGE_KEYS.GITHUB_CACHE_TIMESTAMP, Date.now().toString());
            console.log('💾 Data cached successfully');
        } catch (error) {
            console.warn('⚠️ Failed to cache data:', error.message);
        }
    }

    /**
     * Get cached PR data if available and not expired
     * @returns {Array|null} Cached PR data or null
     */
    getCachedData() {
        try {
            const timestamp = parseInt(localStorage.getItem(STORAGE_KEYS.GITHUB_CACHE_TIMESTAMP));
            const now = Date.now();

            if (timestamp && (now - timestamp) < GITHUB_API.CACHE_TTL_MS) {
                const data = JSON.parse(localStorage.getItem(STORAGE_KEYS.GITHUB_CACHE));
                const ageMinutes = Math.floor((now - timestamp) / (1000 * 60));
                console.log(`💾 Using cached data (${ageMinutes} minutes old)`);
                return data;
            }

            console.log('💾 Cache expired or not found');
            return null;
        } catch (error) {
            console.warn('⚠️ Failed to read cache:', error.message);
            return null;
        }
    }

    /**
     * Clear cached data
     */
    clearCache() {
        localStorage.removeItem(STORAGE_KEYS.GITHUB_CACHE);
        localStorage.removeItem(STORAGE_KEYS.GITHUB_CACHE_TIMESTAMP);
        console.log('🗑️ Cache cleared');
    }

    /**
     * Fetch PR data with caching
     * @param {boolean} forceRefresh - Force refresh from API
     * @returns {Promise<Array>} PR data
     */
    async fetchWithCache(forceRefresh = false) {
        if (!forceRefresh) {
            const cached = this.getCachedData();
            if (cached) {
                return cached;
            }
        }

        return await this.fetchPRData();
    }
}

// Export singleton instance
export const githubService = new GitHubService();

// Export class for testing
export { GitHubService };
