/**
 * Bottleneck Panel Component
 * @module components/bottleneckPanel
 */

import { STRINGS } from '../resources/strings.js';
import * as AnalyticsService from '../services/analyticsService.js';

/**
 * Render bottleneck analysis panel
 * @param {Array} filteredData - Filtered PR data
 */
export function renderBottlenecks(filteredData) {
    const container = document.getElementById('bottleneck-list');
    if (!container) return;

    const bottlenecks = AnalyticsService.identifyBottlenecks(filteredData);

    if (bottlenecks.length === 0) {
        container.innerHTML = `
            <div class="text-center py-8" style="color: var(--text-secondary);">
                <p>${STRINGS.bottleneck.noBottlenecks}</p>
            </div>
        `;
        return;
    }

    container.innerHTML = bottlenecks.map(pr => `
        <div class="bottleneck-card severity-${pr.severity}">
            <div class="bottleneck-header">
                <div class="bottleneck-title">
                    <a href="${pr.url}" target="_blank">#${pr.number} ${pr.title}</a>
                </div>
                <span class="bottleneck-severity ${pr.severity}">
                    ${STRINGS.bottleneck.severity[pr.severity]}
                </span>
            </div>
            <div class="bottleneck-meta">
                <div class="bottleneck-meta-item">
                    <span>${STRINGS.bottleneck.author}</span>
                    <strong>${pr.author}</strong>
                </div>
                <div class="bottleneck-meta-item">
                    <span>${STRINGS.bottleneck.status}</span>
                    <strong>${pr.status}</strong>
                </div>
                <div class="bottleneck-meta-item">
                    <span>${STRINGS.bottleneck.approvals}</span>
                    <strong>${pr.approvals || 0}</strong>
                </div>
                <div class="bottleneck-meta-item">
                    <span>${STRINGS.bottleneck.waitTime}</span>
                    <span class="bottleneck-wait-time">
                        ${pr.waitTimeDays >= 1
            ? `${pr.waitTimeDays.toFixed(1)} ${STRINGS.time.days}`
            : `${pr.waitTimeHours.toFixed(1)} ${STRINGS.time.hours}`}
                    </span>
                </div>
            </div>
        </div>
    `).join('');
}
