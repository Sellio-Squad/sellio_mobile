/**
 * Date utility functions
 * @module utils/dateUtils
 */

/**
 * Get the start date of the week for a given date
 * @param {Date|string} dateInput - Date to get week start for
 * @returns {Date} Start of the week (Monday)
 */
export function getWeekStartDate(dateInput) {
    const date = new Date(dateInput);
    const day = date.getDay();
    const diff = date.getDate() - day + (day === 0 ? -6 : 1);
    const weekStart = new Date(date.setDate(diff));
    weekStart.setHours(0, 0, 0, 0);
    return weekStart;
}

/**
 * Format a week range as a header string
 * @param {Date} weekStart - Start date of the week
 * @returns {string} Formatted week header (e.g., "Jan 15 - Jan 21")
 */
export function formatWeekHeader(weekStart) {
    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekEnd.getDate() + 6);

    const formatter = new Intl.DateTimeFormat('en-US', { month: 'short', day: 'numeric' });
    return `${formatter.format(weekStart)} - ${formatter.format(weekEnd)}`;
}

/**
 * Calculate duration between two dates in minutes
 * @param {Date|string} startDate - Start date
 * @param {Date|string} endDate - End date
 * @returns {number} Duration in minutes
 */
export function calculateDurationMinutes(startDate, endDate) {
    const start = new Date(startDate);
    const end = new Date(endDate);
    return (end - start) / 60000;
}

/**
 * Check if a date is today
 * @param {Date|string} date - Date to check
 * @returns {boolean} True if date is today
 */
export function isToday(date) {
    const today = new Date();
    const checkDate = new Date(date);
    return today.toLocaleDateString('en-CA') === checkDate.toLocaleDateString('en-CA');
}

/**
 * Get relative time string (e.g., "2 days ago")
 * @param {Date|string} date - Date to get relative time for
 * @returns {string} Relative time string
 */
export function getRelativeTime(date) {
    const now = new Date();
    const past = new Date(date);
    const diffMs = now - past;
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMins / 60);
    const diffDays = Math.floor(diffHours / 24);

    if (diffMins < 60) return `${diffMins} minute${diffMins !== 1 ? 's' : ''} ago`;
    if (diffHours < 24) return `${diffHours} hour${diffHours !== 1 ? 's' : ''} ago`;
    return `${diffDays} day${diffDays !== 1 ? 's' : ''} ago`;
}

/**
 * Format distance to now (e.g., "5 minutes", "2 hours", "3 days")
 * @param {Date|string} date - Date to format
 * @returns {string} Distance string
 */
export function formatDistanceToNow(date) {
    const now = new Date();
    const target = new Date(date);
    const diffMs = Math.abs(now - target);
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMins / 60);
    const diffDays = Math.floor(diffHours / 24);

    if (diffMins < 1) return 'just now';
    if (diffMins < 60) return `${diffMins} min${diffMins !== 1 ? 's' : ''}`;
    if (diffHours < 24) return `${diffHours} hr${diffHours !== 1 ? 's' : ''}`;
    return `${diffDays} day${diffDays !== 1 ? 's' : ''}`;
}

