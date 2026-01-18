// ===========================
// Main Application - Clean Architecture
// ===========================

import CONFIG from './config.js';
import DataService from './services/dataService.js';
import MetricsCalculator from './services/metricsCalculator.js';
import ChartManager from './ui/chartManager.js';
import UIManager from './ui/uiManager.js';

class DashboardApp {
    constructor() {
        this.currentTheme = localStorage.getItem(CONFIG.THEME.STORAGE_KEY) || CONFIG.THEME.DEFAULT;
        this.prData = [];
        this.refreshInterval = null;
    }

    /**
     * Initialize the application
     */
    async initialize() {
        this._setupTheme();
        this._setupEventListeners();
        await this.refreshData();
        this._startAutoRefresh();
    }

    /**
     * Fetch and refresh all dashboard data
     */
    async refreshData() {
        try {
            UIManager.showLoading();

            this.prData = await DataService.fetchPRMetrics();

            // Calculate metrics
            const metrics = MetricsCalculator.calculateMetrics(this.prData);
            const velocityData = MetricsCalculator.generateVelocityData(this.prData);
            const timeToMergeData = MetricsCalculator.generateTimeToMergeDistribution(this.prData);
            const prDistData = MetricsCalculator.generatePRDistribution(this.prData);
            const statusFlowData = MetricsCalculator.generateStatusFlow(this.prData);
            const bottlenecks = MetricsCalculator.generateBottlenecks(this.prData);
            const teamPerformance = MetricsCalculator.generateTeamPerformance(this.prData);

            // Update UI
            UIManager.updateMetricCards(metrics);
            UIManager.updateBottlenecks(bottlenecks);
            UIManager.updateTeamTable(teamPerformance);
            UIManager.updateLastUpdated();

            // Update charts
            ChartManager.createVelocityChart(velocityData);
            ChartManager.createTimeToMergeChart(timeToMergeData);
            ChartManager.createPRDistributionChart(prDistData);
            ChartManager.createStatusFlowChart(statusFlowData);

            UIManager.hideLoading();
        } catch (error) {
            console.error('Error refreshing data:', error);
            UIManager.hideLoading();
            UIManager.showError(`Failed to load metrics: ${error.message}`);
        }
    }

    /**
     * Toggle theme between light and dark
     */
    toggleTheme() {
        this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light';
        document.documentElement.setAttribute('data-theme', this.currentTheme);
        localStorage.setItem(CONFIG.THEME.STORAGE_KEY, this.currentTheme);

        const icon = document.querySelector('.theme-icon');
        icon.textContent = this.currentTheme === 'light' ? '🌙' : '☀️';

        // Recreate charts with new theme
        this.refreshData();
    }

    /**
     * Setup initial theme
     * @private
     */
    _setupTheme() {
        document.documentElement.setAttribute('data-theme', this.currentTheme);
        const icon = document.querySelector('.theme-icon');
        if (icon) {
            icon.textContent = this.currentTheme === 'light' ? '🌙' : '☀️';
        }
    }

    /**
     * Setup event listeners
     * @private
     */
    _setupEventListeners() {
        // Theme toggle
        const themeToggle = document.getElementById('themeToggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', () => this.toggleTheme());
        }

        // Refresh button
        const refreshBtn = document.getElementById('refreshBtn');
        if (refreshBtn) {
            refreshBtn.addEventListener('click', () => this.refreshData());
        }
    }

    /**
     * Start auto-refresh interval
     * @private
     */
    _startAutoRefresh() {
        const intervalMs = CONFIG.METRICS.REFRESH_INTERVAL_MINUTES * 60 * 1000;
        this.refreshInterval = setInterval(() => this.refreshData(), intervalMs);
    }

    /**
     * Stop auto-refresh interval
     */
    stopAutoRefresh() {
        if (this.refreshInterval) {
            clearInterval(this.refreshInterval);
            this.refreshInterval = null;
        }
    }
}

// Initialize app when DOM is ready
const app = new DashboardApp();

if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => app.initialize());
} else {
    app.initialize();
}

export default app;
