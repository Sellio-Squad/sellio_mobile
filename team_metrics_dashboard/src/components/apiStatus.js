/**
 * API Status Component
 * @module components/apiStatus
 * 
 * Displays GitHub API connection status, cache info, and refresh controls
 */

import { githubService } from '../services/githubService.js';
import { STRINGS } from '../resources/strings.js';
import { formatDistanceToNow } from '../utils/dateUtils.js';

/**
 * Render the API status panel
 * @param {Object} status - Status object with connection, cache, and rate limit info
 */
export function renderAPIStatus(status) {
    const statusPanel = document.getElementById('api-status-panel');
    if (!statusPanel) return;

    const { isConnected, lastUpdate, cacheAge, rateLimit, error } = status;

    let statusIcon = '✅';
    let statusText = 'Connected to GitHub';
    let statusClass = 'text-green-600 dark:text-green-400';

    if (error) {
        statusIcon = '❌';
        statusText = 'Connection Error';
        statusClass = 'text-red-600 dark:text-red-400';
    } else if (!isConnected) {
        statusIcon = '⚠️';
        statusText = 'Not Configured';
        statusClass = 'text-yellow-600 dark:text-yellow-400';
    } else if (cacheAge !== null) {
        statusIcon = '💾';
        statusText = 'Using Cached Data';
        statusClass = 'text-blue-600 dark:text-blue-400';
    }

    let rateLimitHtml = '';
    if (rateLimit && rateLimit.remaining !== null) {
        const limitClass = rateLimit.isLow ? 'text-red-600 dark:text-red-400' : 'text-gray-600 dark:text-gray-400';
        const resetTime = rateLimit.resetDate ? formatDistanceToNow(rateLimit.resetDate) : 'Unknown';

        rateLimitHtml = `
            <div class="text-xs ${limitClass}">
                API Limit: ${rateLimit.remaining}/${rateLimit.limit} (resets in ${resetTime})
            </div>
        `;
    }

    let lastUpdateHtml = '';
    if (lastUpdate) {
        const updateTime = formatDistanceToNow(lastUpdate);
        lastUpdateHtml = `
            <div class="text-xs text-gray-600 dark:text-gray-400">
                Last updated ${updateTime}
            </div>
        `;
    }

    let errorHtml = '';
    if (error) {
        errorHtml = `
            <div class="mt-2 p-2 bg-red-50 dark:bg-red-900/20 rounded text-xs text-red-700 dark:text-red-300">
                ${error}
            </div>
        `;
    }

    statusPanel.innerHTML = `
        <div class="flex items-start justify-between">
            <div class="flex-1">
                <div class="flex items-center gap-2 mb-1">
                    <span class="text-lg">${statusIcon}</span>
                    <span class="font-medium ${statusClass}">${statusText}</span>
                </div>
                ${lastUpdateHtml}
                ${rateLimitHtml}
                ${errorHtml}
            </div>
            <button 
                id="refresh-github-data" 
                class="px-3 py-1 text-sm bg-indigo-600 hover:bg-indigo-700 text-white rounded transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                ${error ? 'disabled' : ''}
            >
                🔄 Refresh
            </button>
        </div>
    `;

    // Attach refresh handler
    const refreshBtn = document.getElementById('refresh-github-data');
    if (refreshBtn && !error) {
        refreshBtn.addEventListener('click', async () => {
            refreshBtn.disabled = true;
            refreshBtn.textContent = '⏳ Refreshing...';

            try {
                // This will be handled by the dashboard
                window.dispatchEvent(new CustomEvent('refresh-github-data'));
            } catch (err) {
                console.error('Refresh error:', err);
            }
        });
    }
}

/**
 * Get current API status
 * @returns {Object} Status object
 */
export function getAPIStatus() {
    const isConfigured = githubService.isConfigured();
    const cachedData = githubService.getCachedData();
    const rateLimit = githubService.getRateLimitStatus();

    let lastUpdate = null;
    let cacheAge = null;

    if (cachedData) {
        const timestamp = parseInt(localStorage.getItem('github_cache_timestamp'));
        if (timestamp) {
            lastUpdate = new Date(timestamp);
            cacheAge = Math.floor((Date.now() - timestamp) / (1000 * 60)); // minutes
        }
    }

    return {
        isConnected: isConfigured,
        lastUpdate,
        cacheAge,
        rateLimit,
        error: null
    };
}
