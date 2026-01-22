/**
 * Contribution Leaderboard Component
 * @module components/leaderboard
 * 
 * Ranks developers by their contributions
 */

import { STRINGS } from '../resources/strings.js';
import * as AnalyticsService from '../services/analyticsService.js';

/**
 * Calculate leaderboard rankings
 * @param {Array} prData - Array of PR data
 * @returns {Array} Ranked developers
 */
function calculateLeaderboard(prData) {
    const devStats = {};

    prData.forEach(pr => {
        // Track PR author
        if (!devStats[pr.author]) {
            devStats[pr.author] = {
                name: pr.author,
                prsCreated: 0,
                prsMerged: 0,
                approvalsGiven: 0,
                commentsGiven: 0,
                score: 0
            };
        }

        devStats[pr.author].prsCreated++;
        if (pr.status === 'merged') {
            devStats[pr.author].prsMerged++;
        }

        // Track reviewers
        pr.reviewers?.forEach(reviewer => {
            if (!devStats[reviewer]) {
                devStats[reviewer] = {
                    name: reviewer,
                    prsCreated: 0,
                    prsMerged: 0,
                    approvalsGiven: 0,
                    commentsGiven: 0,
                    score: 0
                };
            }
            devStats[reviewer].approvalsGiven++;
        });

        // Track commenters
        pr.commenters?.forEach(commenter => {
            if (!devStats[commenter]) {
                devStats[commenter] = {
                    name: commenter,
                    prsCreated: 0,
                    prsMerged: 0,
                    approvalsGiven: 0,
                    commentsGiven: 0,
                    score: 0
                };
            }
            devStats[commenter].commentsGiven++;
        });
    });

    // Calculate scores (PRs created: 3pts, PRs merged: 5pts, Approvals: 2pts, Comments: 1pt)
    Object.values(devStats).forEach(dev => {
        dev.score = (dev.prsCreated * 3) + (dev.prsMerged * 5) + (dev.approvalsGiven * 2) + (dev.commentsGiven * 1);
    });

    // Sort by score
    return Object.values(devStats).sort((a, b) => b.score - a.score);
}

/**
 * Render contribution leaderboard
 * @param {Array} prData - Array of PR data
 */
export function renderLeaderboard(prData) {
    const container = document.getElementById('leaderboard-container');
    if (!container) {
        console.error('Leaderboard container not found');
        return;
    }

    const rankings = calculateLeaderboard(prData);
    const topN = 10; // Show top 10

    const rankingsHTML = rankings.slice(0, topN).map((dev, index) => {
        const rank = index + 1;
        let rankBadge = '';

        if (rank === 1) rankBadge = '🥇';
        else if (rank === 2) rankBadge = '🥈';
        else if (rank === 3) rankBadge = '🥉';
        else rankBadge = `#${rank}`;

        return `
            <div class="leaderboard-item">
                <div class="leaderboard-rank">${rankBadge}</div>
                <div class="leaderboard-info">
                    <div class="leaderboard-name">${dev.name}</div>
                    <div class="leaderboard-stats">
                        ${dev.prsCreated} PRs • ${dev.prsMerged} merged • ${dev.approvalsGiven} reviews • ${dev.commentsGiven} comments
                    </div>
                </div>
                <div class="leaderboard-score">
                    <div class="text-xl font-bold" style="color: #8b5cf6;">${dev.score}</div>
                    <div class="text-xs" style="color: #6b7280;">points</div>
                </div>
            </div>
        `;
    }).join('');

    container.innerHTML = `
        <div class="panel">
            <h3 class="panel-header panel-title">🏆 Contribution Leaderboard</h3>
            <div class="panel-body">
                ${rankingsHTML}
            </div>
        </div>
    `;
}
