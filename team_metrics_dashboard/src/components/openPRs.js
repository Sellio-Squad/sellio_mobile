/**
 * Open PRs Component
 * @module components/openPRs
 * 
 * Displays list of currently open PRs
 */

import { STRINGS } from '../resources/strings.js';

/**
 * Render open PRs section
 * @param {Array} prData - Array of PR data
 */
export function renderOpenPRs(prData) {
    const container = document.getElementById('open-prs-container');
    if (!container) {
        console.error('Open PRs container not found');
        return;
    }

    // Filter for open PRs (pending or approved but not merged/closed)
    const openPRs = prData.filter(pr =>
        pr.status === 'pending' || pr.status === 'approved'
    );

    if (openPRs.length === 0) {
        container.innerHTML = `
            <div class="panel">
                <h3 class="panel-header panel-title">📂 Open PRs</h3>
                <div class="panel-body text-center py-8" style="color: #6b7280;">
                    <svg class="mx-auto h-12 w-12 mb-4" style="color: #9ca3af;" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    No open PRs at this time!
                </div>
            </div>
        `;
        return;
    }

    // Sort by created date (oldest first)
    openPRs.sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));

    const openPRsHTML = openPRs.map(pr => {
        const daysOpen = Math.floor((Date.now() - new Date(pr.createdAt)) / (1000 * 60 * 60 * 24));
        const statusBadge = pr.status === 'approved' ?
            '<span class="badge-success">Approved</span>' :
            '<span class="badge-warning">Pending</span>';

        const labels = pr.labels && pr.labels.length > 0 ?
            pr.labels.map(label => `<span class="badge">${label}</span>`).join(' ') : '';

        const draftBadge = pr.draft ? '<span class="badge" style="background: #6b7280;">Draft</span>' : '';

        const approvalText = `${pr.approvals} / ${pr.required_approvals || 2}`;
        const approvalColor = pr.approvals >= (pr.required_approvals || 2) ? '#10b981' : '#f59e0b';

        return `
            <div class="open-pr-item">
                <div class="flex items-start justify-between gap-4">
                    <div class="flex-1">
                        <div class="flex items-center gap-2 mb-2">
                            <a href="${pr.url}" target="_blank" class="font-semibold hover:underline" style="color: #8b5cf6;">
                                #${pr.number}
                            </a>
                            ${statusBadge}
                            ${draftBadge}
                            ${labels}
                        </div>
                        <div class="mb-2">${pr.title}</div>
                        <div class="text-sm" style="color: #6b7280;">
                            by ${pr.author} • ${daysOpen} days open
                        </div>
                    </div>
                    <div class="text-right">
                        <div class="font-semibold" style="color: ${approvalColor};">
                            ${approvalText} ✓
                        </div>
                        <div class="text-sm" style="color: #6b7280;">approvals</div>
                    </div>
                </div>
            </div>
        `;
    }).join('');

    container.innerHTML = `
        <div class="panel">
            <h3 class="panel-header panel-title">
                📂 Open PRs 
                <span class="badge-primary ml-2">${openPRs.length}</span>
            </h3>
            <div class="panel-body">
                ${openPRsHTML}
            </div>
        </div>
    `;
}
