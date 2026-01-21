// ===========================
// Text Constants
// ===========================

/**
 * All user-facing text content for the dashboard
 */

// Page Metadata
export const PAGE = {
    TITLE: 'Sellio Team Metrics Dashboard',
    DESCRIPTION: 'Sellio Team Metrics Dashboard - Real PR metrics and team performance tracking',
    LOGO: '📊 Sellio Metrics',
    SUBTITLE: 'Real-Time PR Performance Dashboard',
    FOOTER: '© 2026 Sellio Team Metrics Dashboard',
};

// Metric Labels
export const METRIC_LABELS = {
    PRS_MERGED: 'PRs Merged',
    AVG_TIME_TO_MERGE: 'Avg Time to Merge',
    PR_VELOCITY: 'PR Velocity',
    PRS_AWAITING_REVIEW: 'PRs Awaiting Review',
    REVIEW_EFFICIENCY: 'Review Efficiency',
    ACTIVE_PRS: 'Active PRs',
};

// Metric Descriptions (for tooltips)
export const METRIC_DESCRIPTIONS = {
    PRS_MERGED: 'Total number of pull requests successfully merged',
    AVG_TIME_TO_MERGE: 'Average time from PR creation to merge',
    PR_VELOCITY: 'Number of PRs merged in the last week',
    PRS_AWAITING_REVIEW: 'PRs waiting for review longer than the threshold',
    REVIEW_EFFICIENCY: 'Percentage of PRs approved within SLA',
    ACTIVE_PRS: 'Currently open pull requests',
};

// Status Labels
export const STATUS_LABELS = {
    PENDING: 'Pending',
    APPROVED: 'Approved',
    MERGED: 'Merged',
    CLOSED: 'Closed',
    ACTIVE: 'Active',
    IN_PROGRESS: 'In Progress',
};

// Chart Titles
export const CHART_TITLES = {
    VELOCITY: 'PR Velocity Trend',
    TIME_TO_MERGE: 'Time to Merge Distribution',
    PR_DISTRIBUTION: 'PR Distribution',
    STATUS_FLOW: 'PR Status Flow',
};

// Chart Subtitles
export const CHART_SUBTITLES = {
    VELOCITY: 'PRs opened vs merged by week',
    TIME_TO_MERGE: 'How long PRs take to merge',
    PR_DISTRIBUTION: 'Top contributors',
    STATUS_FLOW: 'PR states over time',
};

// Chart Dataset Labels
export const CHART_DATASET_LABELS = {
    OPENED: 'Opened',
    MERGED: 'Merged',
    PENDING: 'Pending',
    APPROVED: 'Approved',
    PRS: 'PRs',
};

// Section Titles
export const SECTION_TITLES = {
    BOTTLENECK: '🚧 Bottleneck Analysis',
    TEAM: '👥 Team Performance',
};

// Section Subtitles
export const SECTION_SUBTITLES = {
    BOTTLENECK: 'PRs waiting longest for review or merge',
    TEAM: 'Individual contributor metrics',
};

// Table Headers
export const TABLE_HEADERS = {
    TEAM_MEMBER: 'Team Member',
    PRS_CREATED: 'PRs Created',
    PRS_MERGED: 'PRs Merged',
    PRS_REVIEWED: 'PRs Reviewed',
    AVG_REVIEW_TIME: 'Avg Review Time',
    PRODUCTIVITY: 'Productivity',
};

// Button Labels
export const BUTTON_LABELS = {
    REFRESH: 'Refresh',
    EXPORT: 'Export',
    CLOSE: 'Close',
    TOGGLE_THEME: 'Toggle dark mode',
};

// Loading Messages
export const LOADING_MESSAGES = {
    DEFAULT: 'Loading metrics...',
    FETCHING_DATA: 'Fetching PR data...',
    CALCULATING: 'Calculating metrics...',
    RENDERING: 'Rendering charts...',
};

// Error Messages
export const ERROR_MESSAGES = {
    FETCH_FAILED: 'Failed to load metrics',
    NETWORK_ERROR: 'Network error. Please check your connection.',
    INVALID_DATA: 'Invalid data received from server',
    CHART_RENDER_FAILED: 'Failed to render chart',
    UNKNOWN_ERROR: 'An unexpected error occurred',
};

// Success Messages
export const SUCCESS_MESSAGES = {
    DATA_LOADED: 'Metrics loaded successfully',
    DATA_REFRESHED: 'Data refreshed',
    EXPORT_SUCCESS: 'Data exported successfully',
};

// Bottleneck Card Labels
export const BOTTLENECK_LABELS = {
    AUTHOR: 'Author',
    STATUS: 'Status',
    APPROVALS: 'Approvals',
    WAIT_TIME: 'Wait Time',
};

// Time Bucket Labels
export const TIME_BUCKETS = {
    '0-24h': '0-24h',
    '24-48h': '24-48h',
    '48-72h': '48-72h',
    '3-5d': '3-5d',
    '5-7d': '5-7d',
    '7d+': '7d+',
};

// Accessibility Labels
export const A11Y_LABELS = {
    THEME_TOGGLE: 'Toggle dark mode',
    REFRESH_BUTTON: 'Refresh data',
    CLOSE_ERROR: 'Close error message',
    CHART_CANVAS: 'Chart visualization',
    METRIC_CARD: 'Metric card',
};

// Format Suffixes
export const FORMAT_SUFFIXES = {
    HOURS: 'h',
    DAYS: 'd',
    WEEKS: 'w',
    MONTHS: 'mo',
    PERCENT: '%',
    THOUSAND: 'K',
    MILLION: 'M',
};

// Placeholder Text
export const PLACEHOLDERS = {
    NO_DATA: 'N/A',
    LOADING: '...',
    ZERO: '0',
};

// Last Updated Format
export const LAST_UPDATED = {
    PREFIX: 'Last updated:',
    FORMAT_OPTIONS: {
        month: 'short',
        day: 'numeric',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
    },
};

export default {
    PAGE,
    METRIC_LABELS,
    METRIC_DESCRIPTIONS,
    STATUS_LABELS,
    CHART_TITLES,
    CHART_SUBTITLES,
    CHART_DATASET_LABELS,
    SECTION_TITLES,
    SECTION_SUBTITLES,
    TABLE_HEADERS,
    BUTTON_LABELS,
    LOADING_MESSAGES,
    ERROR_MESSAGES,
    SUCCESS_MESSAGES,
    BOTTLENECK_LABELS,
    TIME_BUCKETS,
    A11Y_LABELS,
    FORMAT_SUFFIXES,
    PLACEHOLDERS,
    LAST_UPDATED,
};
