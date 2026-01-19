// ===========================
// Formatters - Data formatting utilities
// ===========================

import { FORMAT_SUFFIXES, PLACEHOLDERS } from '../constants/textConstants.js';

/**
 * Format a number with K/M suffixes
 * @param {number} num - Number to format
 * @param {number} decimals - Number of decimal places
 * @returns {string} Formatted number
 */
export function formatNumber(num, decimals = 1) {
    if (num === null || num === undefined || isNaN(num)) {
        return PLACEHOLDERS.NO_DATA;
    }

    if (num >= 1000000) {
        return (num / 1000000).toFixed(decimals) + FORMAT_SUFFIXES.MILLION;
    }
    if (num >= 1000) {
        return (num / 1000).toFixed(decimals) + FORMAT_SUFFIXES.THOUSAND;
    }
    return num.toString();
}

/**
 * Format duration in minutes to human-readable format
 * @param {number} minutes - Duration in minutes
 * @returns {string} Formatted duration
 */
export function formatDuration(minutes) {
    if (minutes === null || minutes === undefined || isNaN(minutes)) {
        return PLACEHOLDERS.NO_DATA;
    }

    const hours = minutes / 60;
    const days = hours / 24;
    const weeks = days / 7;

    if (weeks >= 1) {
        return `${weeks.toFixed(1)}${FORMAT_SUFFIXES.WEEKS}`;
    }
    if (days >= 1) {
        return `${days.toFixed(1)}${FORMAT_SUFFIXES.DAYS}`;
    }
    if (hours >= 1) {
        return `${hours.toFixed(1)}${FORMAT_SUFFIXES.HOURS}`;
    }
    return `${Math.round(minutes)}m`;
}

/**
 * Format a percentage
 * @param {number} value - Percentage value (0-100)
 * @param {number} decimals - Number of decimal places
 * @returns {string} Formatted percentage
 */
export function formatPercentage(value, decimals = 0) {
    if (value === null || value === undefined || isNaN(value)) {
        return PLACEHOLDERS.NO_DATA;
    }
    return `${value.toFixed(decimals)}${FORMAT_SUFFIXES.PERCENT}`;
}

/**
 * Format a date/time string
 * @param {Date|string} date - Date to format
 * @param {object} options - Intl.DateTimeFormat options
 * @returns {string} Formatted date
 */
export function formatDate(date, options = {}) {
    if (!date) return PLACEHOLDERS.NO_DATA;

    try {
        const dateObj = date instanceof Date ? date : new Date(date);
        return dateObj.toLocaleString('en-US', options);
    } catch (error) {
        console.error('Error formatting date:', error);
        return PLACEHOLDERS.NO_DATA;
    }
}

/**
 * Format a change value with +/- prefix
 * @param {number} value - Change value
 * @param {boolean} isPercentage - Whether to format as percentage
 * @returns {string} Formatted change
 */
export function formatChange(value, isPercentage = true) {
    if (value === null || value === undefined || isNaN(value)) {
        return PLACEHOLDERS.ZERO;
    }

    const prefix = value >= 0 ? '+' : '';
    const formatted = isPercentage
        ? formatPercentage(Math.abs(value), 1)
        : formatNumber(Math.abs(value));

    return `${prefix}${value < 0 ? '-' : ''}${formatted}`;
}

/**
 * Truncate text to a maximum length
 * @param {string} text - Text to truncate
 * @param {number} maxLength - Maximum length
 * @returns {string} Truncated text
 */
export function truncateText(text, maxLength) {
    if (!text) return '';
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
}

/**
 * Format time ago (e.g., "2 hours ago")
 * @param {Date|string} date - Date to compare
 * @returns {string} Time ago string
 */
export function formatTimeAgo(date) {
    if (!date) return PLACEHOLDERS.NO_DATA;

    try {
        const dateObj = date instanceof Date ? date : new Date(date);
        const now = new Date();
        const diffMs = now - dateObj;
        const diffMins = Math.floor(diffMs / 60000);
        const diffHours = Math.floor(diffMins / 60);
        const diffDays = Math.floor(diffHours / 24);

        if (diffDays > 0) return `${diffDays}d ago`;
        if (diffHours > 0) return `${diffHours}h ago`;
        if (diffMins > 0) return `${diffMins}m ago`;
        return 'Just now';
    } catch (error) {
        console.error('Error formatting time ago:', error);
        return PLACEHOLDERS.NO_DATA;
    }
}

/**
 * Format a week string (e.g., "2026-W03" -> "W03")
 * @param {string} weekString - Week string in ISO format
 * @returns {string} Formatted week
 */
export function formatWeek(weekString) {
    if (!weekString) return '';
    return weekString.replace(/(\d{4})-W(\d{2})/, 'W$2');
}

/**
 * Animate a counter from start to end value
 * @param {HTMLElement} element - Element to update
 * @param {number} start - Start value
 * @param {number} end - End value
 * @param {number} duration - Animation duration in ms
 * @param {function} formatter - Optional formatter function
 */
export function animateCounter(element, start, end, duration = 1000, formatter = null) {
    if (!element) return;

    const startTime = performance.now();
    const diff = end - start;

    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);

        // Easing function (ease-out)
        const eased = 1 - Math.pow(1 - progress, 3);
        const current = start + (diff * eased);

        element.textContent = formatter ? formatter(current) : Math.round(current);

        if (progress < 1) {
            requestAnimationFrame(update);
        }
    }

    requestAnimationFrame(update);
}

export default {
    formatNumber,
    formatDuration,
    formatPercentage,
    formatDate,
    formatChange,
    truncateText,
    formatTimeAgo,
    formatWeek,
    animateCounter,
};
