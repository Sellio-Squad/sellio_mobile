// ===========================
// UI Constants
// ===========================

/**
 * UI-related constants including dimensions, animations, breakpoints, and visual elements
 */

// Chart Dimensions
export const CHART_DIMENSIONS = {
    DEFAULT_HEIGHT: 300,
    LARGE_CHART_HEIGHT: 350,
    ASPECT_RATIO: {
        WIDE: 2,
        STANDARD: 1.5,
        SQUARE: 1,
    },
};

// Animation Durations (in milliseconds)
export const ANIMATION = {
    DURATION: {
        INSTANT: 0,
        FAST: 150,
        NORMAL: 250,
        SLOW: 350,
        VERY_SLOW: 500,
    },
    EASING: {
        EASE_IN_OUT: 'cubic-bezier(0.4, 0, 0.2, 1)',
        EASE_OUT: 'cubic-bezier(0, 0, 0.2, 1)',
        EASE_IN: 'cubic-bezier(0.4, 0, 1, 1)',
        SPRING: 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
    },
    COUNTER: {
        DURATION: 1000,
        STEP_INTERVAL: 16, // ~60fps
    },
};

// Responsive Breakpoints (in pixels)
export const BREAKPOINTS = {
    MOBILE: 480,
    TABLET: 768,
    DESKTOP: 1024,
    WIDE: 1200,
    ULTRA_WIDE: 1400,
};

// Z-Index Layers
export const Z_INDEX = {
    BASE: 1,
    DROPDOWN: 10,
    STICKY: 100,
    MODAL_BACKDROP: 1000,
    MODAL: 1001,
    LOADING_OVERLAY: 9999,
    TOOLTIP: 10000,
};

// Icon Mappings
export const ICONS = {
    METRICS: {
        PRS_MERGED: '✅',
        TIME_TO_MERGE: '⚡',
        VELOCITY: '🚀',
        AWAITING_REVIEW: '🚧',
        EFFICIENCY: '📈',
        ACTIVE_PRS: '📋',
    },
    THEME: {
        LIGHT: '🌙',
        DARK: '☀️',
    },
    ACTIONS: {
        REFRESH: '🔄',
        EXPORT: '📥',
        CLOSE: '×',
        WARNING: '⚠️',
        SUCCESS: '✓',
        ERROR: '✗',
    },
    SECTIONS: {
        BOTTLENECK: '🚧',
        TEAM: '👥',
        CHART: '📊',
    },
};

// Severity Levels
export const SEVERITY = {
    LOW: 'low',
    MEDIUM: 'medium',
    HIGH: 'high',
    CRITICAL: 'critical',
};

// Severity Colors (CSS class names)
export const SEVERITY_COLORS = {
    [SEVERITY.LOW]: 'info-color',
    [SEVERITY.MEDIUM]: 'warning-color',
    [SEVERITY.HIGH]: 'danger-color',
    [SEVERITY.CRITICAL]: 'danger-color',
};

// Metric Change Types
export const CHANGE_TYPE = {
    POSITIVE: 'positive',
    NEGATIVE: 'negative',
    NEUTRAL: 'neutral',
};

// Loading States
export const LOADING_STATE = {
    IDLE: 'idle',
    LOADING: 'loading',
    SUCCESS: 'success',
    ERROR: 'error',
};

// Grid Columns
export const GRID = {
    METRICS_MIN_WIDTH: 280,
    CHARTS_MIN_WIDTH: 450,
    BOTTLENECK_MIN_WIDTH: 300,
};

// Auto-dismiss Timers (in milliseconds)
export const AUTO_DISMISS = {
    ERROR_BANNER: 10000,
    SUCCESS_MESSAGE: 5000,
    INFO_MESSAGE: 3000,
};

// Truncation Limits
export const TRUNCATE = {
    PR_TITLE: 60,
    TEAM_MEMBER_NAME: 30,
    CHART_LABEL: 20,
};

// Pagination
export const PAGINATION = {
    BOTTLENECKS_MAX: 10,
    TEAM_MEMBERS_PER_PAGE: 20,
    TOP_CONTRIBUTORS: 5,
};

// Chart Tick Limits
export const CHART_TICKS = {
    MAX_X_AXIS: 10,
    MAX_Y_AXIS: 8,
};

// Empty State Messages
export const EMPTY_STATE = {
    NO_BOTTLENECKS: '🎉 No bottlenecks detected! Great work!',
    NO_TEAM_DATA: 'No team data available',
    NO_CHART_DATA: 'No data available for this chart',
    NO_METRICS: 'No metrics data available',
};

export default {
    CHART_DIMENSIONS,
    ANIMATION,
    BREAKPOINTS,
    Z_INDEX,
    ICONS,
    SEVERITY,
    SEVERITY_COLORS,
    CHANGE_TYPE,
    LOADING_STATE,
    GRID,
    AUTO_DISMISS,
    TRUNCATE,
    PAGINATION,
    CHART_TICKS,
    EMPTY_STATE,
};
