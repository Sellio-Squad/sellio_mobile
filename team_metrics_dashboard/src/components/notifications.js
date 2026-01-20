/**
 * Notification System Component
 * @module components/notifications
 */

import { STRINGS } from '../resources/strings.js';

class NotificationSystem {
    constructor() {
        this.notifications = [];
        this.container = null;
        this.init();
    }

    init() {
        // Create notification container if it doesn't exist
        if (!document.getElementById('notification-container')) {
            const container = document.createElement('div');
            container.id = 'notification-container';
            container.className = 'notification-container';
            document.body.appendChild(container);
            this.container = container;
        } else {
            this.container = document.getElementById('notification-container');
        }
    }

    /**
     * Show a notification
     * @param {string} message - Notification message
     * @param {string} type - Notification type (success, warning, info, error)
     * @param {number} duration - Auto-dismiss duration in ms (0 = no auto-dismiss)
     */
    show(message, type = 'info', duration = 5000) {
        const id = Date.now() + Math.random();
        const notification = this.createNotification(id, message, type);

        this.container.appendChild(notification);
        this.notifications.push({ id, element: notification });

        // Animate in
        setTimeout(() => notification.classList.add('show'), 10);

        // Auto dismiss
        if (duration > 0) {
            setTimeout(() => this.dismiss(id), duration);
        }

        return id;
    }

    createNotification(id, message, type) {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.dataset.id = id;

        const icons = {
            success: '✅',
            warning: '⚠️',
            error: '❌',
            info: 'ℹ️'
        };

        notification.innerHTML = `
            <div class="notification-icon">${icons[type] || icons.info}</div>
            <div class="notification-message">${message}</div>
            <button class="notification-close" onclick="window.notificationSystem?.dismiss(${id})">×</button>
        `;

        return notification;
    }

    dismiss(id) {
        const notification = this.notifications.find(n => n.id === id);
        if (notification) {
            notification.element.classList.remove('show');
            setTimeout(() => {
                notification.element.remove();
                this.notifications = this.notifications.filter(n => n.id !== id);
            }, 300);
        }
    }

    dismissAll() {
        this.notifications.forEach(n => this.dismiss(n.id));
    }
}

// Create singleton instance
export const notificationSystem = new NotificationSystem();

// Make available globally for inline handlers
if (typeof window !== 'undefined') {
    window.notificationSystem = notificationSystem;
}
