/**
 * Main Dashboard Class
 * @module core/dashboard
 */

import { DEFAULT_ACTIVE_TAB, TABS, STORAGE_KEYS } from '../config/constants.js';
import { STRINGS } from '../resources/strings.js';
import { loadSettings } from '../config/settings.js';
import { generateMockPRData } from '../utils/mockDataGenerator.js';
import { formatWeekHeader } from '../utils/dateUtils.js';
import * as AnalyticsService from '../services/analyticsService.js';
import { renderKPICards, renderSpotlightCard } from '../components/kpiCards.js';
import { renderBottlenecks } from '../components/bottleneckPanel.js';
import { initSettingsPanel } from '../components/settingsPanel.js';
import { notificationSystem } from '../components/notifications.js';
import { loadPRMetrics, isDataAvailable } from '../services/dataLoader.js';
import { renderSearchBar, updateLabelOptions, filterPRs } from '../components/search.js';
import { renderOpenPRs } from '../components/openPRs.js';
import { renderLeaderboard } from '../components/leaderboard.js';
import { renderReviewLoad } from '../components/reviewLoad.js';

export class Dashboard {
    constructor() {
        this.prData = [];
        this.settings = loadSettings();
        this.currentTheme = localStorage.getItem(STORAGE_KEYS.THEME) || 'light';
        this.currentTab = DEFAULT_ACTIVE_TAB;
        this.filterState = {
            week: 'all',
            developer: 'all'
        };
        this.searchFilters = { searchTerm: '', status: 'all', label: 'all' }; // New
        this.dataSource = 'unknown'; // 'github' or 'mock'
    }

    async initialize() {
        console.log(STRINGS.console.loading);

        this.setupTheme();
        this.setupTabs();
        this.setupSearch(); // New
        initSettingsPanel();
        await this.loadData();

        setTimeout(() => {
            document.getElementById('loading-indicator').style.display = 'none';
            document.getElementById('content-area').classList.remove('hidden');
            this.showTab(this.currentTab);
            console.log(STRINGS.console.dashboardReady);
        }, 1000);
    }

    setupTheme() {
        const html = document.documentElement;
        const themeBtn = document.getElementById('theme-toggle-btn');
        const sunIcon = document.getElementById('theme-icon-sun');
        const moonIcon = document.getElementById('theme-icon-moon');

        if (this.currentTheme === 'dark') {
            html.classList.add('dark');
            if (sunIcon) sunIcon.classList.remove('hidden');
            if (moonIcon) moonIcon.classList.add('hidden');
        } else {
            html.classList.remove('dark');
            if (sunIcon) sunIcon.classList.add('hidden');
            if (moonIcon) moonIcon.classList.remove('hidden');
        }

        if (themeBtn) {
            themeBtn.addEventListener('click', () => {
                if (html.classList.contains('dark')) {
                    html.classList.remove('dark');
                    this.currentTheme = 'light';
                    if (sunIcon) sunIcon.classList.add('hidden');
                    if (moonIcon) moonIcon.classList.remove('hidden');
                } else {
                    html.classList.add('dark');
                    this.currentTheme = 'dark';
                    if (sunIcon) sunIcon.classList.remove('hidden');
                    if (moonIcon) moonIcon.classList.add('hidden');
                }
                localStorage.setItem(STORAGE_KEYS.THEME, this.currentTheme);
            });
        }
    }

