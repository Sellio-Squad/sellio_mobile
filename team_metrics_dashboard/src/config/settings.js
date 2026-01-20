/**
 * User-configurable settings
 * @module config/settings
 */

import { BOTTLENECK, ANALYTICS, STORAGE_KEYS } from './constants.js';

/**
 * Default settings
 */
export const DEFAULT_SETTINGS = {
    bottleneck: {
        thresholdHours: BOTTLENECK.DEFAULT_THRESHOLD_HOURS,
        enableNotifications: false,
        notificationSound: false
    },
    analytics: {
        requiredApprovals: ANALYTICS.REQUIRED_APPROVALS,
        autoRefreshEnabled: false,
        refreshIntervalMinutes: 5
    },
    display: {
        defaultView: 'analytics',
        showWeekNumbers: true,
        compactMode: false
    },
    filters: {
        rememberFilters: true,
        defaultWeek: 'all',
        defaultDeveloper: 'all'
    }
};

/**
 * Load settings from localStorage
 * @returns {Object} User settings merged with defaults
 */
export function loadSettings() {
    try {
        const stored = localStorage.getItem(STORAGE_KEYS.SETTINGS);
        if (stored) {
            const parsedSettings = JSON.parse(stored);
            return {
                ...DEFAULT_SETTINGS,
                ...parsedSettings
            };
        }
    } catch (error) {
        console.warn('Failed to load settings from localStorage:', error);
    }
    return DEFAULT_SETTINGS;
}

/**
 * Save settings to localStorage
 * @param {Object} settings - Settings to save
 */
export function saveSettings(settings) {
    try {
        localStorage.setItem(STORAGE_KEYS.SETTINGS, JSON.stringify(settings));
    } catch (error) {
        console.error('Failed to save settings to localStorage:', error);
    }
}

/**
 * Reset settings to defaults
 */
export function resetSettings() {
    try {
        localStorage.removeItem(STORAGE_KEYS.SETTINGS);
    } catch (error) {
        console.error('Failed to reset settings:', error);
    }
}

/**
 * Update a specific setting
 * @param {string} path - Dot-notation path to setting (e.g., 'bottleneck.thresholdHours')
 * @param {*} value - New value
 */
export function updateSetting(path, value) {
    const settings = loadSettings();
    const keys = path.split('.');
    let current = settings;

    for (let i = 0; i < keys.length - 1; i++) {
        if (!current[keys[i]]) {
            current[keys[i]] = {};
        }
        current = current[keys[i]];
    }

    current[keys[keys.length - 1]] = value;
    saveSettings(settings);

    return settings;
}
