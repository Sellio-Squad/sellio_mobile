/**
 * UI strings and messages
 * @module resources/strings
 */

export const STRINGS = {
    // Header
    appTitle: 'Sellio Squad Dashboard',

    // Tabs
    tabs: {
        projects: 'Projects',
        metrics: 'Metrics',
        analytics: 'Analytics',
        feedback: 'Feedbacks'
    },

    // Loading
    loading: 'Loading dashboard data...',

    // KPI Labels
    kpi: {
        totalPRs: 'Total PRs',
        mergedPRs: 'Merged PRs',
        closedPRs: 'Total Closed PRs',
        avgPRSize: 'Avg. PR Size',
        totalComments: 'Total Comments',
        avgComments: 'Avg. Comments / PR',
        avgApprovalTime: 'Avg. Time to 1st Approval',
        avgLifespan: 'Avg. PR Lifespan'
    },

    // Bottleneck Analysis
    bottleneck: {
        title: '🚨 Bottleneck Analysis',
        noBottlenecks: '✅ No bottlenecks detected! All PRs are moving smoothly.',
        author: 'Author:',
        status: 'Status:',
        approvals: 'Approvals:',
        waitTime: 'Wait Time:',
        severity: {
            low: 'Low',
            medium: 'Medium',
            high: 'High'
        }
    },

    // Merge Process Health
    mergeHealth: {
        title: 'Merge Process Health',
        noData: 'No merge data for this period.',
        excellent: 'Awesome! Merge process is very efficient.',
        good: 'Merge process times are stable. Keep up the good work!',
        needsImprovement: "Merge process could be faster. Let's pick up the pace!"
    },

    // Daily Activity
    dailyActivity: {
        title: 'Daily Activity Breakdown',
        currentWeek: 'Current Week',
        week: 'Week',
        noData: 'No activity data',
        opened: 'Opened',
        merged: 'Merged',
        reviews: 'Reviews'
    },

    // PR Type Analysis
    prTypes: {
        title: 'PR Type Analysis',
        prs: 'PRs'
    },

    // Collaboration
    collaboration: {
        title: 'Top Collaboration Pairs',
        reviewed: 'reviewed',
        total: 'total',
        noData: 'No collaboration data'
    },

    // Most Discussed PRs
    discussed: {
        title: 'Most Discussed PRs',
        comments: 'comments',
        noData: 'No discussed PRs'
    },

    // Filters
    filters: {
        week: 'Filter by Week:',
        viewAs: 'View as:',
        allTime: 'All Time',
        currentWeek: 'Current Week',
        allTeam: 'All Team'
    },

    // Spotlight
    spotlight: {
        hotStreak: 'activity points',
        avgReviewTime: 'Avg',
        commentedPRs: 'commented PRs',
        createdPRs: 'Created',
        noData: 'No data'
    },

    // Time formats
    time: {
        minutes: 'm',
        hours: 'h',
        days: 'd'
    },

    // Tab placeholders
    placeholders: {
        projects: 'Project management features coming soon...',
        metrics: 'Detailed metrics coming soon...',
        feedback: 'Feedback features coming soon...'
    },

    // Console messages
    console: {
        loading: '🚀 Loading Sellio Squad Dashboard...',
        dataGenerated: '📊 Generating mock data...',
        dataLoaded: '✅ Data loaded!',
        dashboardReady: '✅ Dashboard loaded!'
    },

    // Settings (for future settings panel)
    settings: {
        title: 'Dashboard Settings',
        bottleneckThreshold: 'Bottleneck Threshold (hours):',
        enableNotifications: 'Enable Notifications',
        autoRefresh: 'Auto-refresh',
        refreshInterval: 'Refresh Interval (minutes):',
        requiredApprovals: 'Required Approvals:',
        save: 'Save Settings',
        reset: 'Reset to Defaults',
        saved: 'Settings saved successfully!',
        resetConfirm: 'Are you sure you want to reset all settings to defaults?'
    },

    // Notifications (for future notification system)
    notifications: {
        newBottleneck: 'New bottleneck detected:',
        thresholdExceeded: 'PR has exceeded the bottleneck threshold',
        prMerged: 'PR merged successfully',
        reviewNeeded: 'Review needed for PR'
    },

    // GitHub API
    github: {
        connected: 'Connected to GitHub',
        notConfigured: 'Not Configured',
        connectionError: 'Connection Error',
        usingCache: 'Using Cached Data',
        fetchingData: 'Fetching data from GitHub...',
        refreshing: 'Refreshing...',
        refresh: 'Refresh',
        lastUpdated: 'Last updated',
        apiLimit: 'API Limit:',
        resetsIn: 'resets in',
        errors: {
            notConfigured: 'GitHub service is not properly configured. Please check github-config.js',
            authFailed: 'GitHub authentication failed. Please check your access token.',
            rateLimitExceeded: 'GitHub API rate limit exceeded. Please try again later.',
            repoNotFound: 'Repository not found. Please check the owner and repo name.',
            networkError: 'Network error. Please check your connection.',
            timeout: 'Request timed out. Please try again.',
            unknownError: 'An unknown error occurred while fetching data.'
        }
    }
};

