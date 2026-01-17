/**
 * Merge Health Component
 * @module components/mergeHealth
 */

import { STRINGS } from '../resources/strings.js';
import * as AnalyticsService from '../services/analyticsService.js';

/**
 * Render merge process health indicator
 * @param {Array} filteredData - Filtered PR data
 * @param {Array} allData - All PR data
 */
export function renderMergeProcessHealth(filteredData, allData) {
    const container = document.getElementById('merge-process-health-container');
    if (!container) return;

    const health = AnalyticsService.calculateMergeProcessHealth(filteredData, allData);
    const iconMap = { success: '✅', warning: '⚠️', info: 'ℹ️' };

    container.innerHTML = `
        <h3 class="panel-header panel-title">${STRINGS.mergeHealth.title}</h3>
        <div class="panel-body">
            <div class="health-indicator ${health.status}">
                <span class="health-icon">${iconMap[health.status]}</span>
                <span>${health.message}</span>
            </div>
        </div>
    `;
}
