/**
 * Theme configuration with Sellio branding colors
 * @module config/theme
 */

/**
 * Sellio theme color palette
 * Using modern, professional colors suitable for a dashboard
 */
export const THEME = {
    light: {
        // Primary branding colors
        primary: '#4f46e5',        // Indigo
        primaryLight: '#eef2ff',
        primaryDark: '#3730a3',

        // Secondary colors
        secondary: '#8b5cf6',      // Purple
        secondaryLight: '#f5f3ff',

        // Semantic colors
        success: '#10b981',        // Green
        successBg: '#f0fdf4',
        successText: '#166534',

        warning: '#f59e0b',        // Amber
        warningBg: '#fef3c7',
        warningText: '#92400e',

        danger: '#ef4444',         // Red
        dangerBg: '#fee2e2',
        dangerText: '#991b1b',

        info: '#0ea5e9',           // Sky blue
        infoBg: '#e0f2fe',
        infoText: '#0369a1',

        // Neutrals
        bgPrimary: '#f3f4f6',      // Gray 100
        bgSecondary: '#ffffff',
        border: '#e5e7eb',         // Gray 200

        textPrimary: '#111827',    // Gray 900
        textSecondary: '#4b5563',  // Gray 600
        textTertiary: '#9ca3af'    // Gray 400
    },

    dark: {
        // Primary branding colors
        primary: '#6366f1',        // Lighter indigo for dark mode
        primaryLight: '#312e81',
        primaryDark: '#818cf8',

        // Secondary colors
        secondary: '#a78bfa',      // Lighter purple
        secondaryLight: '#4c1d95',

        // Semantic colors
        success: '#22c55e',        // Brighter green
        successBg: '#052e16',
        successText: '#86efac',

        warning: '#fbbf24',        // Brighter amber
        warningBg: '#451a03',
        warningText: '#fcd34d',

        danger: '#f87171',         // Brighter red
        dangerBg: '#450a0a',
        dangerText: '#fca5a5',

        info: '#38bdf8',           // Brighter sky blue
        infoBg: '#082f49',
        infoText: '#7dd3fc',

        // Neutrals
        bgPrimary: '#111827',      // Gray 900
        bgSecondary: '#1f2937',    // Gray 800
        border: '#374151',         // Gray 700

        textPrimary: '#f3f4f6',    // Gray 100
        textSecondary: '#9ca3af',  // Gray 400
        textTertiary: '#6b7280'    // Gray 500
    }
};

/**
 * Severity colors for bottleneck analysis
 */
export const SEVERITY_COLORS = {
    low: {
        border: '#22c55e',
        bgLight: '#dcfce7',
        bgDark: '#052e16',
        textLight: '#166534',
        textDark: '#86efac'
    },
    medium: {
        border: '#f59e0b',
        bgLight: '#fef3c7',
        bgDark: '#451a03',
        textLight: '#92400e',
        textDark: '#fcd34d'
    },
    high: {
        border: '#ef4444',
        bgLight: '#fee2e2',
        bgDark: '#450a0a',
        textLight: '#991b1b',
        textDark: '#fca5a5'
    }
};

/**
 * Spacing scale (in rem)
 */
export const SPACING = {
    xs: '0.25rem',
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem',
    xl: '2rem',
    '2xl': '3rem'
};

/**
 * Border radius values
 */
export const RADIUS = {
    sm: '0.375rem',
    md: '0.5rem',
    lg: '0.75rem',
    xl: '1rem',
    full: '9999px'
};

/**
 * Typography scale
 */
export const TYPOGRAPHY = {
    fontFamily: '"Inter", sans-serif',
    fontSize: {
        xs: '0.75rem',
        sm: '0.875rem',
        base: '1rem',
        lg: '1.125rem',
        xl: '1.25rem',
        '2xl': '1.5rem',
        '3xl': '1.875rem',
        '4xl': '2.25rem'
    },
    fontWeight: {
        normal: 400,
        medium: 500,
        semibold: 600,
        bold: 700,
        extrabold: 800
    }
};
