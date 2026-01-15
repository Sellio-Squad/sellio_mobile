// ===========================
// Metrics Calculator - Business Logic
// ===========================

import CONFIG from '../config.js';

class MetricsCalculator {
    /**
     * Calculate all dashboard metrics from PR data
     * @param {Array} prs - Array of PR objects
     * @returns {Object} Calculated metrics
     */
    calculateMetrics(prs) {
        const activePRs = prs.filter(pr => pr.status === 'pending' || pr.status === 'approved');
        const mergedPRs = prs.filter(pr => pr.status === 'merged');
        const closedPRs = prs.filter(pr => pr.status === 'closed');

        return {
            prsMerged: mergedPRs.length,
            avgTimeToMerge: this._calculateAvgTimeToMerge(mergedPRs),
            prVelocity: this._calculatePRVelocity(prs),
            prsAwaitingReview: this._countPRsAwaitingReview(activePRs),
            reviewEfficiency: this._calculateReviewEfficiency(prs),
            activePRs: activePRs.length,
            changes: this._calculateChanges(prs),
        };
    }

    /**
     * Calculate average time to merge in hours
     * @private
     */
    _calculateAvgTimeToMerge(mergedPRs) {
        if (mergedPRs.length === 0) return 0;

        const totalMinutes = mergedPRs.reduce((sum, pr) => {
            if (!pr.opened_at || !pr.merged_at) return sum;
            const opened = new Date(pr.opened_at);
            const merged = new Date(pr.merged_at);
            return sum + (merged - opened) / (1000 * 60);
        }, 0);

        return (totalMinutes / mergedPRs.length / 60).toFixed(1);
    }

    /**
     * Calculate PR velocity (PRs merged per week)
     * @private
     */
    _calculatePRVelocity(prs) {
        const now = new Date();
        const oneWeekAgo = new Date(now - 7 * 24 * 60 * 60 * 1000);

        const recentMerged = prs.filter(pr => {
            if (pr.status !== 'merged' || !pr.merged_at) return false;
            return new Date(pr.merged_at) >= oneWeekAgo;
        });

        return recentMerged.length;
    }

    /**
     * Count PRs waiting for review longer than threshold
     * @private
     */
    _countPRsAwaitingReview(activePRs) {
        const thresholdMs = CONFIG.METRICS.BOTTLENECK_THRESHOLD_HOURS * 60 * 60 * 1000;
        const now = new Date();

        return activePRs.filter(pr => {
            const opened = new Date(pr.opened_at);
            const waitTime = now - opened;
            return waitTime > thresholdMs && pr.approvals.length < pr.required_approvals;
        }).length;
    }

    /**
     * Calculate review efficiency (% of PRs approved within SLA)
     * @private
     */
    _calculateReviewEfficiency(prs) {
        const prsWithApprovals = prs.filter(pr => pr.time_to_required_approvals_minutes !== null);
        if (prsWithApprovals.length === 0) return 0;

        const slaMinutes = CONFIG.METRICS.BOTTLENECK_THRESHOLD_HOURS * 60;
        const withinSLA = prsWithApprovals.filter(pr =>
            pr.time_to_required_approvals_minutes <= slaMinutes
        );

        return Math.round((withinSLA.length / prsWithApprovals.length) * 100);
    }

    /**
     * Calculate metric changes (mock for now - would need historical data)
     * @private
     */
    _calculateChanges(prs) {
        // TODO: Implement with historical data comparison
        return {
            prsMerged: '+12.5',
            timeToMerge: '-8.3',
            velocity: '+15.2',
            efficiency: '+5.7',
        };
    }

    /**
     * Generate velocity chart data by week
     */
    generateVelocityData(prs) {
        const weekMap = new Map();

        prs.forEach(pr => {
            if (!pr.week) return;

            if (!weekMap.has(pr.week)) {
                weekMap.set(pr.week, { opened: 0, merged: 0 });
            }

            const weekData = weekMap.get(pr.week);
            weekData.opened++;
            if (pr.status === 'merged') {
                weekData.merged++;
            }
        });

        const sortedWeeks = Array.from(weekMap.keys()).sort();
        const labels = sortedWeeks.map(week => week.replace(/(\d{4})-W(\d{2})/, 'W$2'));
        const opened = sortedWeeks.map(week => weekMap.get(week).opened);
        const merged = sortedWeeks.map(week => weekMap.get(week).merged);

        return { labels, opened, merged };
    }

    /**
     * Generate time to merge distribution
     */
    generateTimeToMergeDistribution(prs) {
        const mergedPRs = prs.filter(pr => pr.status === 'merged' && pr.opened_at && pr.merged_at);

        const buckets = {
            '0-24h': 0,
            '24-48h': 0,
            '48-72h': 0,
            '3-5d': 0,
            '5-7d': 0,
            '7d+': 0,
        };

        mergedPRs.forEach(pr => {
            const hours = (new Date(pr.merged_at) - new Date(pr.opened_at)) / (1000 * 60 * 60);

            if (hours <= 24) buckets['0-24h']++;
            else if (hours <= 48) buckets['24-48h']++;
            else if (hours <= 72) buckets['48-72h']++;
            else if (hours <= 120) buckets['3-5d']++;
            else if (hours <= 168) buckets['5-7d']++;
            else buckets['7d+']++;
        });

        return {
            labels: Object.keys(buckets),
            data: Object.values(buckets),
        };
    }

