// ===========================
// Validators - Data validation utilities
// ===========================

/**
 * Check if a value is a valid number
 * @param {any} value - Value to check
 * @returns {boolean} True if valid number
 */
export function isValidNumber(value) {
    return typeof value === 'number' && !isNaN(value) && isFinite(value);
}

/**
 * Check if a value is a valid non-empty string
 * @param {any} value - Value to check
 * @returns {boolean} True if valid string
 */
export function isValidString(value) {
    return typeof value === 'string' && value.trim().length > 0;
}

/**
 * Check if a value is a valid date
 * @param {any} value - Value to check
 * @returns {boolean} True if valid date
 */
export function isValidDate(value) {
    if (!value) return false;
    const date = value instanceof Date ? value : new Date(value);
    return date instanceof Date && !isNaN(date.getTime());
}

/**
 * Check if a value is a valid array
 * @param {any} value - Value to check
 * @param {number} minLength - Minimum array length (optional)
 * @returns {boolean} True if valid array
 */
export function isValidArray(value, minLength = 0) {
    return Array.isArray(value) && value.length >= minLength;
}

/**
 * Check if a value is a valid object
 * @param {any} value - Value to check
 * @returns {boolean} True if valid object
 */
export function isValidObject(value) {
    return value !== null && typeof value === 'object' && !Array.isArray(value);
}

/**
 * Check if a number is within a range
 * @param {number} value - Value to check
 * @param {number} min - Minimum value
 * @param {number} max - Maximum value
 * @returns {boolean} True if within range
 */
export function isInRange(value, min, max) {
    return isValidNumber(value) && value >= min && value <= max;
}

/**
 * Validate PR data structure
 * @param {object} pr - PR object to validate
 * @returns {boolean} True if valid PR
 */
export function isValidPR(pr) {
    if (!isValidObject(pr)) return false;

    const requiredFields = [
        'pr_number',
        'url',
        'title',
        'opened_at',
        'creator',
        'status',
    ];

    return requiredFields.every(field => {
        const value = pr[field];
        if (field === 'pr_number') return isValidNumber(value);
        if (field === 'opened_at') return isValidDate(value);
        if (field === 'creator') return isValidObject(value);
        return isValidString(value);
    });
}

/**
 * Validate metrics data structure
 * @param {object} metrics - Metrics object to validate
 * @returns {boolean} True if valid metrics
 */
export function isValidMetrics(metrics) {
    if (!isValidObject(metrics)) return false;

    const requiredFields = [
        'prsMerged',
        'avgTimeToMerge',
        'prVelocity',
        'prsAwaitingReview',
        'reviewEfficiency',
        'activePRs',
    ];

    return requiredFields.every(field =>
        metrics.hasOwnProperty(field) && isValidNumber(metrics[field])
    );
}

/**
 * Validate chart data structure
 * @param {object} chartData - Chart data to validate
 * @returns {boolean} True if valid chart data
 */
export function isValidChartData(chartData) {
    if (!isValidObject(chartData)) return false;
    if (!isValidArray(chartData.labels)) return false;

    // Check if at least one data array exists
    const dataArrays = Object.keys(chartData).filter(key =>
        key !== 'labels' && isValidArray(chartData[key])
    );

    return dataArrays.length > 0;
}

/**
 * Sanitize HTML string to prevent XSS
 * @param {string} str - String to sanitize
 * @returns {string} Sanitized string
 */
export function sanitizeHTML(str) {
    if (!isValidString(str)) return '';

    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
}

/**
 * Validate URL format
 * @param {string} url - URL to validate
 * @returns {boolean} True if valid URL
 */
export function isValidURL(url) {
    if (!isValidString(url)) return false;

    try {
        new URL(url);
        return true;
    } catch {
        return false;
    }
}

/**
 * Clamp a number between min and max values
 * @param {number} value - Value to clamp
 * @param {number} min - Minimum value
 * @param {number} max - Maximum value
 * @returns {number} Clamped value
 */
export function clamp(value, min, max) {
    if (!isValidNumber(value)) return min;
    return Math.min(Math.max(value, min), max);
}

/**
 * Ensure a value is a positive number
 * @param {any} value - Value to check
 * @param {number} fallback - Fallback value if invalid
 * @returns {number} Positive number
 */
export function ensurePositive(value, fallback = 0) {
    const num = Number(value);
    return isValidNumber(num) && num >= 0 ? num : fallback;
}

export default {
    isValidNumber,
    isValidString,
    isValidDate,
    isValidArray,
    isValidObject,
    isInRange,
    isValidPR,
    isValidMetrics,
    isValidChartData,
    sanitizeHTML,
    isValidURL,
    clamp,
    ensurePositive,
};
