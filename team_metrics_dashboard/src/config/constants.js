/**
 * Application-wide constants
 * @module config/constants
 */

/**
 * PR Type detection patterns
 */
export const PR_TYPE_PATTERNS = {
    fix: /^(fix|bugfix|hotfix)[:|\\s]/i,
    feature: /^(feat|feature)[:|\\s]/i,
    chore: /^chore[:|\\s]/i,
    refactor: /^refactor[:|\\s]/i,
    docs: /^docs?[:|\\s]/i
};

/**
 * PR Type colors for visualization
 */
export const PR_TYPE_COLORS = {
    fix: '#ef4444',
    feature: '#3b82f6',
    chore: '#6b7280',
    refactor: '#f97316',
    docs: '#14b8a6',
    other: '#a855f7'
};

/**
 * Bottleneck detection settings
 */
export const BOTTLENECK = {
    DEFAULT_THRESHOLD_HOURS: 48,
    SEVERITY_MEDIUM_MULTIPLIER: 1,
    SEVERITY_HIGH_MULTIPLIER: 2,
    MAX_DISPLAY_COUNT: 10
};

/**
 * Analytics settings
 */
export const ANALYTICS = {
    REQUIRED_APPROVALS: 2,
    MERGE_TIME_FAST_THRESHOLD: 120, // minutes
    MERGE_TIME_SLOW_THRESHOLD: 480, // minutes
    TOP_COLLABORATORS_COUNT: 10,
    TOP_DISCUSSED_PRS_COUNT: 5
};

/**
 * Mock data generation settings
 */
export const MOCK_DATA = {
    DEFAULT_PR_COUNT: 60,
    DAYS_LOOKBACK: 30,
    DEVELOPERS: [
        'alice-dev',
        'bob-smith',
        'charlie-code',
        'diana-tech',
        'eve-engineer',
        'frank-dev',
        'grace-coder',
        'henry-tech'
    ],
    PR_TITLES: [
        'fix: resolve login authentication bug',
        'feat: add user profile dashboard',
        'chore: update dependencies to latest versions',
        'refactor: improve code organization in auth module',
        'docs: update API documentation',
        'fix: correct payment processing error',
        'feat: implement dark mode support',
        'chore: clean up unused imports',
        'refactor: optimize database queries',
        'docs: add contributing guidelines',
        'fix: handle edge case in validation',
        'feat: add export to CSV functionality'
    ]
};

/**
 * Tab configuration
 */
export const TABS = ['projects', 'metrics', 'analytics', 'feedback'];

/**
 * Default active tab
 */
export const DEFAULT_ACTIVE_TAB = 'analytics';

/**
 * Local storage keys
 */
export const STORAGE_KEYS = {
    THEME: 'theme',
    SETTINGS: 'dashboard_settings',
    FILTER_STATE: 'filter_state',
    GITHUB_CACHE: 'github_pr_cache',
    GITHUB_CACHE_TIMESTAMP: 'github_cache_timestamp'
};

/**
 * GitHub API Configuration
 */
export const GITHUB_API = {
    /**
     * Cache time-to-live in milliseconds (15 minutes)
     */
    CACHE_TTL_MS: 15 * 60 * 1000,

    /**
     * Number of PRs to fetch per page
     */
    PER_PAGE: 100,

    /**
     * Maximum number of pages to fetch
     */
    MAX_PAGES: 3,

    /**
     * Days to look back for PRs
     */
    DAYS_LOOKBACK: 90,

    /**
     * Rate limit warning threshold (requests remaining)
     */
    RATE_LIMIT_WARNING_THRESHOLD: 100,

    /**
     * Request timeout in milliseconds
     */
    TIMEOUT_MS: 30000
};
