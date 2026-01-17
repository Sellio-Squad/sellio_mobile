// ===========================
// Configuration
// ===========================

const CONFIG = {
    GITHUB: {
        OWNER: 'Sellio-Squad',
        REPO: 'sellio_mobile',
        METRICS_BRANCH: 'metrics',
        METRICS_FILE: 'pr_metrics.json',
    },
    METRICS: {
        REQUIRED_APPROVALS: 2,
        BOTTLENECK_THRESHOLD_HOURS: 48,
        REFRESH_INTERVAL_MINUTES: 5,
    },
    THEME: {
        STORAGE_KEY: 'theme',
        DEFAULT: 'light',
    },
};

export default CONFIG;
