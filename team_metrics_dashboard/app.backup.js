// ===========================
// Complete Novix Dashboard - All Features
// Standalone version (no modules for compatibility)
// ===========================

// Include all necessary code inline
(function () {
    'use strict';

    console.log('🚀 Loading Complete Dashboard...');

    // ============= CONSTANTS =============
    const PR_TYPE_PATTERNS = {
        fix: /^(fix|bugfix|hotfix)[:|\s]/i,
        feature: /^(feat|feature)[:|\s]/i,
        chore: /^chore[:|\s]/i,
        refactor: /^refactor[:|\s]/i,
        docs: /^docs?[:|\s]/i
    };

    const PR_TYPE_COLORS = {
        fix: '#ef4444',
        feature: '#3b82f6',
        chore: '#6b7280',
        refactor: '#f97316',
        docs: '#14b8a6',
        other: '#a855f7'
    };

    // ============= UTILITY FUNCTIONS =============

    function getWeekStartDate(dateInput) {
        const date = new Date(dateInput);
        const day = date.getDay();
        const diff = date.getDate() - day + (day === 0 ? -6 : 1);
        const weekStart = new Date(date.setDate(diff));
        weekStart.setHours(0, 0, 0, 0);
        return weekStart;
    }

    function formatDetailedDuration(minutes) {
        if (minutes === null || minutes === undefined || minutes < 0) return '-';

        const hours = minutes / 60;
        const days = hours / 24;

        if (hours < 1) return `${Math.round(minutes)}m`;
        if (hours < 24) return `${hours.toFixed(1)}h`;
        return `${days.toFixed(1)}d`;
    }

    function formatWeekHeader(weekStart) {
        const weekEnd = new Date(weekStart);
        weekEnd.setDate(weekEnd.getDate() + 6);

        const formatter = new Intl.DateTimeFormat('en-US', { month: 'short', day: 'numeric' });
        return `${formatter.format(weekStart)} - ${formatter.format(weekEnd)}`;
    }

    // ============= MOCK DATA GENERATOR =============

    function generateMockPRData(count = 60) {
        const developers = [
            'alice-dev', 'bob-smith', 'charlie-code', 'diana-tech',
            'eve-engineer', 'frank-dev', 'grace-coder', 'henry-tech'
        ];

        const prTitles = [
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
        ];

        const mockData = [];
        const now = new Date();

        for (let i = 0; i < count; i++) {
            const createdDate = new Date(now);
            createdDate.setDate(now.getDate() - Math.floor(Math.random() * 30));

            const author = developers[Math.floor(Math.random() * developers.length)];
            const status = i % 5 === 0 ? 'pending' : (i % 15 === 0 ? 'closed' : 'merged');

            const availableReviewers = developers.filter(d => d !== author);
            const numReviewers = Math.floor(Math.random() * 2) + 2;
            const reviewers = [];
            for (let j = 0; j < numReviewers && j < availableReviewers.length; j++) {
                const reviewer = availableReviewers[Math.floor(Math.random() * availableReviewers.length)];
                if (!reviewers.includes(reviewer)) reviewers.push(reviewer);
            }

            const commenters = [];
            const numCommenters = Math.floor(Math.random() * 4) + 1;
            for (let j = 0; j < numCommenters; j++) {
                const commenter = developers[Math.floor(Math.random() * developers.length)];
                if (!commenters.includes(commenter)) commenters.push(commenter);
            }

            const timeToFirstApproval = status !== 'closed' ? Math.floor(Math.random() * 1440) + 30 : null;
            const firstReviewer = reviewers.length > 0 ? reviewers[0] : null;

            let mergedAt = null;
            let approvedAt = null;
            let mergedBy = null;

            if (status === 'merged') {
                approvedAt = new Date(createdDate);
                approvedAt.setMinutes(approvedAt.getMinutes() + timeToFirstApproval);

                mergedAt = new Date(approvedAt);
                mergedAt.setMinutes(mergedAt.getMinutes() + Math.floor(Math.random() * 480) + 60);

                mergedBy = reviewers[Math.floor(Math.random() * reviewers.length)];
            }

            mockData.push({
                number: 1000 + i,
                title: prTitles[Math.floor(Math.random() * prTitles.length)],
                url: `https://github.com/sellio/repo/pull/${1000 + i}`,
                author: author,
                status: status,
                createdAt: createdDate.toISOString(),
                mergedAt: mergedAt ? mergedAt.toISOString() : null,
                approvedAt: approvedAt ? approvedAt.toISOString() : null,
                mergedBy: mergedBy,
                additions: Math.floor(Math.random() * 500) + 50,
                deletions: Math.floor(Math.random() * 300) + 20,
                comments: Math.floor(Math.random() * 15) + 1,
                approvals: status !== 'closed' ? Math.floor(Math.random() * 3) + 1 : 0,
                reviewers: reviewers,
                commenters: commenters,
                timeToFirstApproval: timeToFirstApproval,
                firstReviewer: firstReviewer
            });
        }

        mockData.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
        return mockData;
    }

    // ============= ANALYTICS SERVICE =============

    const AnalyticsService = {
        calculateKPIs(prData, developerFilter = 'all') {
            let filteredData = prData;

            if (developerFilter !== 'all') {
                filteredData = prData.filter(pr => {
                    const isCreator = pr.author === developerFilter;
                    const isMerger = pr.mergedBy === developerFilter;
                    const isReviewer = pr.reviewers?.includes(developerFilter);
                    return isCreator || isMerger || isReviewer;
                });
            }

            const totalPRs = filteredData.length;
            const mergedPRs = filteredData.filter(pr => pr.status === 'merged').length;
            const closedPRs = filteredData.filter(pr => pr.status === 'closed').length;

            const totalAdditions = filteredData.reduce((sum, pr) => sum + (pr.additions || 0), 0);
            const totalDeletions = filteredData.reduce((sum, pr) => sum + (pr.deletions || 0), 0);
            const avgAdditions = totalPRs > 0 ? (totalAdditions / totalPRs).toFixed(0) : 0;
            const avgDeletions = totalPRs > 0 ? (totalDeletions / totalPRs).toFixed(0) : 0;

            const totalComments = filteredData.reduce((sum, pr) => sum + (pr.comments || 0), 0);
            const avgComments = totalPRs > 0 ? (totalComments / totalPRs).toFixed(1) : '0.0';

            const approvalTimes = filteredData
                .map(pr => pr.timeToFirstApproval)
                .filter(t => t !== null && t !== undefined && t >= 0);
            const avgApprovalTime = approvalTimes.length > 0
                ? approvalTimes.reduce((a, b) => a + b, 0) / approvalTimes.length
                : null;

            const mergedData = filteredData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.createdAt);
            const lifespans = mergedData.map(pr => {
                const created = new Date(pr.createdAt);
                const merged = new Date(pr.mergedAt);
                return (merged - created) / 60000;
            });
            const avgLifespan = lifespans.length > 0
                ? lifespans.reduce((a, b) => a + b, 0) / lifespans.length
                : null;

            return {
                totalPRs,
                mergedPRs,
                closedPRs,
                avgPRSize: { additions: avgAdditions, deletions: avgDeletions },
                totalComments,
                avgComments,
                avgApprovalTime: formatDetailedDuration(avgApprovalTime),
                avgLifespan: formatDetailedDuration(avgLifespan)
            };
        },

        calculateSpotlightMetrics(prData, developerFilter = 'all') {
            if (developerFilter !== 'all') {
                const developerPRs = prData.filter(pr => pr.author === developerFilter);
                const prCommentCount = prData.filter(pr => pr.commenters?.includes(developerFilter)).length;

                return {
                    hotStreak: {
                        user: developerFilter,
                        count: developerPRs.length,
                        label: `Created ${developerPRs.length} PRs`
                    },
                    fastestReviewer: null,
                    topCommenter: {
                        user: developerFilter,
                        count: prCommentCount,
                        label: `Commented on ${prCommentCount} PRs`
                    }
                };
            }

            const recentActivity = prData.reduce((acc, pr) => {
                acc[pr.author]

                    = (acc[pr.author] || 0) + 1;
                if (pr.mergedBy) acc[pr.mergedBy] = (acc[pr.mergedBy] || 0) + 1;
                pr.reviewers?.forEach(reviewer => {
                    if (reviewer !== pr.author) acc[reviewer] = (acc[reviewer] || 0) + 1;
                });
                return acc;
            }, {});

            const hotStreakUser = Object.entries(recentActivity).sort((a, b) => b[1] - a[1])[0];

            const reviewTimes = prData.reduce((acc, pr) => {
                if (pr.timeToFirstApproval !== null && pr.firstReviewer) {
                    if (!acc[pr.firstReviewer]) acc[pr.firstReviewer] = [];
                    acc[pr.firstReviewer].push(pr.timeToFirstApproval);
                }
                return acc;
            }, {});

            const fastestReviewer = Object.entries(reviewTimes)
                .map(([user, times]) => ({
                    user,
                    avg: times.reduce((a, b) => a + b, 0) / times.length
                }))
                .sort((a, b) => a.avg - b.avg)[0];

            const commenterCounts = prData.reduce((acc, pr) => {
                pr.commenters?.forEach(commenter => {
                    acc[commenter] = (acc[commenter] || 0) + 1;
                });
                return acc;
            }, {});

            const topCommenter = Object.entries(commenterCounts).sort((a, b) => b[1] - a[1])[0];

            return {
                hotStreak: hotStreakUser ? {
                    user: hotStreakUser[0],
                    count: hotStreakUser[1],
                    label: `${hotStreakUser[1]} activity points`
                } : null,
                fastestReviewer: fastestReviewer ? {
                    user: fastestReviewer.user,
                    avg: fastestReviewer.avg,
                    label: `Avg ${formatDetailedDuration(fastestReviewer.avg)}`
                } : null,
                topCommenter: topCommenter ? {
                    user: topCommenter[0],
                    count: topCommenter[1],
                    label: `${topCommenter[1]} commented PRs`
                } : null
            };
        },

        generateDailyActivity(prData) {
            const dailyActivity = prData.reduce((acc, pr) => {
                const day = new Date(pr.createdAt).toLocaleDateString('en-CA');
                if (!acc[day]) {
                    acc[day] = { created: [], merged: 0, approvals: 0 };
                }
                acc[day].created.push(pr);

                if (pr.mergedAt) {
                    const mDay = new Date(pr.mergedAt).toLocaleDateString('en-CA');
                    if (!acc[mDay]) acc[mDay] = { created: [], merged: 0, approvals: 0 };
                    acc[mDay].merged++;
                }

                const approvalCount = pr.approvals || 0;
                if (approvalCount > 0) {
                    acc[day].approvals += approvalCount;
                }

                return acc;
            }, {});

            const dailyActivityByWeek = Object.keys(dailyActivity)
                .sort((a, b) => new Date(b) - new Date(a))
                .reduce((acc, dayString) => {
                    const weekStartDate = getWeekStartDate(dayString);
                    const weekKey = weekStartDate.toISOString();
                    if (!acc[weekKey]) acc[weekKey] = [];
                    acc[weekKey].push(dayString);
                    return acc;
                }, {});

            return { dailyActivity, dailyActivityByWeek };
        },

        analyzePRTypes(prData) {
            const prTypes = prData.reduce((acc, pr) => {
                const title = pr.title.toLowerCase();
                let type = 'other';

                for (const [typeName, pattern] of Object.entries(PR_TYPE_PATTERNS)) {
                    if (pattern.test(title)) {
                        type = typeName;
                        break;
                    }
                }

                if (!acc[type]) {
                    acc[type] = { count: 0 };
                }
                acc[type].count++;

                return acc;
            }, {});

            return Object.entries(prTypes)
                .sort((a, b) => b[1].count - a[1].count)
                .map(([type, data]) => ({
                    type,
                    ...data,
                    percentage: (data.count / prData.length * 100).toFixed(1)
                }));
        },

        calculateCollaborationPairs(prData) {
            const collaborationSummary = prData.reduce((acc, pr) => {
                pr.reviewers?.forEach(reviewer => {
                    if (reviewer === pr.author) return;

                    if (!acc[reviewer]) {
                        acc[reviewer] = {
                            totalReviews: 0,
                            collaborators: new Set()
                        };
                    }
                    acc[reviewer].totalReviews++;
                    acc[reviewer].collaborators.add(pr.author);
                });
                return acc;
            }, {});

            return Object.entries(collaborationSummary)
                .map(([reviewer, data]) => ({
                    reviewer,
                    totalReviews: data.totalReviews,
                    collaborators: Array.from(data.collaborators)
                }))
                .sort((a, b) => b.totalReviews - a.totalReviews)
                .slice(0, 10);
        },

        getMostDiscussedPRs(prData) {
            return prData
                .map(pr => ({
                    ...pr,
                    totalComments: pr.comments || 0
                }))
                .filter(pr => pr.totalComments > 0)
                .sort((a, b) => b.totalComments - a.totalComments)
                .slice(0, 5);
        },

        calculateMergeProcessHealth(prData, allPrData) {
            const mergedPRs = prData.filter(pr => pr.status === 'merged' && pr.mergedAt && pr.approvedAt);

            if (mergedPRs.length === 0) {
                return {
                    status: 'info',
                    message: 'No merge data for this period.'
                };
            }

            const mergeTimes = mergedPRs.map(pr => {
                const approved = new Date(pr.approvedAt);
                const merged = new Date(pr.mergedAt);
                return (merged - approved) / 60000;
            });

            const avgMergeTime = mergeTimes.reduce((a, b) => a + b, 0) / mergeTimes.length;

            if (avgMergeTime < 120) {
                return {
                    status: 'success',
                    message: 'Awesome! Merge process is very efficient.'
                };
            } else if (avgMergeTime < 480) {
                return {
                    status: 'info',
                    message: 'Merge process times are stable. Keep up the good work!'
                };
            } else {
                return {
                    status: 'warning',
                    message: 'Merge process could be faster. Let\'s pick up the pace!'
                };
            }
        },

        filterByWeek(prData, weekKey) {
            if (weekKey === 'all') return prData;

            return prData.filter(pr => {
                const weekStart = getWeekStartDate(pr.createdAt);
                return weekStart.toISOString() === weekKey;
            });
        },

        getUniqueWeeks(prData) {
            const weekKeys = [...new Set(prData.map(pr =>
                getWeekStartDate(pr.createdAt).toISOString()
            ))];
            return weekKeys.sort((a, b) => new Date(b) - new Date(a));
        },

        getUniqueDevelopers(prData) {
            const developers = new Set();
            prData.forEach(pr => {
                developers.add(pr.author);
                if (pr.mergedBy) developers.add(pr.mergedBy);
                pr.reviewers?.forEach(r => developers.add(r));
                pr.commenters?.forEach(c => developers.add(c));
            });
            return Array.from(developers).sort();
        },

        identifyBottlenecks(prData, thresholdHours = 48) {
            const now = new Date();
            const thresholdMs = thresholdHours * 60 * 60 * 1000;

            // Get pending PRs that are waiting for review or merge
            const bottlenecks = prData
                .filter(pr => pr.status === 'pending' || (pr.status !== 'merged' && pr.status !== 'closed'))
                .map(pr => {
                    const createdAt = new Date(pr.createdAt);
                    const waitTimeMs = now - createdAt;
                    const waitTimeHours = waitTimeMs / (60 * 60 * 1000);
                    const waitTimeDays = waitTimeHours / 24;

                    // Determine severity based on wait time
                    let severity = 'low';
                    if (waitTimeHours >= thresholdHours * 2) {
                        severity = 'high';
                    } else if (waitTimeHours >= thresholdHours) {
                        severity = 'medium';
                    }

                    return {
                        ...pr,
                        waitTimeHours,
                        waitTimeDays,
                        severity
                    };
                })
                .filter(pr => pr.waitTimeHours >= thresholdHours)
                .sort((a, b) => b.waitTimeHours - a.waitTimeHours)
                .slice(0, 10); // Top 10 bottlenecks

            return bottlenecks;
        }
    };

    // ============= MAIN DASHBOARD CLASS =============

    class NovixDashboard {
        constructor() {
            this.prData = [];
            this.currentTheme = localStorage.getItem('theme') || 'light';
            this.currentTab = 'analytics';
            this.filterState = {
                week: 'all',
                developer: 'all'
            };
        }

        async initialize() {
            console.log('📊 Initializing dashboard...');

            // Setup theme
            this.setupTheme();

            // Setup tabs
            this.setupTabs();

            // Load data
            await this.loadData();

            // Hide loading, show content
            setTimeout(() => {
                document.getElementById('loading-indicator').style.display = 'none';
                document.getElementById('content-area').classList.remove('hidden');
                this.showTab(this.currentTab);
                console.log('✅ Dashboard loaded!');
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
                    localStorage.setItem('theme', this.currentTheme);
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

            const tabs = ['projects', 'metrics', 'analytics', 'feedback'];
            tabs.forEach(tab => {
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
                console.log('📥 Generating mock data...');
                localStorage.clear();
                this.prData = generateMockPRData(60);
                console.log(`✅ Generated ${this.prData.length} PRs`);

                this.renderAnalytics();
            } catch (error) {
                console.error('❌ Error loading data:', error);
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
            weekFilter.innerHTML = '<option value="all">All Time</option>';
            weekKeys.forEach((key, index) => {
                const weekStart = new Date(key);
                const label = index === 0 ? 'Current Week' : formatWeekHeader(weekStart);
                weekFilter.innerHTML += `<option value="${key}">${label}</option>`;
            });

            const developers = AnalyticsService.getUniqueDevelopers(this.prData);
            developerFilter.innerHTML = '<option value="all">All Team</option>';
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

            this.setText('kpi-total-prs', kpis.totalPRs);
            this.setText('kpi-total-merged', kpis.mergedPRs);
            this.setText('kpi-total-closed', kpis.closedPRs);
            this.setText('kpi-avg-pr-size', `+${kpis.avgPRSize.additions} -${kpis.avgPRSize.deletions}`);
            this.setText('kpi-total-comments', kpis.totalComments);
            this.setText('kpi-avg-comments', kpis.avgComments);
            this.setText('kpi-avg-approval-time', kpis.avgApprovalTime);
            this.setText('kpi-avg-lifespan', kpis.avgLifespan);

            const spotlight = AnalyticsService.calculateSpotlightMetrics(filteredData, this.filterState.developer);
            this.renderSpotlightCard('hot-streak-card', spotlight.hotStreak, '🔥');
            this.renderSpotlightCard('fastest-reviewer-card', spotlight.fastestReviewer, '⚡');
            this.renderSpotlightCard('top-commenter-card', spotlight.topCommenter, '💬');

            this.renderBottlenecks(filteredData);
            this.renderMergeProcessHealth(filteredData);
            this.renderDailyActivity(filteredData);
            this.renderPRTypes(filteredData);
            this.renderCollaboration(filteredData);
            this.renderDiscussedPRs(filteredData);
        }

        setText(id, text) {
            const el = document.getElementById(id);
            if (el) el.textContent = text || '-';
        }

        renderSpotlightCard(cardId, data, emoji) {
            const card = document.getElementById(cardId);
            if (!card) return;

            if (!data || !data.user) {
                card.innerHTML = `<div class="p-4 text-center" style="color: #9ca3af;">No data</div>`;
                return;
            }

            card.innerHTML = `
                <div class="kpi-icon bg-orange-500">
                    <span style="font-size: 1.5rem;">${emoji}</span>
                </div>
                <div>
                    <div class="kpi-value flex items-center gap-2">
                        <img src="https://github.com/${data.user}.png" class="w-8 h-8 rounded-full" alt="${data.user}" onerror="this.src='https://via.placeholder.com/32'">
                        <span class="truncate">${data.user}</span>
                    </div>
                    <div class="kpi-label">${data.label}</div>
                </div>
            `;
        }

        renderBottlenecks(filteredData) {
            const container = document.getElementById('bottleneck-list');
            if (!container) return;

            const bottlenecks = AnalyticsService.identifyBottlenecks(filteredData);

            if (bottlenecks.length === 0) {
                container.innerHTML = `
                    <div class="text-center py-8" style="color: var(--text-secondary);">
                        <p>✅ No bottlenecks detected! All PRs are moving smoothly.</p>
                    </div>
                `;
                return;
            }

            container.innerHTML = bottlenecks.map(pr => `
                <div class="bottleneck-card severity-${pr.severity}">
                    <div class="bottleneck-header">
                        <div class="bottleneck-title">
                            <a href="${pr.url}" target="_blank">#${pr.number} ${pr.title}</a>
                        </div>
                        <span class="bottleneck-severity ${pr.severity}">
                            ${pr.severity}
                        </span>
                    </div>
                    <div class="bottleneck-meta">
                        <div class="bottleneck-meta-item">
                            <span>Author:</span>
                            <strong>${pr.author}</strong>
                        </div>
                        <div class="bottleneck-meta-item">
                            <span>Status:</span>
                            <strong>${pr.status}</strong>
                        </div>
                        <div class="bottleneck-meta-item">
                            <span>Approvals:</span>
                            <strong>${pr.approvals || 0}</strong>
                        </div>
                        <div class="bottleneck-meta-item">
                            <span>Wait Time:</span>
                            <span class="bottleneck-wait-time">
                                ${pr.waitTimeDays >= 1
                    ? `${pr.waitTimeDays.toFixed(1)} days`
                    : `${pr.waitTimeHours.toFixed(1)} hours`}
                            </span>
                        </div>
                    </div>
                </div>
            `).join('');
        }

        renderMergeProcessHealth(filteredData) {
            const container = document.getElementById('merge-process-health-container');
            if (!container) return;

            const health = AnalyticsService.calculateMergeProcessHealth(filteredData, this.prData);
            const iconMap = { success: '✅', warning: '⚠️', info: 'ℹ️' };

            container.innerHTML = `
                <h3 class="panel-header panel-title">Merge Process Health</h3>
                <div class="panel-body">
                    <div class="health-indicator ${health.status}">
                        <span class="health-icon">${iconMap[health.status]}</span>
                        <span>${health.message}</span>
                    </div>
                </div>
            `;
        }

        renderDailyActivity(filteredData) {
            const container = document.getElementById('daily-breakdown-container');
            if (!container) return;

            const { dailyActivity, dailyActivityByWeek } = AnalyticsService.generateDailyActivity(filteredData);

            if (Object.keys(dailyActivityByWeek).length === 0) {
                container.innerHTML = '<p class="text-center" style="color: #9ca3af;">No activity data</p>';
                return;
            }

            let html = '';
            const sortedWeeks = Object.keys(dailyActivityByWeek).sort((a, b) => new Date(b) - new Date(a));

            sortedWeeks.forEach((weekKey, index) => {
                const weekDays = dailyActivityByWeek[weekKey];
                const weekTitle = index === 0 ? 'Current Week' : `Week ${index + 1}`;

                const dayCards = weekDays.map(day => {
                    const { created, merged, approvals } = dailyActivity[day];
                    const dateObj = new Date(day);
                    const today = new Date().toLocaleDateString('en-CA');
                    const isToday = day === today;

                    return `
                        <div class="day-card ${isToday ? 'today' : ''}">
                            <div class="day-label">${dateObj.toLocaleDateString('en-US', { weekday: 'short' })}</div>
                            <div class="day-number">${dateObj.getDate()}</div>
                            <div class="day-stats">
                                ${created.length > 0 ? `<div class="day-stat-item created"><strong>${created.length}</strong> Opened</div>` : ''}
                                ${merged > 0 ? `<div class="day-stat-item merged"><strong>${merged}</strong> Merged</div>` : ''}
                                ${approvals > 0 ? `<div class="day-stat-item approvals"><strong>${approvals}</strong> Reviews</div>` : ''}
                            </div>
                        </div>
                    `;
                }).join('');

                html += `
                    <div class="daily-week-group ${index > 0 ? 'collapsed' : ''}">
                        <h4 class="daily-week-header">${weekTitle}</h4>
                        <div class="daily-week-content">
                            <div class="daily-breakdown-grid">${dayCards}</div>
                        </div>
                    </div>
                `;
            });

            container.innerHTML = html;

            container.querySelectorAll('.daily-week-header').forEach(header => {
                header.addEventListener('click', () => {
                    header.parentElement.classList.toggle('collapsed');
                });
            });
        }

        renderPRTypes(filteredData) {
            const container = document.getElementById('pr-type-trends-container');
            if (!container) return;

            const prTypes = AnalyticsService.analyzePRTypes(filteredData);

            const cardsHTML = prTypes.map(({ type, count, percentage }) => `
                <div class="pr-type-card">
                    <div class="pr-type-header">
                        <div class="pr-type-icon" style="background-color:${PR_TYPE_COLORS[type]}"></div>
                        <div class="pr-type-title">
                            <span class="capitalize">${type}</span>
                            <div class="pr-type-bar">
                                <div class="pr-type-fill" style="width:${percentage}%;background-color:${PR_TYPE_COLORS[type]}"></div>
                            </div>
                        </div>
                        <span class="pr-type-count">${count} PRs</span>
                    </div>
                </div>
            `).join('');

            container.innerHTML = `
                <h3 class="panel-header panel-title">PR Type Analysis</h3>
                <div class="panel-body">
                    <div class="pr-type-grid">${cardsHTML}</div>
                </div>
            `;
        }

        renderCollaboration(filteredData) {
            const container = document.getElementById('collaboration-list');
            if (!container) return;

            const pairs = AnalyticsService.calculateCollaborationPairs(filteredData);

            if (pairs.length === 0) {
                container.innerHTML = '<li>No collaboration data</li>';
                return;
            }

            container.innerHTML = pairs.slice(0, 10).map(item => `
                <li>
                    <div class="reviewer-summary">
                        <a href="https://github.com/${item.reviewer}" target="_blank">
                            <img src="https://github.com/${item.reviewer}.png" class="avatar" alt="${item.reviewer}" onerror="this.src='https://via.placeholder.com/40'">
                            <span>${item.reviewer}</span>
                        </a>
                        <span class="text-secondary">reviewed</span>
                        <div class="collaborator-avatar-stack">
                            ${item.collaborators.slice(0, 5).map(c => `
                                <a href="https://github.com/${c}" target="_blank" title="${c}">
                                    <img src="https://github.com/${c}.png" class="collaborator-avatar" alt="${c}" onerror="this.src='https://via.placeholder.com/24'">
                                </a>
                            `).join('')}
                        </div>
                    </div>
                    <span class="collaboration-count">${item.totalReviews} total</span>
                </li>
            `).join('');
        }

        renderDiscussedPRs(filteredData) {
            const container = document.getElementById('most-discussed-prs-list');
            if (!container) return;

            const discussed = AnalyticsService.getMostDiscussedPRs(filteredData);

            if (discussed.length === 0) {
                container.innerHTML = '<li>No discussed PRs</li>';
                return;
            }

            container.innerHTML = discussed.map(pr => `
                <li>
                    <div class="discussed-pr-summary">
                        <a href="${pr.url}" target="_blank" class="discussed-pr-link">
                            #${pr.number} ${pr.title}
                        </a>
                    </div>
                    <span class="discussed-pr-count">${pr.totalComments} comments</span>
                </li>
            `).join('');
        }
    }

    // ============= INITIALIZE =============

    const app = new NovixDashboard();

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => app.initialize());
    } else {
        app.initialize();
    }

    window.NovixDashboard = app;
})();
