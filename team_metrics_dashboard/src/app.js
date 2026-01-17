/**
 * Sellio Squad Dashboard - Main Entry Point
 * @module app
 */

import { Dashboard } from './core/dashboard.js';

// Initialize dashboard when DOM is ready
(function () {
    'use strict';

    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initDashboard);
    } else {
        initDashboard();
    }

    function initDashboard() {
        const dashboard = new Dashboard();
        dashboard.initialize();

        // Make dashboard accessible globally for debugging
        window.dashboard = dashboard;
    }
})();
