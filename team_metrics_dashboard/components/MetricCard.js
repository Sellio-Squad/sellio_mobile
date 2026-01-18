// ===========================
// Metric Card Component
// ===========================

import { ICONS, CHANGE_TYPE } from '../constants/uiConstants.js';
import { createElement, addClass } from '../utils/domHelpers.js';
import { formatNumber, formatPercentage, formatChange, animateCounter } from '../utils/formatters.js';

/**
 * Metric Card Component
 * Displays a metric with icon, label, value, and change indicator
 */
export class MetricCard {
    /**
     * @param {object} config - Card configuration
     * @param {string} config.id - Unique card ID
     * @param {string} config.icon - Icon emoji
     * @param {string} config.label - Metric label
     * @param {number} config.value - Metric value
     * @param {number} config.change - Change percentage
     * @param {string} config.changeType - Change type (positive/negative/neutral)
     * @param {boolean} config.isAlert - Whether to show as alert
     * @param {function} config.formatter - Value formatter function
     */
    constructor(config) {
        this.config = config;
        this.element = null;
        this.valueElement = null;
        this.changeElement = null;
    }

    /**
     * Create the card element
     * @returns {HTMLElement} Card element
     */
    create() {
        const { id, icon, label, value, change, changeType, isAlert, formatter } = this.config;

        // Create card container
        const card = createElement('div', {
            className: `metric-card${isAlert ? ' alert' : ''}`,
            dataset: { metricId: id },
        });

        // Create icon
        const iconEl = createElement('div', { className: 'metric-icon' }, icon);

        // Create content container
        const content = createElement('div', { className: 'metric-content' });

        // Create label
        const labelEl = createElement('h3', { className: 'metric-label' }, label);

        // Create value
        this.valueElement = createElement('p', {
            className: 'metric-value',
            id: `${id}Value`,
        }, formatter ? formatter(value) : value.toString());

        // Create change indicator
        this.changeElement = createElement('span', {
            className: `metric-change ${changeType}`,
            id: `${id}Change`,
        }, formatChange(change));

        // Assemble
        content.appendChild(labelEl);
        content.appendChild(this.valueElement);
        content.appendChild(this.changeElement);

        card.appendChild(iconEl);
        card.appendChild(content);

        this.element = card;
        return card;
    }

    /**
     * Update card value with animation
     * @param {number} newValue - New value
     * @param {number} newChange - New change value
     */
    update(newValue, newChange) {
        const { formatter } = this.config;

        if (this.valueElement) {
            if (formatter) {
                // Animate if it's a number
                if (typeof newValue === 'number') {
                    const currentValue = parseFloat(this.valueElement.textContent) || 0;
                    animateCounter(this.valueElement, currentValue, newValue, 1000, formatter);
                } else {
                    this.valueElement.textContent = formatter(newValue);
                }
            } else {
                this.valueElement.textContent = newValue.toString();
            }
        }

        if (this.changeElement && newChange !== undefined) {
            this.changeElement.textContent = formatChange(newChange);
        }

        this.config.value = newValue;
        this.config.change = newChange;
    }

    /**
     * Set alert state
     * @param {boolean} isAlert - Whether to show as alert
     */
    setAlert(isAlert) {
        if (!this.element) return;

        if (isAlert) {
            addClass(this.element, 'alert');
        } else {
            this.element.classList.remove('alert');
        }

        this.config.isAlert = isAlert;
    }

    /**
     * Get the card element
     * @returns {HTMLElement} Card element
     */
    getElement() {
        return this.element || this.create();
    }

    /**
     * Destroy the card
     */
    destroy() {
        if (this.element && this.element.parentNode) {
            this.element.parentNode.removeChild(this.element);
        }
        this.element = null;
        this.valueElement = null;
        this.changeElement = null;
    }
}

export default MetricCard;
