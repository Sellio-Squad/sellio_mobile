// ===========================
// Analytics Constants
// ===========================

export const PR_TYPE_COLORS = {
    fix: '#ef4444',
    feature: '#3b82f6',
    chore: '#6b7280',
    refactor: '#f97316',
    docs: '#14b8a6',
    other: '#a855f7'
};

export const PR_TYPE_PATTERNS = {
    fix: /^fix/i,
    feature: /^feat/i,
    chore: /^chore/i,
    refactor: /^refactor/i,
    docs: /^docs/i
};

export const KPI_ICONS = {
    totalPRs: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="18" cy="18" r="3"></circle>
        <circle cx="6" cy="6" r="3"></circle>
        <path d="M13 6h3a2 2 0 0 1 2 2v7"></path>
        <line x1="6" y1="9" x2="6" y2="21"></line>
    </svg>`,

    mergedPRs: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="18" cy="18" r="3"></circle>
        <circle cx="6" cy="6" r="3"></circle>
        <path d="M6 21V9a9 9 0 0 0 9 9"></path>
    </svg>`,

    closedPRs: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M17,15.59L15.59,17L12,13.41L8.41,17L7,15.59L10.59,12L7,8.41L8.41,7L12,10.59L15.59,7L17,8.41L13.41,12L17,15.59Z"/>
    </svg>`,

    prSize: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M12,6L17,11H7L12,6M7,13H17V15H7V13M7,17H17V19H7V17Z"/>
    </svg>`,

    comments: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M18,14H19V15H18V14M18,11H21V12H18V11M18,8H21V9H18V8M5,14H6V15H5V14M5,11H8V12H5V11M5,8H8V9H5V8M12,4C7.58,4 4,7.58 4,12C4,16.42 7.58,20 12,20C16.42,20 20,16.42 20,12C20,7.58 16.42,4 12,4Z" />
    </svg>`,

    avgComments: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M9,22A1,1 0 0,1 8,21V18H4A2,2 0 0,1 2,16V4C2,2.89 2.9,2 4,2H20A2,2 0 0,1 22,4V16A2,2 0 0,1 20,18H13.9L10.2,21.71C10,21.9 9.75,22 9.5,22V22H9M10,16V19.08L13.08,16H20V4H4V16H10M6,7H18V9H6V7M6,11H15V13H6V11Z" />
    </svg>`,

    approvalTime: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M16.2,16.2L11,13V7H12.5V12.2L17,14.9L16.2,16.2Z"/>
    </svg>`,

    lifespan: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M11,16.5L6.5,12L7.91,10.59L11,13.67L16.59,8.09L18,9.5L11,16.5Z"/>
    </svg>`,

    hotStreak: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M12,17.27L18.18,21L17,14.64L22,9.24L14.81,8.62L12,2L9.19,8.62L2,9.24L7,14.64L5.82,21L12,17.27Z" />
    </svg>`,

    fastestReviewer: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M11,15H6L13,1V9H18L11,23V15Z" />
    </svg>`,

    topCommenter: `<svg viewBox="0 0 24 24" fill="currentColor">
        <path d="M9,22A1,1 0 0,1 8,21V18H4A2,2 0 0,1 2,16V4C2,2.89 2.9,2 4,2H20A2,2 0 0,1 22,4V16A2,2 0 0,1 20,18H13.9L10.2,21.71C10,21.9 9.75,22 9.5,22V22H9M10,16V19.08L13.08,16H20V4H4V16H10M6,7H18V9H6V7M6,11H15V13H6V11Z" />
    </svg>`
};

export const HEALTH_ICONS = {
    safe: `<svg class="icon" fill="currentColor" viewBox="0 0 20 20">
        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
    </svg>`,

    warning: `<svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
    </svg>`,

    info: `<svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
    </svg>`
};

export const HEALTH_THRESHOLDS = {
    mergeTimeChange: {
        warning: 15,  // % increase
        success: -15  // % decrease
    }
};

export const WEEK_CONFIG = {
    startDay: 6, // Saturday (0 = Sunday, 6 = Saturday)
    startHour: 19 // 7 PM
};

export const CHART_COLORS = {
    primary: 'rgba(79, 70, 229, 0.7)',
    success: 'rgba(16, 185, 129, 0.7)',
    warning: 'rgba(249, 115, 22, 0.7)',
    danger: 'rgba(239, 68, 68, 0.7)',
    info: 'rgba(2, 132, 199, 0.7)',
    purple: 'rgba(168, 85, 247, 0.7)'
};

export default {
    PR_TYPE_COLORS,
    PR_TYPE_PATTERNS,
    KPI_ICONS,
    HEALTH_ICONS,
    HEALTH_THRESHOLDS,
    WEEK_CONFIG,
    CHART_COLORS
};
