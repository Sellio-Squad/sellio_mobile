// ===========================
// Chart Constants
// ===========================

/**
 * Chart.js configuration constants including colors, options, and defaults
 */

// Chart Colors
export const CHART_COLORS = {
    PRIMARY: '#6366f1',
    SECONDARY: '#8b5cf6',
    SUCCESS: '#10b981',
    WARNING: '#f59e0b',
    DANGER: '#ef4444',
    INFO: '#3b82f6',
    ACCENT: '#ec4899',
    NEUTRAL: '#9ca3af',
};

// Chart Color Palettes
export const COLOR_PALETTES = {
    VELOCITY: {
        OPENED: CHART_COLORS.PRIMARY,
        MERGED: CHART_COLORS.SUCCESS,
    },
    TIME_TO_MERGE: [
        CHART_COLORS.SUCCESS,
        CHART_COLORS.INFO,
        CHART_COLORS.PRIMARY,
        CHART_COLORS.SECONDARY,
        CHART_COLORS.WARNING,
        CHART_COLORS.DANGER,
    ],
    PR_DISTRIBUTION: [
        CHART_COLORS.PRIMARY,
        CHART_COLORS.SECONDARY,
        CHART_COLORS.ACCENT,
        CHART_COLORS.SUCCESS,
        CHART_COLORS.WARNING,
    ],
    STATUS_FLOW: {
        MERGED: CHART_COLORS.SUCCESS,
        APPROVED: CHART_COLORS.INFO,
        PENDING: CHART_COLORS.NEUTRAL,
    },
};

// Chart Background Colors (with opacity)
export const CHART_BG_COLORS = {
    PRIMARY: 'rgba(99, 102, 241, 0.1)',
    SUCCESS: 'rgba(16, 185, 129, 0.1)',
    INFO: 'rgba(59, 130, 246, 0.6)',
    NEUTRAL: 'rgba(156, 163, 175, 0.6)',
};

// Chart Border Widths
export const BORDER_WIDTH = {
    THIN: 1,
    NORMAL: 2,
    THICK: 3,
    EXTRA_THICK: 4,
};

// Chart Border Radius
export const CHART_BORDER_RADIUS = {
    SMALL: 4,
    MEDIUM: 8,
    LARGE: 12,
};

// Chart Tension (for line smoothness)
export const CHART_TENSION = {
    NONE: 0,
    SLIGHT: 0.2,
    SMOOTH: 0.4,
    VERY_SMOOTH: 0.6,
};

// Chart Hover Effects
export const HOVER_EFFECTS = {
    OFFSET: 10,
    BORDER_WIDTH: 3,
    SCALE: 1.05,
};

// Default Chart Options
export const DEFAULT_CHART_OPTIONS = {
    responsive: true,
    maintainAspectRatio: false,
    interaction: {
        mode: 'index',
        intersect: false,
    },
    plugins: {
        legend: {
            display: true,
            position: 'top',
            labels: {
                usePointStyle: true,
                padding: 15,
                font: {
                    size: 12,
                    weight: '600',
                },
            },
        },
        tooltip: {
            mode: 'index',
            intersect: false,
            backgroundColor: 'rgba(0, 0, 0, 0.8)',
            padding: 12,
            borderColor: CHART_COLORS.PRIMARY,
            borderWidth: BORDER_WIDTH.THIN,
            titleFont: {
                size: 14,
                weight: 'bold',
            },
            bodyFont: {
                size: 13,
            },
            displayColors: true,
            boxPadding: 6,
        },
    },
};

// Grid Configuration
export const GRID_CONFIG = {
    DISPLAY: true,
    COLOR: 'rgba(0, 0, 0, 0.05)',
    LINE_WIDTH: 1,
    DRAW_BORDER: false,
    DRAW_ON_CHART_AREA: true,
    DRAW_TICKS: true,
};

// Axis Configuration
export const AXIS_CONFIG = {
    DISPLAY: true,
    BEGIN_AT_ZERO: true,
    TICKS: {
        FONT_SIZE: 11,
        PADDING: 8,
        MAX_ROTATION: 45,
        MIN_ROTATION: 0,
    },
};

// Chart Type Specific Configs
export const CHART_TYPE_CONFIG = {
    LINE: {
        tension: CHART_TENSION.SMOOTH,
        borderWidth: BORDER_WIDTH.THICK,
        pointRadius: 4,
        pointHoverRadius: 6,
        fill: true,
    },
    BAR: {
        borderRadius: CHART_BORDER_RADIUS.MEDIUM,
        borderWidth: 0,
        barPercentage: 0.8,
        categoryPercentage: 0.9,
    },
    DOUGHNUT: {
        borderWidth: 0,
        hoverOffset: HOVER_EFFECTS.OFFSET,
        cutout: '60%',
        rotation: 0,
    },
    AREA: {
        tension: CHART_TENSION.SMOOTH,
        borderWidth: BORDER_WIDTH.NORMAL,
        fill: true,
        stacked: true,
    },
};

// Animation Configuration
export const CHART_ANIMATION = {
    DURATION: 750,
    EASING: 'easeInOutQuart',
    DELAY: (context) => {
        let delay = 0;
        if (context.type === 'data' && context.mode === 'default') {
            delay = context.dataIndex * 50 + context.datasetIndex * 100;
        }
        return delay;
    },
};

// Legend Configuration
export const LEGEND_CONFIG = {
    DISPLAY: true,
    POSITION: 'top',
    ALIGN: 'center',
    LABELS: {
        USE_POINT_STYLE: true,
        PADDING: 15,
        BOX_WIDTH: 12,
        BOX_HEIGHT: 12,
    },
};

// Tooltip Configuration
export const TOOLTIP_CONFIG = {
    ENABLED: true,
    MODE: 'index',
    INTERSECT: false,
    BACKGROUND_COLOR: 'rgba(0, 0, 0, 0.8)',
    PADDING: 12,
    CORNER_RADIUS: 6,
    TITLE_SPACING: 4,
    BODY_SPACING: 4,
};

// Chart Scales
export const SCALES_CONFIG = {
    LINEAR: {
        type: 'linear',
        display: true,
        beginAtZero: true,
    },
    CATEGORY: {
        type: 'category',
        display: true,
    },
    TIME: {
        type: 'time',
        display: true,
    },
};

export default {
    CHART_COLORS,
    COLOR_PALETTES,
    CHART_BG_COLORS,
    BORDER_WIDTH,
    CHART_BORDER_RADIUS,
    CHART_TENSION,
    HOVER_EFFECTS,
    DEFAULT_CHART_OPTIONS,
    GRID_CONFIG,
    AXIS_CONFIG,
    CHART_TYPE_CONFIG,
    CHART_ANIMATION,
    LEGEND_CONFIG,
    TOOLTIP_CONFIG,
    SCALES_CONFIG,
};
