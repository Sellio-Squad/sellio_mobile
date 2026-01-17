/**
 * All other components combined for efficiency
 * Includes: Daily Activity, PR Types, Collaboration, Discussed PRs
 * @module components/otherComponents
 */

import { STRINGS } from '../resources/strings.js';
import { PR_TYPE_COLORS } from '../config/constants.js';
import { isToday } from '../utils/dateUtils.js';
import * as AnalyticsService from '../services/analyticsService.js';

export { renderDailyActivity, renderPRTypes, renderCollaboration, renderDiscussedPRs };

function renderDailyActivity(filteredData) {
    const container = document.getElementById('daily-breakdown-container');
    if (!container) return;

    const { dailyActivity, dailyActivityByWeek } = AnalyticsService.generateDailyActivity(filteredData);

    if (Object.keys(dailyActivityByWeek).length === 0) {
        container.innerHTML = `<p class="text-center" style="color: #9ca3af;">${STRINGS.dailyActivity.noData}</p>`;
        return;
    }

    let html = '';
    const sortedWeeks = Object.keys(dailyActivityByWeek).sort((a, b) => new Date(b) - new Date(a));

    sortedWeeks.forEach((weekKey, index) => {
        const weekDays = dailyActivityByWeek[weekKey];
        const weekTitle = index === 0 ? STRINGS.dailyActivity.currentWeek : `${STRINGS.dailyActivity.week} ${index + 1}`;

        const dayCards = weekDays.map(day => {
            const { created, merged, approvals } = dailyActivity[day];
            const dateObj = new Date(day);
            const dayIsToday = isToday(day);

            return `
                <div class="day-card ${dayIsToday ? 'today' : ''}">
                    <div class="day-label">${dateObj.toLocaleDateString('en-US', { weekday: 'short' })}</div>
                    <div class="day-number">${dateObj.getDate()}</div>
                    <div class="day-stats">
                        ${created.length > 0 ? `<div class="day-stat-item created"><strong>${created.length}</strong> ${STRINGS.dailyActivity.opened}</div>` : ''}
                        ${merged > 0 ? `<div class="day-stat-item merged"><strong>${merged}</strong> ${STRINGS.dailyActivity.merged}</div>` : ''}
                        ${approvals > 0 ? `<div class="day-stat-item approvals"><strong>${approvals}</strong> ${STRINGS.dailyActivity.reviews}</div>` : ''}
                    </div>
                </div>
            `;
        }).join('');

        html += `
            <div class="daily-week-group ${index > 0 ? 'collapsed' : ''}">
                <h4 class="daily-week-header">${weekTitle}</h4>
                <div class="daily-week-content">
                    <div class="daily-breakdown-grid">${dayCards}</div>
                </div>
            </div>
        `;
    });

    container.innerHTML = html;

    container.querySelectorAll('.daily-week-header').forEach(header => {
        header.addEventListener('click', () => {
            header.parentElement.classList.toggle('collapsed');
        });
    });
}

function renderPRTypes(filteredData) {
    const container = document.getElementById('pr-type-trends-container');
    if (!container) return;

    const prTypes = AnalyticsService.analyzePRTypes(filteredData);

    const cardsHTML = prTypes.map(({ type, count, percentage }) => `
        <div class="pr-type-card">
            <div class="pr-type-header">
                <div class="pr-type-icon" style="background-color:${PR_TYPE_COLORS[type]}"></div>
                <div class="pr-type-title">
                    <span class="capitalize">${type}</span>
                    <div class="pr-type-bar">
                        <div class="pr-type-fill" style="width:${percentage}%;background-color:${PR_TYPE_COLORS[type]}"></div>
                    </div>
                </div>
                <span class="pr-type-count">${count} ${STRINGS.prTypes.prs}</span>
            </div>
        </div>
    `).join('');

    container.innerHTML = `
        <h3 class="panel-header panel-title">${STRINGS.prTypes.title}</h3>
        <div class="panel-body">
            <div class="pr-type-grid">${cardsHTML}</div>
        </div>
    `;
}

function renderCollaboration(filteredData) {
    const container = document.getElementById('collaboration-list');
    if (!container) return;

    const pairs = AnalyticsService.calculateCollaborationPairs(filteredData);

    if (pairs.length === 0) {
        container.innerHTML = `<li>${STRINGS.collaboration.noData}</li>`;
        return;
    }

    container.innerHTML = pairs.slice(0, 10).map(item => `
        <li>
            <div class="reviewer-summary">
                <a href="https://github.com/${item.reviewer}" target="_blank">
                    <img src="https://github.com/${item.reviewer}.png" class="avatar" alt="${item.reviewer}" onerror="this.src='https://via.placeholder.com/40'">
                    <span>${item.reviewer}</span>
                </a>
                <span class="text-secondary">${STRINGS.collaboration.reviewed}</span>
                <div class="collaborator-avatar-stack">
                    ${item.collaborators.slice(0, 5).map(c => `
                        <a href="https://github.com/${c}" target="_blank" title="${c}">
                            <img src="https://github.com/${c}.png" class="collaborator-avatar" alt="${c}" onerror="this.src='https://via.placeholder.com/24'">
                        </a>
                    `).join('')}
                </div>
            </div>
            <span class="collaboration-count">${item.totalReviews} ${STRINGS.collaboration.total}</span>
        </li>
    `).join('');
}

function renderDiscussedPRs(filteredData) {
    const container = document.getElementById('most-discussed-prs-list');
    if (!container) return;

    const discussed = AnalyticsService.getMostDiscussedPRs(filteredData);

    if (discussed.length === 0) {
        container.innerHTML = `<li>${STRINGS.discussed.noData}</li>`;
        return;
    }

    container.innerHTML = discussed.map(pr => `
        <li>
            <div class="discussed-pr-summary">
                <span class="discussed-pr-link">#${pr.number} ${pr.title}</span>
            </div>
            <span class="discussed-pr-count">${pr.totalComments} ${STRINGS.discussed.comments}</span>
        </li>
    `).join('');
}
