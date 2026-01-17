// ===========================
// Analytics Service - Advanced analytics calculations
// ===========================

import { PR_TYPE_PATTERNS, WEEK_CONFIG, HEALTH_THRESHOLDS } from '../constants/analyticsConstants.js';
import { getWeekStartDate, formatDetailedDuration } from '../utils/formatters.js';

class AnalyticsService {
    /**
     * Calculate KPI metrics for analytics dashboard
     * @param {Array} prData - Array of PR data
     * @param {string} developerFilter - Optional developer filter
     * @returns {Object} KPI metrics
     */
    static calculateKPIs(prData, developerFilter = 'all') {
        let filteredData = prData;

        if (developerFilter !== 'all') {
            filteredData = prData.filter(pr => {
                const isCreator = pr.author === developerFilter;
                const isMerger = pr.mergedBy === developerFilter;
                const isReviewer = pr.reviewers?.includes(developerFilter);
                return isCreator || isMerger || isReviewer;
            });
        }

        const totalPRs = filteredData.length;
        const mergedPRs = filteredData.filter(pr => pr.status === 'merged').length;
        const closedPRs = filteredData.filter(pr => pr.status === 'closed').length;

        // Calculate average PR size
        const totalAdditions = filteredData.reduce((sum, pr) => sum + (pr.additions || 0), 0);
        const totalDeletions = filteredData.reduce((sum, pr) => sum + (pr.deletions || 0), 0);
        const avgAdditions = totalPRs > 0 ? (totalAdditions / totalPRs).toFixed(0) : 0;
        const avgDeletions = totalPRs > 0 ? (totalDeletions / totalPRs).toFixed(0) : 0;

        // Calculate comment metrics
        const totalComments = filteredData.reduce((sum, pr) => sum + (pr.comments || 0), 0);
        const avgComments = totalPRs > 0 ? (totalComments / totalPRs).toFixed(1) : '0.0';

        // Calculate approval time
        const approvalTimes = filteredData
            .map(pr => pr.timeToFirstApproval)
            .filter(t => t !== null && t !== undefined && t >= 0);
        const avgApprovalTime = approvalTimes.length > 0
            ? approvalTimes.reduce((a, b) => a + b, 0) / approvalTimes.length
            : null;

        // Calculate PR lifespan
        const mergedData = filteredData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.createdAt);
        const lifespans = mergedData.map(pr => {
            const created = new Date(pr.createdAt);
            const merged = new Date(pr.mergedAt);
            return (merged - created) / 60000; // minutes
        });
        const avgLifespan = lifespans.length > 0
            ? lifespans.reduce((a, b) => a + b, 0) / lifespans.length
            : null;

