/**
 * Settings Panel Component
 * @module components/settingsPanel
 */

import { STRINGS } from '../resources/strings.js';
import { loadSettings, saveSettings, resetSettings, updateSetting } from '../config/settings.js';
import { notificationSystem } from './notifications.js';

/**
 * Initialize settings panel
 */
export function initSettingsPanel() {
    const settingsBtn = document.getElementById('settings-btn');
    const settingsPanel = document.getElementById('settings-panel');
    const settingsOverlay = document.getElementById('settings-overlay');
    const closeSettingsBtn = document.getElementById('close-settings');
    const saveSettingsBtn = document.getElementById('save-settings');
    const resetSettingsBtn = document.getElementById('reset-settings');

    if (!settingsBtn || !settingsPanel) return;

    // Load current settings
    loadSettingsToUI();

    // Open settings
    settingsBtn?.addEventListener('click', () => {
        settingsPanel?.classList.add('open');
        settingsOverlay?.classList.add('show');
    });

    // Close settings
    const closeSettings = () => {
        settingsPanel?.classList.remove('open');
        settingsOverlay?.classList.remove('show');
    };

    closeSettingsBtn?.addEventListener('click', closeSettings);
    settingsOverlay?.addEventListener('click', closeSettings);

    // Save settings
    saveSettingsBtn?.addEventListener('click', () => {
        saveSettingsFromUI();
        notificationSystem.show(STRINGS.settings.saved, 'success', 3000);
        closeSettings();

        // Trigger dashboard refresh
        if (window.dashboard) {
            window.dashboard.updateAnalytics();
        }
    });

    // Reset settings
    resetSettingsBtn?.addEventListener('click', () => {
        if (confirm(STRINGS.settings.resetConfirm)) {
            resetSettings();
            loadSettingsToUI();
            notificationSystem.show('Settings reset to defaults', 'info', 3000);
        }
    });
}

/**
 * Load settings into UI inputs
 */
function loadSettingsToUI() {
    const settings = loadSettings();

    const thresholdInput = document.getElementById('bottleneck-threshold');
    const notificationsCheckbox = document.getElementById('enable-notifications');
    const autoRefreshCheckbox = document.getElementById('auto-refresh');
    const refreshIntervalInput = document.getElementById('refresh-interval');

    if (thresholdInput) thresholdInput.value = settings.bottleneck.thresholdHours;
    if (notificationsCheckbox) notificationsCheckbox.checked = settings.bottleneck.enableNotifications;
    if (autoRefreshCheckbox) autoRefreshCheckbox.checked = settings.analytics.autoRefreshEnabled;
    if (refreshIntervalInput) refreshIntervalInput.value = settings.analytics.refreshIntervalMinutes;
}

/**
 * Save settings from UI inputs
 */
function saveSettingsFromUI() {
    const thresholdInput = document.getElementById('bottleneck-threshold');
    const notificationsCheckbox = document.getElementById('enable-notifications');
    const autoRefreshCheckbox = document.getElementById('auto-refresh');
    const refreshIntervalInput = document.getElementById('refresh-interval');

    if (thresholdInput) {
        updateSetting('bottleneck.thresholdHours', parseInt(thresholdInput.value));
    }
    if (notificationsCheckbox) {
        updateSetting('bottleneck.enableNotifications', notificationsCheckbox.checked);
    }
    if (autoRefreshCheckbox) {
        updateSetting('analytics.autoRefreshEnabled', autoRefreshCheckbox.checked);
    }
    if (refreshIntervalInput) {
        updateSetting('analytics.refreshIntervalMinutes', parseInt(refreshIntervalInput.value));
    }
}