    setupTabs() {
        const tabButtons = document.querySelectorAll('.tab-button');
        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                const tab = button.getAttribute('data-tab');
                this.showTab(tab);
            });
        });
    }

    showTab(tabName) {
        document.querySelectorAll('.tab-button').forEach(btn => {
            if (btn.getAttribute('data-tab') === tabName) {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });

        TABS.forEach(tab => {
            const content = document.getElementById(`${tab}-content`);
            if (content) {
                if (tab === tabName) {
                    content.classList.remove('hidden');
                } else {
                    content.classList.add('hidden');
                }
            }
        });

        this.currentTab = tabName;
    }

    async loadData() {
        try {
            // Try to load from pr_metrics.json first
            console.log('� Attempting to load PR metrics from workflow JSON...');
            try {
                this.prData = await loadPRMetrics();
                this.dataSource = 'workflow';
                console.log(`✅ Loaded ${this.prData.length} PRs from pr_metrics.json`);
            } catch (error) {
                console.warn('⚠️ Could not load pr_metrics.json, using mock data');
                console.error('Error details:', error.message);
                this.prData = generateMockPRData();
                this.dataSource = 'mock';
            }

            this.renderAnalytics();
        } catch (error) {
            console.error('❌ Error loading data:', error);
            this.dataSource = 'error';
        }
    }

    setupSearch() {
        // Initialize search bar with callback
        renderSearchBar((filters) => {
            this.searchFilters = filters;
            this.updateAnalytics();
        });

        // Update label options when PR data changes
        if (this.prData.length > 0) {
            updateLabelOptions(this.prData);
        }
    }

    renderAnalytics() {
        this.setupAnalyticsFilters();
        this.updateAnalytics();
    }

    setupAnalyticsFilters() {
        const weekFilter = document.getElementById('analytics-week-filter');
        const developerFilter = document.getElementById('analytics-developer-filter');

        if (!weekFilter || !developerFilter) return;

        const weekKeys = AnalyticsService.getUniqueWeeks(this.prData);
        weekFilter.innerHTML = `<option value="all">${STRINGS.filters.allTime}</option>`;
        weekKeys.forEach((key, index) => {
            const weekStart = new Date(key);
            const label = index === 0 ? STRINGS.filters.currentWeek : formatWeekHeader(weekStart);
            weekFilter.innerHTML += `<option value="${key}">${label}</option>`;
        });

        const developers = AnalyticsService.getUniqueDevelopers(this.prData);
        developerFilter.innerHTML = `<option value="all">${STRINGS.filters.allTeam}</option>`;
        developers.forEach(dev => {
            developerFilter.innerHTML += `<option value="${dev}">${dev}</option>`;
        });

        weekFilter.addEventListener('change', () => {
            this.filterState.week = weekFilter.value;
            this.updateAnalytics();
        });

        developerFilter.addEventListener('change', () => {
            this.filterState.developer = developerFilter.value;
            this.updateAnalytics();
        });
    }

    updateAnalytics() {
        const filteredData = AnalyticsService.filterByWeek(this.prData, this.filterState.week);
        const kpis = AnalyticsService.calculateKPIs(filteredData, this.filterState.developer);

        renderKPICards(kpis);

        const spotlight = AnalyticsService.calculateSpotlightMetrics(filteredData, this.filterState.developer);
        renderSpotlightCard('hot-streak-card', spotlight.hotStreak, '🔥');
        renderSpotlightCard('fastest-reviewer-card', spotlight.fastestReviewer, '⚡');
        renderSpotlightCard('top-commenter-card', spotlight.topCommenter, '💬');

        const bottlenecks = AnalyticsService.identifyBottlenecks(filteredData, this.settings.bottleneck.thresholdHours);
        renderBottlenecks(filteredData);

        // Notify if bottlenecks found and notifications enabled
        if (this.settings.bottleneck.enableNotifications && bottlenecks.length > 0) {
            const highSeverity = bottlenecks.filter(b => b.severity === 'high').length;
            if (highSeverity > 0) {
                notificationSystem.show(
                    `⚠️ ${highSeverity} high-severity bottleneck${highSeverity > 1 ? 's' : ''} detected!`,
                    'warning',
                    8000
                );
            }
        }

        // Apply search filters if any
        const searchFilteredData = filterPRs(filteredData, this.searchFilters);

        // Render new components with filtered data
        renderOpenPRs(searchFilteredData);
        renderLeaderboard(filteredData); // Use full week data for accurate leaderboard
        renderReviewLoad(filteredData); // Use full week data for review load

        // Update label options in search
        updateLabelOptions(filteredData);
    }
}