    /**
     * Generate PR distribution by author
     */
    generatePRDistribution(prs) {
        const authorMap = new Map();

        prs.forEach(pr => {
            const author = pr.creator.login;
            authorMap.set(author, (authorMap.get(author) || 0) + 1);
        });

        // Get top 5 authors
        const sorted = Array.from(authorMap.entries())
            .sort((a, b) => b[1] - a[1])
            .slice(0, 5);

        return {
            labels: sorted.map(([author]) => author),
            data: sorted.map(([, count]) => count),
        };
    }

    /**
     * Generate PR status flow over time
     */
    generateStatusFlow(prs) {
        const dateMap = new Map();
        const now = new Date();
        const thirtyDaysAgo = new Date(now - 30 * 24 * 60 * 60 * 1000);

        // Initialize last 30 days
        for (let i = 0; i < 30; i++) {
            const date = new Date(thirtyDaysAgo);
            date.setDate(date.getDate() + i);
            const key = date.toISOString().split('T')[0];
            dateMap.set(key, { pending: 0, approved: 0, merged: 0 });
        }

        // Count PRs by status for each day
        prs.forEach(pr => {
            const openedDate = new Date(pr.opened_at);
            if (openedDate < thirtyDaysAgo) return;

            const key = openedDate.toISOString().split('T')[0];
            if (dateMap.has(key)) {
                const dayData = dateMap.get(key);
                if (pr.status === 'merged') dayData.merged++;
                else if (pr.status === 'approved') dayData.approved++;
                else if (pr.status === 'pending') dayData.pending++;
            }
        });

        const sortedDates = Array.from(dateMap.keys()).sort();
        const labels = sortedDates.map((_, i) => `Day ${i + 1}`);
        const pending = sortedDates.map(date => dateMap.get(date).pending);
        const approved = sortedDates.map(date => dateMap.get(date).approved);
        const merged = sortedDates.map(date => dateMap.get(date).merged);

        return { labels, pending, approved, merged };
    }

    /**
     * Identify bottlenecks (PRs with longest wait times)
     */
    generateBottlenecks(prs) {
        const now = new Date();
        const activePRs = prs.filter(pr => pr.status === 'pending' || pr.status === 'approved');

        const bottlenecks = activePRs
            .map(pr => {
                const waitTimeMs = now - new Date(pr.opened_at);
                const waitTimeHours = waitTimeMs / (1000 * 60 * 60);
                const waitTimeDays = (waitTimeHours / 24).toFixed(1);

                let severity = 'low';
                if (waitTimeHours > 72) severity = 'high';
                else if (waitTimeHours > CONFIG.METRICS.BOTTLENECK_THRESHOLD_HOURS) severity = 'medium';

                return {
                    title: pr.title,
                    prNumber: pr.pr_number,
                    url: pr.url,
                    severity,
                    author: pr.creator.login,
                    waitTime: `${waitTimeDays} days`,
                    waitTimeHours,
                    approvals: pr.approvals.length,
                    requiredApprovals: pr.required_approvals,
                    status: pr.status,
                };
            })
            .filter(b => b.waitTimeHours > 24) // Only show PRs waiting > 24h
            .sort((a, b) => b.waitTimeHours - a.waitTimeHours)
            .slice(0, 10); // Top 10 bottlenecks

        return bottlenecks;
    }

    /**
     * Generate team performance metrics
     */
    generateTeamPerformance(prs) {
        const memberMap = new Map();

        // Aggregate data by member
        prs.forEach(pr => {
            const author = pr.creator.login;

            if (!memberMap.has(author)) {
                memberMap.set(author, {
                    name: author,
                    prsCreated: 0,
                    prsMerged: 0,
                    prsReviewed: 0,
                    totalReviewTime: 0,
                    reviewCount: 0,
                });
            }

            const member = memberMap.get(author);
            member.prsCreated++;
            if (pr.status === 'merged') member.prsMerged++;

            // Count reviews by this member on other PRs
            prs.forEach(otherPr => {
                if (otherPr.pr_number === pr.pr_number) return;
                const reviewed = otherPr.approvals.some(approval => approval.reviewer.login === author);
                if (reviewed) {
                    member.prsReviewed++;
                    if (otherPr.time_to_first_approval_minutes) {
                        member.totalReviewTime += otherPr.time_to_first_approval_minutes;
                        member.reviewCount++;
                    }
                }
            });
        });

        // Calculate averages and format
        return Array.from(memberMap.values())
            .map(member => ({
                name: member.name,
                prsCreated: member.prsCreated,
                prsMerged: member.prsMerged,
                prsReviewed: member.prsReviewed,
                avgReviewTime: member.reviewCount > 0
                    ? `${(member.totalReviewTime / member.reviewCount / 60).toFixed(1)}h`
                    : 'N/A',
                productivity: Math.min(100, Math.round((member.prsMerged / Math.max(1, member.prsCreated)) * 100)),
            }))
            .sort((a, b) => b.prsMerged - a.prsMerged);
    }
}

export default new MetricsCalculator();
