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
 * Format duration with more detail (includes seconds)
 * @param {number} minutes - Duration in minutes
 * @returns {string} Formatted duration
 */
export function formatDetailedDuration(minutes) {
    if (minutes === null || minutes === undefined || isNaN(minutes) || minutes < 0) {
        return 'N/A';
    }

    if (minutes < 1) {
        return `${(minutes * 60).toFixed(0)}s`;
    }
    if (minutes < 60) {
        return `${minutes.toFixed(0)}m`;
    }
    if (minutes < 1440) {
        return `${(minutes / 60).toFixed(1)}h`;
    }
    return `${(minutes / 1440).toFixed(1)}d`;
}

/**
 * Get week start date (Saturday at 7 PM)
 * @param {Date|string} dateStr - Date to get week start for
 * @returns {Date} Week start date
 */
export function getWeekStartDate(dateStr) {
    const prDate = new Date(dateStr);
    const weekStart = new Date(prDate);
    let daysToSubtract = (prDate.getDay() + 1) % 7;
    weekStart.setDate(prDate.getDate() - daysToSubtract);
    weekStart.setHours(19, 0, 0, 0);

    if (prDate < weekStart) {
        weekStart.setDate(weekStart.getDate() - 7);
    }
    return weekStart;
}

/**
 * Format week header with date range
 * @param {Date} startDate - Week start date
 * @returns {string} Formatted week header
 */
export function formatWeekHeader(startDate) {
    const endDate = new Date(startDate);
    endDate.setDate(startDate.getDate() + 7);
    endDate.setMilliseconds(endDate.getMilliseconds() - 1);

    const startMonth = startDate.toLocaleString('en-US', { month: 'short' });
    const endMonth = endDate.toLocaleString('en-US', { month: 'short' });

    let datePart;
    if (startMonth === endMonth) {
        datePart = `${startMonth} ${startDate.getDate()} - ${endDate.getDate()}`;
    } else {
        datePart = `${startMonth} ${startDate.getDate()} - ${endMonth} ${endDate.getDate()}`;
    }
    return `Week of ${datePart}, ${startDate.getFullYear()}`;
}

/**
 * Get relative week name
 * @param {number} index - Week index (0 = current week)
 * @param {number} baseWeekNumber - Base week number for naming
 * @returns {string} Relative week name
 */
export function getRelativeWeekName(index, baseWeekNumber = 21) {
    if (index === 0) {
        return "Current Week";
    }
    const weekNum = baseWeekNumber - index;
    return `Week ${weekNum}`;
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
    formatDetailedDuration,
    formatPercentage,
    formatDate,
    formatChange,
    truncateText,
    formatTimeAgo,
    formatWeek,
    animateCounter,
    getWeekStartDate,
    formatWeekHeader,
    getRelativeWeekName,
};
