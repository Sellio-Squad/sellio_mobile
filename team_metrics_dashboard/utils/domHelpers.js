// ===========================
// DOM Helpers - DOM manipulation utilities
// ===========================

/**
 * Create an HTML element with attributes and children
 * @param {string} tag - HTML tag name
 * @param {object} attributes - Element attributes
 * @param {Array|string} children - Child elements or text content
 * @returns {HTMLElement} Created element
 */
export function createElement(tag, attributes = {}, children = []) {
    const element = document.createElement(tag);

    // Set attributes
    Object.entries(attributes).forEach(([key, value]) => {
        if (key === 'className') {
            element.className = value;
        } else if (key === 'dataset') {
            Object.entries(value).forEach(([dataKey, dataValue]) => {
                element.dataset[dataKey] = dataValue;
            });
        } else if (key.startsWith('on') && typeof value === 'function') {
            const eventName = key.substring(2).toLowerCase();
            element.addEventListener(eventName, value);
        } else {
            element.setAttribute(key, value);
        }
    });

    // Add children
    if (typeof children === 'string') {
        element.textContent = children;
    } else if (Array.isArray(children)) {
        children.forEach(child => {
            if (typeof child === 'string') {
                element.appendChild(document.createTextNode(child));
            } else if (child instanceof HTMLElement) {
                element.appendChild(child);
            }
        });
    }

    return element;
}

/**
 * Get element by ID with error handling
 * @param {string} id - Element ID
 * @returns {HTMLElement|null} Element or null
 */
export function getElement(id) {
    const element = document.getElementById(id);
    if (!element) {
        console.warn(`Element with ID "${id}" not found`);
    }
    return element;
}

/**
 * Get all elements matching a selector
 * @param {string} selector - CSS selector
 * @param {HTMLElement} parent - Parent element (default: document)
 * @returns {Array} Array of elements
 */
export function getElements(selector, parent = document) {
    return Array.from(parent.querySelectorAll(selector));
}

/**
 * Add class(es) to an element
 * @param {HTMLElement} element - Target element
 * @param {string|Array} classes - Class name(s) to add
 */
export function addClass(element, classes) {
    if (!element) return;
    const classArray = Array.isArray(classes) ? classes : [classes];
    element.classList.add(...classArray);
}

/**
 * Remove class(es) from an element
 * @param {HTMLElement} element - Target element
 * @param {string|Array} classes - Class name(s) to remove
 */
export function removeClass(element, classes) {
    if (!element) return;
    const classArray = Array.isArray(classes) ? classes : [classes];
    element.classList.remove(...classArray);
}

/**
 * Toggle class on an element
 * @param {HTMLElement} element - Target element
 * @param {string} className - Class name to toggle
 * @param {boolean} force - Force add/remove (optional)
 */
export function toggleClass(element, className, force = undefined) {
    if (!element) return;
    element.classList.toggle(className, force);
}

/**
 * Check if element has class
 * @param {HTMLElement} element - Target element
 * @param {string} className - Class name to check
 * @returns {boolean} True if element has class
 */
export function hasClass(element, className) {
    return element ? element.classList.contains(className) : false;
}

/**
 * Set element text content safely
 * @param {HTMLElement} element - Target element
 * @param {string} text - Text content
 */
export function setText(element, text) {
    if (element) {
        element.textContent = text;
    }
}

/**
 * Set element HTML content safely
 * @param {HTMLElement} element - Target element
 * @param {string} html - HTML content
 */
export function setHTML(element, html) {
    if (element) {
        element.innerHTML = html;
    }
}

/**
 * Clear all children from an element
 * @param {HTMLElement} element - Target element
 */
export function clearChildren(element) {
    if (element) {
        while (element.firstChild) {
            element.removeChild(element.firstChild);
        }
    }
}

/**
 * Show an element
 * @param {HTMLElement} element - Target element
 * @param {string} display - Display value (default: 'block')
 */
