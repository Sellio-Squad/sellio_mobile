/**
 * KPI Cards Component
 * @module components/kpiCards
 */

import { STRINGS } from '../resources/strings.js';
import { formatPRSize } from '../utils/formatters.js';

/**
 * Render KPI cards with data
 * @param {Object} kpis - KPI data object
 */
export function renderKPICards(kpis) {
    setText('kpi-total-prs', kpis.totalPRs);
    setText('kpi-total-merged', kpis.mergedPRs);
    setText('kpi-total-closed', kpis.closedPRs);
    setText('kpi-avg-pr-size', formatPRSize(kpis.avgPRSize.additions, kpis.avgPRSize.deletions));
    setText('kpi-total-comments', kpis.totalComments);
    setText('kpi-avg-comments', kpis.avgComments);
    setText('kpi-avg-approval-time', kpis.avgApprovalTime);
    setText('kpi-avg-lifespan', kpis.avgLifespan);
}

/**
 * Render a spotlight card
 * @param {string} cardId - DOM element ID
 * @param {Object|null} data - Spotlight data
 * @param {string} emoji - Emoji icon
 */
export function renderSpotlightCard(cardId, data, emoji) {
    const card = document.getElementById(cardId);
    if (!card) return;

    if (!data || !data.user) {
        card.innerHTML = `<div class="p-4 text-center" style="color: #9ca3af;">${STRINGS.spotlight.noData}</div>`;
        return;
    }

    card.innerHTML = `
        <div class="kpi-icon bg-orange-500">
            <span style="font-size: 1.5rem;">${emoji}</span>
        </div>
        <div>
            <div class="kpi-value flex items-center gap-2">
                <img src="https://github.com/${data.user}.png" class="w-8 h-8 rounded-full" alt="${data.user}" onerror="this.src='https://via.placeholder.com/32'">
                <span class="truncate">${data.user}</span>
            </div>
            <div class="kpi-label">${data.label}</div>
        </div>
    `;
}

/**
 * Set text content of an element
 * @param {string} id - Element ID
 * @param {string|number} text - Text to set
 */
function setText(id, text) {
    const el = document.getElementById(id);
    if (el) el.textContent = text || '-';
}
