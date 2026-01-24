/**
 * Review Load Distribution Component
 * @module components/reviewLoad
 * 
 * Visualizes review workload across team members
 */

import { STRINGS } from '../resources/strings.js';

/**
 * Calculate review load statistics
 * @param {Array} prData - Array of PR data
 * @returns {Array} Review load stats per reviewer
 */
function calculateReviewLoad(prData) {
    const reviewStats = {};

    prData.forEach(pr => {
        // Count reviews per developer
        pr.reviewers?.forEach(reviewer => {
            if (!reviewStats[reviewer]) {
                reviewStats[reviewer] = {
                    name: reviewer,
                    reviewCount: 0,
                    totalReviewTime: 0,
                    reviews: []
                };
            }

            reviewStats[reviewer].reviewCount++;

            // Track review time (time to first approval for this reviewer)
            if (pr.timeToFirstApproval && pr.firstReviewer === reviewer) {
                reviewStats[reviewer].totalReviewTime += pr.timeToFirstApproval;
                reviewStats[reviewer].reviews.push(pr.timeToFirstApproval);
            }
        });
    });

    // Calculate average review time
    Object.values(reviewStats).forEach(stats => {
        stats.avgReviewTime = stats.reviews.length > 0 ?
            stats.totalReviewTime / stats.reviews.length : 0;
    });

    // Sort by review count
    return Object.values(reviewStats).sort((a, b) => b.reviewCount - a.reviewCount);
}

/**
 * Render review load distribution
 * @param {Array} prData - Array of PR data
 */
export function renderReviewLoad(prData) {
    const container = document.getElementById('review-load-container');
    if (!container) {
        console.error('Review load container not found');
        return;
    }

    const reviewLoad = calculateReviewLoad(prData);

    if (reviewLoad.length === 0) {
        container.innerHTML = `
            <div class="panel">
                <h3 class="panel-header panel-title">📊 Review Load Distribution</h3>
                <div class="panel-body text-center py-8" style="color: #6b7280;">
                    No review data available
                </div>
            </div>
        `;
        return;
    }

    // Find max review count for scaling bars
    const maxReviews = Math.max(...reviewLoad.map(r => r.reviewCount));

    const reviewLoadHTML = reviewLoad.map(reviewer => {
        const barWidth = (reviewer.reviewCount / maxReviews) * 100;
        const avgTimeFormatted = reviewer.avgReviewTime > 0 ?
            `${Math.round(reviewer.avgReviewTime)} min avg` :
            'N/A';

        return `
            <div class="review-load-item">
                <div class="review-load-header">
                    <span class="font-semibold">${reviewer.name}</span>
                    <span style="color: #6b7280;">
                        ${reviewer.reviewCount} reviews • ${avgTimeFormatted}
                    </span>
                </div>
                <div class="review-load-bar-container">
                    <div class="review-load-bar" style="width: ${barWidth}%; background: linear-gradient(90deg, #8b5cf6, #a78bfa);">
                    </div>
                </div>
            </div>
        `;
    }).join('');

    container.innerHTML = `
        <div class="panel">
            <h3 class="panel-header panel-title">📊 Review Load Distribution</h3>
            <div class="panel-body">
                ${reviewLoadHTML}
            </div>
        </div>
    `;
}
