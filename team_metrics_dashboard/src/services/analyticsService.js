/**
 * Analytics service - Business logic and calculations
 * @module services/analyticsService
 */

import { PR_TYPE_PATTERNS, ANALYTICS, BOTTLENECK } from '../config/constants.js';
import { STRINGS } from '../resources/strings.js';
import { getWeekStartDate } from '../utils/dateUtils.js';
import { formatDetailedDuration } from '../utils/formatters.js';

/**
 * Calculate KPI metrics from PR data
 * @param {Array} prData - Array of PR objects
 * @param {string} developerFilter - Developer to filter by ('all' for all developers)
 * @returns {Object} KPI metrics
 */
export function calculateKPIs(prData, developerFilter = 'all') {
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

    const totalAdditions = filteredData.reduce((sum, pr) => sum + (pr.additions || 0), 0);
    const totalDeletions = filteredData.reduce((sum, pr) => sum + (pr.deletions || 0), 0);
    const avgAdditions = totalPRs > 0 ? (totalAdditions / totalPRs).toFixed(0) : 0;
    const avgDeletions = totalPRs > 0 ? (totalDeletions / totalPRs).toFixed(0) : 0;

    const totalComments = filteredData.reduce((sum, pr) => sum + (pr.comments || 0), 0);
    const avgComments = totalPRs > 0 ? (totalComments / totalPRs).toFixed(1) : '0.0';

    const approvalTimes = filteredData
        .map(pr => pr.timeToFirstApproval)
        .filter(t => t !== null && t !== undefined && t >= 0);
    const avgApprovalTime = approvalTimes.length > 0
        ? approvalTimes.reduce((a, b) => a + b, 0) / approvalTimes.length
        : null;

    const mergedData = filteredData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.createdAt);
    const lifespans = mergedData.map(pr => {
        const created = new Date(pr.createdAt);
        const merged = new Date(pr.mergedAt);
        return (merged - created) / 60000;
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
 * @param {Array} prData - Array of PR objects
 * @param {string} developerFilter - Developer to filter by
 * @returns {Object} Spotlight metrics
 */
export function calculateSpotlightMetrics(prData, developerFilter = 'all') {
    if (developerFilter !== 'all') {
        const developerPRs = prData.filter(pr => pr.author === developerFilter);
        const prCommentCount = prData.filter(pr => pr.commenters?.includes(developerFilter)).length;

        return {
            hotStreak: {
                user: developerFilter,
                count: developerPRs.length,
                label: `${STRINGS.spotlight.createdPRs} ${developerPRs.length} PRs`
            },
            fastestReviewer: null,
            topCommenter: {
                user: developerFilter,
                count: prCommentCount,
                label: `Commented on ${prCommentCount} PRs`
            }
        };
    }

    const recentActivity = prData.reduce((acc, pr) => {
        acc[pr.author] = (acc[pr.author] || 0) + 1;
        if (pr.mergedBy) acc[pr.mergedBy] = (acc[pr.mergedBy] || 0) + 1;
        pr.reviewers?.forEach(reviewer => {
            if (reviewer !== pr.author) acc[reviewer] = (acc[reviewer] || 0) + 1;
        });
        return acc;
    }, {});

    const hotStreakUser = Object.entries(recentActivity).sort((a, b) => b[1] - a[1])[0];

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

    const commenterCounts = prData.reduce((acc, pr) => {
        pr.commenters?.forEach(commenter => {
            acc[commenter] = (acc[commenter] || 0) + 1;
        });
        return acc;
    }, {});

    const topCommenter = Object.entries(commenterCounts).sort((a, b) => b[1] - a[1])[0];

    return {
        hotStreak: hotStreakUser ? {
            user: hotStreakUser[0],
            count: hotStreakUser[1],
            label: `${hotStreakUser[1]} ${STRINGS.spotlight.hotStreak}`
        } : null,
        fastestReviewer: fastestReviewer ? {
            user: fastestReviewer.user,
            avg: fastestReviewer.avg,
            label: `${STRINGS.spotlight.avgReviewTime} ${formatDetailedDuration(fastestReviewer.avg)}`
        } : null,
        topCommenter: topCommenter ? {
            user: topCommenter[0],
            count: topCommenter[1],
            label: `${topCommenter[1]} ${STRINGS.spotlight.commentedPRs}`
        } : null
    };
}

/**
 * Generate daily activity breakdown grouped by week
 * @param {Array} prData - Array of PR objects
 * @returns {Object} Daily activity data
 */
export function generateDailyActivity(prData) {
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

    const dailyActivityByWeek = Object.keys(dailyActivity)
        .sort((a, b) => new Date(b) - new Date(a))
        .reduce((acc, dayString) => {
            const weekStartDate = getWeekStartDate(dayString);
            const weekKey = weekStartDate.toISOString();
            if (!acc[weekKey]) acc[weekKey] = [];
            acc[weekKey].push(dayString);
            return acc;
        }, {});

    return { dailyActivity, dailyActivityByWeek };
}

/**
 * Analyze PR types distribution
 * @param {Array} prData - Array of PR objects
 * @returns {Array} PR type statistics
 */
export function analyzePRTypes(prData) {
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
            acc[type] = { count: 0 };
        }
        acc[type].count++;

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
 * Calculate collaboration pairs (who reviews whose PRs)
 * @param {Array} prData - Array of PR objects
 * @returns {Array} Collaboration statistics
 */
export function calculateCollaborationPairs(prData) {
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
        .slice(0, ANALYTICS.TOP_COLLABORATORS_COUNT);
}

/**
 * Get most discussed PRs
 * @param {Array} prData - Array of PR objects
 * @returns {Array} Most discussed PRs
 */
export function getMostDiscussedPRs(prData) {
    return prData
        .map(pr => ({
            ...pr,
            totalComments: pr.comments || 0
        }))
        .filter(pr => pr.totalComments > 0)
        .sort((a, b) => b.totalComments - a.totalComments)
        .slice(0, ANALYTICS.TOP_DISCUSSED_PRS_COUNT);
}

/**
 * Calculate merge process health
 * @param {Array} prData - PR data to analyze
 * @param {Array} allPrData - All PR data for context
 * @returns {Object} Health status and message
 */
export function calculateMergeProcessHealth(prData, allPrData) {
    const mergedPRs = prData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.approvedAt);

    if (mergedPRs.length === 0) {
        return {
            status: 'info',
            message: STRINGS.mergeHealth.noData
        };
    }

    const mergeTimes = mergedPRs.map(pr => {
        const approved = new Date(pr.approvedAt);
        const merged = new Date(pr.mergedAt);
        return (merged - approved) / 60000;
    });

    const avgMergeTime = mergeTimes.reduce((a, b) => a + b, 0) / mergeTimes.length;

    if (avgMergeTime < ANALYTICS.MERGE_TIME_FAST_THRESHOLD) {
        return {
            status: 'success',
            message: STRINGS.mergeHealth.excellent
        };
    } else if (avgMergeTime < ANALYTICS.MERGE_TIME_SLOW_THRESHOLD) {
        return {
            status: 'info',
            message: STRINGS.mergeHealth.good
        };
    } else {
        return {
            status: 'warning',
            message: STRINGS.mergeHealth.needsImprovement
        };
    }
}

/**
 * Filter PRs by week
 * @param {Array} prData - Array of PR objects
 * @param {string} weekKey - Week key (ISO string) or 'all'
 * @returns {Array} Filtered PR data
 */
export function filterByWeek(prData, weekKey) {
    if (weekKey === 'all') return prData;

    return prData.filter(pr => {
        const weekStart = getWeekStartDate(pr.createdAt);
        return weekStart.toISOString() === weekKey;
    });
}

/**
 * Get unique weeks from PR data
 * @param {Array} prData - Array of PR objects
 * @returns {Array} Array of week keys (ISO strings)
 */
export function getUniqueWeeks(prData) {
    const weekKeys = [...new Set(prData.map(pr =>
        getWeekStartDate(pr.createdAt).toISOString()
    ))];
    return weekKeys.sort((a, b) => new Date(b) - new Date(a));
}

/**
 * Get unique developers from PR data
 * @param {Array} prData - Array of PR objects
 * @returns {Array} Array of developer usernames
 */
export function getUniqueDevelopers(prData) {
    const developers = new Set();
    prData.forEach(pr => {
        developers.add(pr.author);
        if (pr.mergedBy) developers.add(pr.mergedBy);
        pr.reviewers?.forEach(r => developers.add(r));
        pr.commenters?.forEach(c => developers.add(c));
    });
    return Array.from(developers).sort();
}

/**
 * Identify bottleneck PRs (stuck in review)
 * @param {Array} prData - Array of PR objects
 * @param {number} thresholdHours - Hours before PR is considered bottleneck
 * @returns {Array} Array of bottleneck PRs with severity
 */
export function identifyBottlenecks(prData, thresholdHours = BOTTLENECK.DEFAULT_THRESHOLD_HOURS) {
    const now = new Date();

    const bottlenecks = prData
        .filter(pr => pr.status === 'pending' || (pr.status !== 'merged' && pr.status !== 'closed'))
        .map(pr => {
            const createdAt = new Date(pr.createdAt);
            const waitTimeMs = now - createdAt;
            const waitTimeHours = waitTimeMs / (60 * 60 * 1000);
            const waitTimeDays = waitTimeHours / 24;

            // Determine severity based on wait time
            let severity = 'low';
            if (waitTimeHours >= thresholdHours * BOTTLENECK.SEVERITY_HIGH_MULTIPLIER) {
                severity = 'high';
            } else if (waitTimeHours >= thresholdHours * BOTTLENECK.SEVERITY_MEDIUM_MULTIPLIER) {
                severity = 'medium';
            }

            return {
                ...pr,
                waitTimeHours,
                waitTimeDays,
                severity
            };
        })
        .filter(pr => pr.waitTimeHours >= thresholdHours)
        .sort((a, b) => b.waitTimeHours - a.waitTimeHours)
        .slice(0, BOTTLENECK.MAX_DISPLAY_COUNT);

    return bottlenecks;
}
