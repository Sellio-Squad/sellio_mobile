// ===========================
// Chart Manager - Handles all chart rendering
// ===========================

class ChartManager {
    constructor() {
        this.charts = {};
    }

    /**
     * Create or update velocity chart
     */
    createVelocityChart(data) {
        const ctx = document.getElementById('velocityChart').getContext('2d');

        if (this.charts.velocity) {
            this.charts.velocity.destroy();
        }

        this.charts.velocity = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [
                    {
                        label: 'Opened',
                        data: data.opened,
                        borderColor: '#6366f1',
                        backgroundColor: 'rgba(99, 102, 241, 0.1)',
                        borderWidth: 3,
                        tension: 0.4,
                        fill: true,
                    },
                    {
                        label: 'Merged',
                        data: data.merged,
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        borderWidth: 3,
                        tension: 0.4,
                        fill: true,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 15,
                            font: { size: 12, weight: '600' },
                        },
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        borderColor: '#6366f1',
                        borderWidth: 1,
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' },
                    },
                    x: {
                        grid: { display: false },
                    },
                },
            },
        });
    }

    /**
     * Create or update time to merge distribution chart
     */
    createTimeToMergeChart(data) {
        const ctx = document.getElementById('timeToMergeChart').getContext('2d');

        if (this.charts.timeToMerge) {
            this.charts.timeToMerge.destroy();
        }

        this.charts.timeToMerge = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.labels,
                datasets: [{
                    label: 'PRs',
                    data: data.data,
                    backgroundColor: [
                        '#10b981',
                        '#3b82f6',
                        '#6366f1',
                        '#8b5cf6',
                        '#f59e0b',
                        '#ef4444',
                    ],
                    borderRadius: 8,
                    borderWidth: 0,
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' },
                    },
                    x: {
                        grid: { display: false },
                    },
                },
            },
        });
    }

    /**
     * Create or update PR distribution chart
     */
    createPRDistributionChart(data) {
        const ctx = document.getElementById('prDistChart').getContext('2d');

        if (this.charts.prDist) {
            this.charts.prDist.destroy();
        }

        this.charts.prDist = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: data.labels,
                datasets: [{
                    data: data.data,
                    backgroundColor: [
                        '#6366f1',
                        '#8b5cf6',
                        '#ec4899',
                        '#10b981',
                        '#f59e0b',
                    ],
                    borderWidth: 0,
                    hoverOffset: 10,
                }],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            usePointStyle: true,
                            padding: 15,
                            font: { size: 12, weight: '600' },
                        },
                    },
                },
            },
        });
    }

    /**
     * Create or update status flow chart
     */
    createStatusFlowChart(data) {
        const ctx = document.getElementById('statusFlowChart').getContext('2d');

        if (this.charts.statusFlow) {
            this.charts.statusFlow.destroy();
        }

        this.charts.statusFlow = new Chart(ctx, {
            type: 'line',
            data: {
                labels: data.labels,
                datasets: [
                    {
                        label: 'Merged',
                        data: data.merged,
                        backgroundColor: 'rgba(16, 185, 129, 0.6)',
                        borderColor: '#10b981',
                        borderWidth: 2,
                        fill: true,
                    },
                    {
                        label: 'Approved',
                        data: data.approved,
                        backgroundColor: 'rgba(59, 130, 246, 0.6)',
                        borderColor: '#3b82f6',
                        borderWidth: 2,
                        fill: true,
                    },
                    {
                        label: 'Pending',
                        data: data.pending,
                        backgroundColor: 'rgba(156, 163, 175, 0.6)',
                        borderColor: '#9ca3af',
                        borderWidth: 2,
                        fill: true,
                    },
                ],
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 15,
                            font: { size: 12, weight: '600' },
                        },
                    },
                },
                scales: {
                    y: {
                        stacked: true,
                        beginAtZero: true,
                        grid: { color: 'rgba(0, 0, 0, 0.05)' },
                    },
                    x: {
                        stacked: true,
                        grid: { display: false },
                        ticks: { maxTicksLimit: 10 },
                    },
                },
            },
        });
    }

    /**
     * Destroy all charts
     */
    destroyAll() {
        Object.values(this.charts).forEach(chart => chart.destroy());
        this.charts = {};
    }
}

export default new ChartManager();