        return {
            totalPRs,
            mergedPRs,
            closedPRs,
            avgPRSize: { additions: avgAdditions, deletions: avgDeletions },
            totalComments,
            avgComments,
            avgApprovalTime: formatDetailedDuration(avgApprovalTime),
            avgLifespan: formatDetailedDuration(avgLifespan)
        };
    }

    /**
     * Calculate spotlight metrics (hot streak, fastest reviewer, top commenter)
     * @param {Array} prData - Array of PR data
     * @param {string} developerFilter - Optional developer filter
     * @returns {Object} Spotlight metrics
     */
    static calculateSpotlightMetrics(prData, developerFilter = 'all') {
        if (developerFilter !== 'all') {
            // For individual developer view
            const developerPRs = prData.filter(pr => pr.author === developerFilter);
            const prCommentCount = prData.filter(pr =>
                pr.commenters?.includes(developerFilter)
            ).length;

            return {
                hotStreak: {
                    user: developerFilter,
                    count: developerPRs.length,
                    label: `Created ${developerPRs.length} PRs`
                },
                fastestReviewer: null,
                topCommenter: {
                    user: developerFilter,
                    count: prCommentCount,
                    label: `Commented on ${prCommentCount} PRs`
                }
            };
        }

        // Team-wide view
        // Hot Streak - most active contributor
        const recentActivity = prData.reduce((acc, pr) => {
            acc[pr.author] = (acc[pr.author] || 0) + 1;
            if (pr.mergedBy) {
                acc[pr.mergedBy] = (acc[pr.mergedBy] || 0) + 1;
            }
            pr.reviewers?.forEach(reviewer => {
                if (reviewer !== pr.author) {
                    acc[reviewer] = (acc[reviewer] || 0) + 1;
                }
            });
            return acc;
        }, {});

        const hotStreakUser = Object.entries(recentActivity)
            .sort((a, b) => b[1] - a[1])[0];

        // Fastest Reviewer
        const reviewTimes = prData.reduce((acc, pr) => {
            if (pr.timeToFirstApproval !== null && pr.firstReviewer) {
                if (!acc[pr.firstReviewer]) acc[pr.firstReviewer] = [];
                acc[pr.firstReviewer].push(pr.timeToFirstApproval);
            }
            return acc;
        }, {});

        const fastestReviewer = Object.entries(reviewTimes)
            .map(([user, times]) => ({
                user,
                avg: times.reduce((a, b) => a + b, 0) / times.length
            }))
            .sort((a, b) => a.avg - b.avg)[0];

        // Top Commenter
        const commenterCounts = prData.reduce((acc, pr) => {
            pr.commenters?.forEach(commenter => {
                acc[commenter] = (acc[commenter] || 0) + 1;
            });
            return acc;
        }, {});

        const topCommenter = Object.entries(commenterCounts)
            .sort((a, b) => b[1] - a[1])[0];

        return {
            hotStreak: hotStreakUser ? {
                user: hotStreakUser[0],
                count: hotStreakUser[1],
                label: `Top Contributor (${hotStreakUser[1]} actions)`
            } : null,
            fastestReviewer: fastestReviewer ? {
                user: fastestReviewer.user,
                avg: fastestReviewer.avg,
                label: `Fastest Reviewer (${formatDetailedDuration(fastestReviewer.avg)})`
            } : null,
            topCommenter: topCommenter ? {
                user: topCommenter[0],
                count: topCommenter[1],
                label: `Most Active Commenter (${topCommenter[1]} PRs)`
            } : null
        };
    }

    /**
     * Generate daily activity breakdown
     * @param {Array} prData - Array of PR data
     * @returns {Object} Daily activity grouped by week
     */
    static generateDailyActivity(prData) {
        const dailyActivity = prData.reduce((acc, pr) => {
            const day = new Date(pr.createdAt).toLocaleDateString('en-CA');
            if (!acc[day]) {
                acc[day] = { created: [], merged: 0, approvals: 0 };
            }
            acc[day].created.push(pr);

            if (pr.mergedAt) {
                const mDay = new Date(pr.mergedAt).toLocaleDateString('en-CA');
                if (!acc[mDay]) acc[mDay] = { created: [], merged: 0, approvals: 0 };
                acc[mDay].merged++;
            }

            const approvalCount = pr.approvals || 0;
            if (approvalCount > 0) {
                acc[day].approvals += approvalCount;
            }

            return acc;
        }, {});

        // Group by week
        const dailyActivityByWeek = Object.keys(dailyActivity)
            .sort((a, b) => new Date(b) - new Date(a))
            .reduce((acc, dayString) => {
                const weekStartDate = getWeekStartDate(dayString);
                const weekKey = weekStartDate.toISOString();
                if (!acc[weekKey]) {
                    acc[weekKey] = [];
                }
                acc[weekKey].push(dayString);
                return acc;
            }, {});

        return { dailyActivity, dailyActivityByWeek };
    }

    /**
     * Analyze PR types
     * @param {Array} prData - Array of PR data
     * @returns {Object} PR type analysis
     */
    static analyzePRTypes(prData) {
        const prTypes = prData.reduce((acc, pr) => {
            const title = pr.title.toLowerCase();
            let type = 'other';

            for (const [typeName, pattern] of Object.entries(PR_TYPE_PATTERNS)) {
                if (pattern.test(title)) {
                    type = typeName;
                    break;
                }
            }

            if (!acc[type]) {
                acc[type] = {
                    count: 0,
                    additions: 0,
                    deletions: 0,
                    approvalTimes: []
                };
            }

            acc[type].count++;
            acc[type].additions += pr.additions || 0;
            acc[type].deletions += pr.deletions || 0;
            if (pr.timeToFirstApproval !== null) {
                acc[type].approvalTimes.push(pr.timeToFirstApproval);
            }

            return acc;
        }, {});

        return Object.entries(prTypes)
            .sort((a, b) => b[1].count - a[1].count)
            .map(([type, data]) => ({
                type,
                ...data,
                percentage: (data.count / prData.length * 100).toFixed(1)
            }));
    }

    /**
     * Calculate collaboration pairs
     * @param {Array} prData - Array of PR data
     * @returns {Array} Top collaboration pairs
     */
    static calculateCollaborationPairs(prData) {
        const collaborationSummary = prData.reduce((acc, pr) => {
            pr.reviewers?.forEach(reviewer => {
                if (reviewer === pr.author) return;

                if (!acc[reviewer]) {
                    acc[reviewer] = {
                        totalReviews: 0,
                        collaborators: new Set()
                    };
                }
                acc[reviewer].totalReviews++;
                acc[reviewer].collaborators.add(pr.author);
            });
            return acc;
        }, {});

        return Object.entries(collaborationSummary)
            .map(([reviewer, data]) => ({
                reviewer,
                totalReviews: data.totalReviews,
                collaborators: Array.from(data.collaborators)
            }))
            .sort((a, b) => b.totalReviews - a.totalReviews)
            .slice(0, 10);
    }

    /**
     * Get most discussed PRs
     * @param {Array} prData - Array of PR data
     * @returns {Array} Most discussed PRs
     */
    static getMostDiscussedPRs(prData) {
        return prData
            .map(pr => ({
                ...pr,
                totalComments: pr.comments || 0
            }))
            .filter(pr => pr.totalComments > 0)
            .sort((a, b) => b.totalComments - a.totalComments)
            .slice(0, 5);
    }

    /**
     * Calculate merge process health
     * @param {Array} prData - Array of PR data
     * @param {Array} allPrData - All PR data for comparison
     * @returns {Object} Health status and message
     */
    static calculateMergeProcessHealth(prData, allPrData) {
        const mergedPRs = prData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.approvedAt);

        if (mergedPRs.length === 0) {
            return {
                status: 'info',
                message: 'No merge data for this period.'
            };
        }

        // Calculate average merge times for current period
        const mergeTimes = mergedPRs.map(pr => {
            const approved = new Date(pr.approvedAt);
            const merged = new Date(pr.mergedAt);
            return (merged - approved) / 60000; // minutes
        });

        const avgMergeTime = mergeTimes.reduce((a, b) => a + b, 0) / mergeTimes.length;

        // Compare with all-time data if available
        if (allPrData && allPrData.length > prData.length) {
            const allMergedPRs = allPrData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.approvedAt);
            const recentPRs = allMergedPRs.slice(-14); // Last 2 weeks
            const previousPRs = allMergedPRs.slice(-28, -14); // Previous 2 weeks

            if (recentPRs.length >= 7 && previousPRs.length >= 7) {
                const recentAvg = recentPRs.reduce((sum, pr) => {
                    const approved = new Date(pr.approvedAt);
                    const merged = new Date(pr.mergedAt);
                    return sum + (merged - approved) / 60000;
                }, 0) / recentPRs.length;

                const previousAvg = previousPRs.reduce((sum, pr) => {
                    const approved = new Date(pr.approvedAt);
                    const merged = new Date(pr.mergedAt);
                    return sum + (merged - approved) / 60000;
                }, 0) / previousPRs.length;

                if (previousAvg > 0) {
                    const change = (recentAvg - previousAvg) / previousAvg * 100;

                    if (change > HEALTH_THRESHOLDS.mergeTimeChange.warning) {
                        return {
                            status: 'warning',
                            message: `Merge process is <strong>${change.toFixed(0)}% slower</strong> this week. Let's pick up the pace!`
                        };
                    } else if (change < HEALTH_THRESHOLDS.mergeTimeChange.success) {
                        return {
                            status: 'success',
                            message: `Awesome! Merge process is <strong>${Math.abs(change).toFixed(0)}% faster</strong> this week!`
                        };
                    }
                }
            }
        }

        return {
            status: 'info',
            message: 'Merge process times are stable. Keep up the good work!'
        };
    }

    /**
     * Filter PRs by week
     * @param {Array} prData - Array of PR data
     * @param {string} weekKey - Week key (ISO string)
     * @returns {Array} Filtered PRs
     */
    static filterByWeek(prData, weekKey) {
        if (weekKey === 'all') return prData;

        return prData.filter(pr => {
            const weekStart = getWeekStartDate(pr.createdAt);
            return weekStart.toISOString() === weekKey;
        });
    }

    /**
     * Get unique weeks from PR data
     * @param {Array} prData - Array of PR data
     * @returns {Array} Array of week keys
     */
    static getUniqueWeeks(prData) {
        const weekKeys = [...new Set(prData.map(pr =>
            getWeekStartDate(pr.createdAt).toISOString()
        ))];
        return weekKeys.sort((a, b) => new Date(b) - new Date(a));
    }

    /**
     * Get unique developers from PR data
     * @param {Array} prData - Array of PR data
     * @returns {Array} Array of developer names
     */
    static getUniqueDevelopers(prData) {
        const developers = new Set();
        prData.forEach(pr => {
            developers.add(pr.author);
            if (pr.mergedBy) developers.add(pr.mergedBy);
            pr.reviewers?.forEach(r => developers.add(r));
            pr.commenters?.forEach(c => developers.add(c));
        });
        return Array.from(developers).sort();
    }
}

export default AnalyticsService;
