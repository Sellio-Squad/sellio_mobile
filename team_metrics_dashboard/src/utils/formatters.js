/**
 * Formatting utility functions
 * @module utils/formatters
 */

import { STRINGS } from '../resources/strings.js';

/**
 * Format a duration in minutes to a human-readable string
 * @param {number} minutes - Duration in minutes
 * @returns {string} Formatted duration (e.g., "2.5h" or "1.2d")
 */
export function formatDetailedDuration(minutes) {
    if (minutes === null || minutes === undefined || minutes < 0) return '-';

    const hours = minutes / 60;
    const days = hours / 24;

    if (hours < 1) return `${Math.round(minutes)}${STRINGS.time.minutes}`;
    if (hours < 24) return `${hours.toFixed(1)}${STRINGS.time.hours}`;
    return `${days.toFixed(1)}${STRINGS.time.days}`;
}

/**
 * Format a number with optional decimal places
 * @param {number} num - Number to format
 * @param {number} decimals - Number of decimal places
 * @returns {string} Formatted number
 */
export function formatNumber(num, decimals = 0) {
    if (num === null || num === undefined) return '-';
    return num.toFixed(decimals);
}

/**
 * Format a percentage
 * @param {number} value - Value to format as percentage
 * @param {number} total - Total to calculate percentage from
 * @param {number} decimals - Number of decimal places
 * @returns {string} Formatted percentage
 */
export function formatPercentage(value, total, decimals = 1) {
    if (!total || total === 0) return '0%';
    const percentage = (value / total) * 100;
    return `${percentage.toFixed(decimals)}%`;
}

/**
 * Truncate text to a maximum length
 * @param {string} text - Text to truncate
 * @param {number} maxLength - Maximum length
 * @returns {string} Truncated text with ellipsis if needed
 */
export function truncateText(text, maxLength = 50) {
    if (!text || text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
}

/**
 * Format PR size display (+additions -deletions)
 * @param {number} additions - Lines added
 * @param {number} deletions - Lines deleted
 * @returns {string} Formatted PR size
 */
export function formatPRSize(additions, deletions) {
    return `+${additions || 0} -${deletions || 0}`;
}

/**
 * Format large numbers with K/M suffixes
 * @param {number} num - Number to format
 * @returns {string} Formatted number (e.g., "1.2K")
 */
export function formatCompactNumber(num) {
    if (num === null || num === undefined) return '-';
    if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
    if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
    return num.toString();
}
