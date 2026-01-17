// ===========================
// KPI Cards Component
// ===========================

import { KPI_ICONS } from '../constants/analyticsConstants.js';

class KPICards {
    /**
     * Create a KPI card element
     * @param {Object} config - Card configuration
     * @returns {string} HTML string for KPI card
     */
    static createCard(config) {
        const {
            icon,
            iconColor = 'bg-fuchsia-500',
            value,
            label,
            valueClass = ''
        } = config;

        return `
            <div class="kpi-card">
                <div class="kpi-icon ${iconColor}">
                    ${icon}
                </div>
                <div>
                    <div class="kpi-value ${valueClass}">${value}</div>
                    <div class="kpi-label">${label}</div>
                </div>
            </div>
        `;
    }

    /**
     * Create a spotlight card (for top performers)
     * @param {Object} config - Spotlight card configuration
     * @returns {string} HTML string for spotlight card
     */
    static createSpotlightCard(config) {
        const {
            icon,
            iconColor = 'bg-orange-500',
            user,
            userAvatar,
            label
        } = config;

        if (!user) {
            return `
                <div class="kpi-card spotlight-card">
                    <div class="p-4 text-center text-secondary">No data available</div>
                </div>
            `;
        }

        return `
            <div class="kpi-card spotlight-card">
                <div class="kpi-icon ${iconColor}">
                    ${icon}
                </div>
                <div class="overflow-hidden">
                    <div class="kpi-value">
                        ${userAvatar ? `<img src="${userAvatar}" class="avatar" alt="${user}"/>` : ''}
                        <span class="truncate">${user}</span>
                    </div>
                    <div class="kpi-label">${label}</div>
                </div>
            </div>
        `;
    }

    /**
     * Render main KPI cards grid
     * @param {Object} kpis - KPI metrics object
     * @returns {string} HTML string for KPI grid
     */
    static renderKPIGrid(kpis) {
        const cards = [
            {
                icon: KPI_ICONS.totalPRs,
                iconColor: 'bg-fuchsia-500',
                value: kpis.totalPRs || 0,
                label: 'Total PRs'
            },
            {
                icon: KPI_ICONS.mergedPRs,
                iconColor: 'bg-purple-500',
                value: kpis.mergedPRs || 0,
                label: 'Merged PRs'
            },
            {
                icon: KPI_ICONS.closedPRs,
                iconColor: 'bg-red-500',
                value: kpis.closedPRs || 0,
                label: 'Closed PRs'
            },
            {
                icon: KPI_ICONS.prSize,
                iconColor: 'bg-blue-500',
                value: kpis.avgPRSize
                    ? `<span class="added">+${kpis.avgPRSize.additions}</span> <span class="removed">-${kpis.avgPRSize.deletions}</span>`
                    : '-',
                label: 'Avg. PR Size',
                valueClass: 'kpi-value-small'
            },
            {
                icon: KPI_ICONS.comments,
                iconColor: 'bg-cyan-500',
                value: kpis.totalComments || 0,
                label: 'Total Comments'
            },
            {
                icon: KPI_ICONS.avgComments,
                iconColor: 'bg-pink-500',
                value: kpis.avgComments || '0.0',
                label: 'Avg. Comments / PR'
            }
        ];

        return cards.map(card => this.createCard(card)).join('');
    }

    /**
     * Render timing KPI cards
     * @param {Object} kpis - KPI metrics object
     * @returns {string} HTML string for timing KPIs
     */
    static renderTimingKPIs(kpis) {
        const cards = [
            {
                icon: KPI_ICONS.approvalTime,
                iconColor: 'bg-sky-500',
                value: kpis.avgApprovalTime || 'N/A',
                label: 'Avg. Time to 1st Approval'
            },
            {
                icon: KPI_ICONS.lifespan,
                iconColor: 'bg-green-500',
                value: kpis.avgLifespan || 'N/A',
                label: 'Avg. PR Lifespan'
            }
        ];

        return cards.map(card => this.createCard(card)).join('');
    }

    /**
     * Render spotlight cards
     * @param {Object} spotlight - Spotlight metrics object
     * @returns {string} HTML string for spotlight cards
     */
    static renderSpotlightCards(spotlight) {
        const hotStreakCard = this.createSpotlightCard({
            icon: KPI_ICONS.hotStreak,
            iconColor: 'bg-orange-500',
            user: spotlight.hotStreak?.user,
            userAvatar: spotlight.hotStreak?.user ? `https://github.com/${spotlight.hotStreak.user}.png` : null,
            label: spotlight.hotStreak?.label || 'No activity'
        });

        const fastestReviewerCard = this.createSpotlightCard({
            icon: KPI_ICONS.fastestReviewer,
            iconColor: 'bg-teal-500',
            user: spotlight.fastestReviewer?.user,
            userAvatar: spotlight.fastestReviewer?.user ? `https://github.com/${spotlight.fastestReviewer.user}.png` : null,
            label: spotlight.fastestReviewer?.label || 'No reviews'
        });

        const topCommenterCard = this.createSpotlightCard({
            icon: KPI_ICONS.topCommenter,
            iconColor: 'bg-yellow-500',
            user: spotlight.topCommenter?.user,
            userAvatar: spotlight.topCommenter?.user ? `https://github.com/${spotlight.topCommenter.user}.png` : null,
            label: spotlight.topCommenter?.label || 'No comments'
        });

        return `
            <div id="hot-streak-card">${hotStreakCard}</div>
            <div id="fastest-reviewer-card">${fastestReviewerCard}</div>
            <div id="top-commenter-card">${topCommenterCard}</div>
        `;
    }
}

export default KPICards;
