// ===========================
// Data Service - Handles API calls
// ===========================

import CONFIG from '../config.js';

class DataService {
    constructor() {
        this.baseUrl = `https://raw.githubusercontent.com/${CONFIG.GITHUB.OWNER}/${CONFIG.GITHUB.REPO}/${CONFIG.GITHUB.METRICS_BRANCH}`;
    }

    /**
     * Fetch PR metrics from GitHub
     * @returns {Promise&lt;Array&gt;} Array of PR metrics
     */
    async fetchPRMetrics() {
        try {
            const url = `${this.baseUrl}/${CONFIG.GITHUB.METRICS_FILE}`;
            const response = await fetch(url, {
                cache: 'no-cache',
                headers: {
                    'Accept': 'application/json',
                },
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            return Array.isArray(data) ? data : [];
        } catch (error) {
            console.error('Error fetching PR metrics:', error);
            throw new Error(`Failed to fetch metrics: ${error.message}`);
        }
    }
}

export default new DataService();