export function show(element, display = 'block') {
    if (element) {
        element.style.display = display;
    }
}

/**
 * Hide an element
 * @param {HTMLElement} element - Target element
 */
export function hide(element) {
    if (element) {
        element.style.display = 'none';
    }
}

/**
 * Toggle element visibility
 * @param {HTMLElement} element - Target element
 * @param {string} display - Display value when shown
 */
export function toggle(element, display = 'block') {
    if (!element) return;
    element.style.display = element.style.display === 'none' ? display : 'none';
}

/**
 * Add event listener with automatic cleanup
 * @param {HTMLElement} element - Target element
 * @param {string} event - Event name
 * @param {function} handler - Event handler
 * @param {object} options - Event listener options
 * @returns {function} Cleanup function
 */
export function on(element, event, handler, options = {}) {
    if (!element) return () => { };
    element.addEventListener(event, handler, options);
    return () => element.removeEventListener(event, handler, options);
}

/**
 * Remove event listener
 * @param {HTMLElement} element - Target element
 * @param {string} event - Event name
 * @param {function} handler - Event handler
 */
export function off(element, event, handler) {
    if (element) {
        element.removeEventListener(event, handler);
    }
}

/**
 * Dispatch custom event
 * @param {HTMLElement} element - Target element
 * @param {string} eventName - Event name
 * @param {any} detail - Event detail data
 */
export function emit(element, eventName, detail = null) {
    if (!element) return;
    const event = new CustomEvent(eventName, { detail, bubbles: true });
    element.dispatchEvent(event);
}

/**
 * Set multiple attributes at once
 * @param {HTMLElement} element - Target element
 * @param {object} attributes - Attributes object
 */
export function setAttributes(element, attributes) {
    if (!element) return;
    Object.entries(attributes).forEach(([key, value]) => {
        element.setAttribute(key, value);
    });
}

/**
 * Get computed style property
 * @param {HTMLElement} element - Target element
 * @param {string} property - CSS property name
 * @returns {string} Property value
 */
export function getStyle(element, property) {
    if (!element) return '';
    return window.getComputedStyle(element).getPropertyValue(property);
}

/**
 * Set inline styles
 * @param {HTMLElement} element - Target element
 * @param {object} styles - Styles object
 */
export function setStyles(element, styles) {
    if (!element) return;
    Object.entries(styles).forEach(([property, value]) => {
        element.style[property] = value;
    });
}

/**
 * Fade in an element
 * @param {HTMLElement} element - Target element
 * @param {number} duration - Animation duration in ms
 */
export function fadeIn(element, duration = 300) {
    if (!element) return;

    element.style.opacity = '0';
    element.style.display = 'block';

    let start = null;
    function animate(timestamp) {
        if (!start) start = timestamp;
        const progress = (timestamp - start) / duration;

        element.style.opacity = Math.min(progress, 1);

        if (progress < 1) {
            requestAnimationFrame(animate);
        }
    }

    requestAnimationFrame(animate);
}

/**
 * Fade out an element
 * @param {HTMLElement} element - Target element
 * @param {number} duration - Animation duration in ms
 */
export function fadeOut(element, duration = 300) {
    if (!element) return;

    let start = null;
    function animate(timestamp) {
        if (!start) start = timestamp;
        const progress = (timestamp - start) / duration;

        element.style.opacity = 1 - Math.min(progress, 1);

        if (progress < 1) {
            requestAnimationFrame(animate);
        } else {
            element.style.display = 'none';
        }
    }

    requestAnimationFrame(animate);
}

export default {
    createElement,
    getElement,
    getElements,
    addClass,
    removeClass,
    toggleClass,
    hasClass,
    setText,
    setHTML,
    clearChildren,
    show,
    hide,
    toggle,
    on,
    off,
    emit,
    setAttributes,
    getStyle,
    setStyles,
    fadeIn,
    fadeOut,
};
