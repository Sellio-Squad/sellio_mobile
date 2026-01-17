// ===========================
// UI Manager - Handles DOM updates
// ===========================

class UIManager {
  /**
   * Update metric cards with calculated values
   */
  updateMetricCards(metrics) {
    this._updateElement('prsMerged', metrics.prsMerged);
    this._updateElement('timeToMerge', `${metrics.avgTimeToMerge}h`);
    this._updateElement('prVelocity', metrics.prVelocity);
    this._updateElement('prsAwaitingReview', metrics.prsAwaitingReview);
    this._updateElement('reviewEfficiency', `${metrics.reviewEfficiency}%`);
    this._updateElement('activePRs', metrics.activePRs);

    this._updateElement('prsMergedChange', `+${metrics.changes.prsMerged}%`);
    this._updateElement('timeToMergeChange', `${metrics.changes.timeToMerge}%`);
    this._updateElement('prVelocityChange', `+${metrics.changes.velocity}%`);
    this._updateElement('reviewEfficiencyChange', `+${metrics.changes.efficiency}%`);
  }

  /**
   * Update bottlenecks section
   */
  updateBottlenecks(bottlenecks) {
    const container = document.getElementById('bottleneckGrid');
    container.innerHTML = '';

    if (bottlenecks.length === 0) {
      container.innerHTML = '<p class="no-data">🎉 No bottlenecks detected! Great work!</p>';
      return;
    }

    bottlenecks.forEach(bottleneck => {
      const item = document.createElement('div');
      item.className = 'bottleneck-item';
      item.innerHTML = `
        <div class="bottleneck-header">
          <h3 class="bottleneck-title">
            <a href="${bottleneck.url}" target="_blank" rel="noopener noreferrer">
              #${bottleneck.prNumber}: ${this._truncate(bottleneck.title, 60)}
            </a>
          </h3>
          <span class="bottleneck-severity ${bottleneck.severity}">${bottleneck.severity}</span>
        </div>
        <p class="bottleneck-description">
          Author: <strong>${bottleneck.author}</strong> • 
          Status: <strong>${bottleneck.status}</strong> • 
          Approvals: <strong>${bottleneck.approvals}/${bottleneck.requiredApprovals}</strong>
        </p>
        <div class="bottleneck-stats">
          <div class="bottleneck-stat">
            <span class="bottleneck-stat-label">Wait Time</span>
            <span class="bottleneck-stat-value">${bottleneck.waitTime}</span>
          </div>
        </div>
      `;
      container.appendChild(item);
    });
  }

  /**
   * Update team performance table
   */
  updateTeamTable(teamData) {
    const tbody = document.querySelector('#teamTable tbody');
    tbody.innerHTML = '';

    if (teamData.length === 0) {
      tbody.innerHTML = '<tr><td colspan="6" class="no-data">No team data available</td></tr>';
      return;
    }

    teamData.forEach(member => {
      const row = document.createElement('tr');
      row.innerHTML = `
        <td><span class="team-member-name">${member.name}</span></td>
        <td>${member.prsCreated}</td>
        <td>${member.prsMerged}</td>
        <td>${member.prsReviewed}</td>
        <td>${member.avgReviewTime}</td>
        <td>
          <div class="productivity-bar">
            <div class="productivity-fill" style="width: ${member.productivity}%"></div>
          </div>
          <span style="font-size: 0.75rem; color: var(--text-secondary); margin-top: 4px; display: inline-block;">
            ${member.productivity}%
          </span>
        </td>
      `;
      tbody.appendChild(row);
    });
  }

  /**
   * Update last updated timestamp
   */
  updateLastUpdated() {
    const now = new Date();
    const formatted = now.toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
    this._updateElement('lastUpdated', formatted);
  }

  /**
   * Show loading state
   */
  showLoading() {
    const overlay = document.createElement('div');
    overlay.id = 'loadingOverlay';
    overlay.className = 'loading-overlay';
    overlay.innerHTML = `
      <div class="loading-spinner">
        <div class="spinner"></div>
        <p>Loading metrics...</p>
      </div>
    `;
    document.body.appendChild(overlay);
  }

  /**
   * Hide loading state
   */
  hideLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) {
      overlay.remove();
    }
  }

  /**
   * Show error message
   */
  showError(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-banner';
    errorDiv.innerHTML = `
      <div class="error-content">
        <span class="error-icon">⚠️</span>
        <span class="error-message">${message}</span>
        <button class="error-close" onclick="this.parentElement.parentElement.remove()">×</button>
      </div>
    `;

    const container = document.querySelector('.container');
    container.insertBefore(errorDiv, container.firstChild);

    // Auto-remove after 10 seconds
    setTimeout(() => errorDiv.remove(), 10000);
  }

  /**
   * Helper: Update element text content
   * @private
   */
  _updateElement(id, value) {
    const element = document.getElementById(id);
    if (element) {
      element.textContent = value;
    }
  }

  /**
   * Helper: Truncate text
   * @private
   */
  _truncate(text, maxLength) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }

  /**
   * Render analytics filter controls
   */
  renderAnalyticsFilters(weeks, developers) {
    const filterBar = document.getElementById('analyticsFilterBar');
    if (!filterBar) return;

    filterBar.innerHTML = `
            <label for="analytics-week-filter" class="filter-label">Filter by Week:</label>
            <select id="analytics-week-filter" class="control-input">
                <option value="all">All Time</option>
                ${weeks.map((week, index) => `
                    <option value="${week.key}">${week.label}</option>
                `).join('')}
            </select>
            <label for="analytics-developer-filter" class="filter-label">View as:</label>
            <select id="analytics-developer-filter" class="control-input">
                <option value="all">All Team</option>
                ${developers.map(dev => `
                    <option value="${dev}">${dev}</option>
                `).join('')}
            </select>
        `;
  }

  /**
   * Render KPI cards grid
   */
  renderKPICards(kpisHTML) {
    const container = document.getElementById('kpiCardsGrid');
    if (container) {
      container.innerHTML = kpisHTML;
    }
  }

  /**
   * Render timing KPIs
   */
  renderTimingKPIs(timingHTML) {
    const container = document.getElementById('timingKPIsGrid');
    if (container) {
      container.innerHTML = timingHTML;
    }
  }

  /**
   * Render spotlight cards
   */
  renderSpotlightCards(spotlightHTML) {
    const container = document.getElementById('spotlightCardsGrid');
    if (container) {
      container.innerHTML = spotlightHTML;
    }
  }

  /**
   * Render merge process health indicator
   */
  renderMergeProcessHealth(healthData, chartData = null) {
    const container = document.getElementById('mergeProcessHealthContainer');
    if (!container) return;

    const iconMap = {
      success: '✅',
      warning: '⚠️',
      info: 'ℹ️'
    };

    const icon = iconMap[healthData.status] || 'ℹ️';

    container.innerHTML = `
            <h3 class="panel-header panel-title">Merge Process Health</h3>
            <div class="panel-body">
                <div class="health-indicator ${healthData.status}">
                    <span class="health-icon">${icon}</span>
                    <span>${healthData.message}</span>
                </div>
                ${chartData ? '<div class="chart-container-sm"><canvas id="mergeProcessHealthChart"></canvas></div>' : ''}
            </div>
        `;
  }

  /**
   * Render daily activity breakdown
   */
  renderDailyActivity(dailyActivityByWeek, dailyActivity) {
    const container = document.getElementById('dailyBreakdownContainer');
    if (!container) return;

    const todayString = new Date().toLocaleDateString('en-CA');
    const sortedWeeks = Object.keys(dailyActivityByWeek).sort((a, b) => new Date(b) - new Date(a));

    if (sortedWeeks.length === 0) {
      container.innerHTML = '<div class="p-4 text-center">No daily activity data for this period.</div>';
      return;
    }

    let html = '';
    sortedWeeks.forEach((weekKey, index) => {
      const isCollapsed = index > 0;
      const weekDays = dailyActivityByWeek[weekKey];
      const weekTitle = index === 0 ? 'Current Week' : `Week ${21 - index}`;

      const dayCardsHTML = weekDays.map(day => {
        const { created, merged, approvals } = dailyActivity[day];
        const isToday = day === todayString;
        const dateObj = new Date(day);

        return `
                    <div class="day-card ${isToday ? 'today' : ''}" title="${dateObj.toLocaleDateString()}">
                        <div class="day-label">${dateObj.toLocaleString('en-US', { weekday: 'short' })}</div>
                        <div class="day-number">
                            <span class="text-lg text-secondary">${dateObj.toLocaleString('en-US', { month: 'numeric' })} / </span>${dateObj.getDate()}
                        </div>
                        <div class="day-stats">
                            ${created.length > 0 ? `<div class="day-stat-item created"><strong>${created.length}</strong> <span>Opened</span></div>` : ''}
                            ${merged > 0 ? `<div class="day-stat-item merged"><strong>${merged}</strong> <span>Merged</span></div>` : ''}
                            ${approvals > 0 ? `<div class="day-stat-item approvals"><strong>${approvals}</strong> <span>Reviews</span></div>` : ''}
                        </div>
                    </div>
                `;
      }).join('');

      html += `
                <div class="daily-week-group ${isCollapsed ? 'collapsed' : ''}">
                    <h4 class="daily-week-header">${weekTitle}</h4>
                    <div class="daily-week-content">
                        <div class="daily-breakdown-grid">${dayCardsHTML}</div>
                    </div>
                </div>
            `;
    });

    container.innerHTML = html;

    // Add click handlers for collapsible weeks
    container.querySelectorAll('.daily-week-header').forEach(header => {
      header.addEventListener('click', () => {
        header.parentElement.classList.toggle('collapsed');
      });
    });
  }

  /**
   * Render PR type analysis
   */
  renderPRTypeAnalysis(prTypes, totalPRs) {
    const container = document.getElementById('prTypeAnalysisContainer');
    if (!container) return;

    const prTypeColors = {
      fix: '#ef4444',
      feature: '#3b82f6',
      chore: '#6b7280',
      refactor: '#f97316',
      docs: '#14b8a6',
      other: '#a855f7'
    };

    if (prTypes.length === 0) {
      container.innerHTML = `
                <h3 class="panel-header panel-title">PR Type Analysis</h3>
                <div class="panel-body">
                    <div class="p-4 text-center">No PR type data for this period.</div>
                </div>
            `;
      return;
    }

    const cardsHTML = prTypes.map(({ type, count, percentage }) => `
            <div class="pr-type-card">
                <div class="pr-type-header">
                    <div class="pr-type-icon" style="background-color:${prTypeColors[type] || '#ccc'}"></div>
                    <div class="pr-type-title">
                        <span class="capitalize">${type}</span>
                        <div class="pr-type-bar">
                            <div class="pr-type-fill" style="width:${percentage}%;background-color:${prTypeColors[type] || '#ccc'};"></div>
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

  /**
   * Render collaboration pairs
   */
  renderCollaborationPairs(collaborationPairs) {
    const container = document.getElementById('collaborationList');
    if (!container) return;

    if (collaborationPairs.length === 0) {
      container.innerHTML = '<li>No collaboration data available for this period.</li>';
      return;
    }

    container.innerHTML = collaborationPairs.map(item => `
            <li>
                <div class="reviewer-summary">
                    <a href="https://github.com/${item.reviewer}" target="_blank">
                        <img src="https://github.com/${item.reviewer}.png" class="avatar" alt="${item.reviewer}"/>
                        <span>${item.reviewer}</span>
                    </a>
                    <span class="text-secondary">reviewed</span>
                    <div class="collaborator-avatar-stack">
                        ${item.collaborators.map(c => `
                            <a href="https://github.com/${c}" target="_blank" title="${c}">
                                <img src="https://github.com/${c}.png" class="collaborator-avatar" alt="${c}">
                            </a>
                        `).join('')}
                    </div>
                </div>
                <span class="collaboration-count">${item.totalReviews} total</span>
            </li>
        `).join('');
  }

  /**
   * Render most discussed PRs
   */
  renderMostDiscussedPRs(discussedPRs) {
    const container = document.getElementById('mostDiscussedPRsList');
    if (!container) return;

    if (discussedPRs.length === 0) {
      container.innerHTML = '<li>No discussed PRs in this period.</li>';
      return;
    }

    container.innerHTML = discussedPRs.map(pr => `
            <li>
                <div class="discussed-pr-summary">
                    <a href="${pr.url}" target="_blank" class="discussed-pr-link">
                        #${pr.number} ${this._truncate(pr.title, 60)}
                    </a>
                    <div class="collaborator-avatar-stack">
                        ${(pr.commenters || []).map(c => `
                            <a href="https://github.com/${c}" target="_blank" title="${c}">
                                <img src="https://github.com/${c}.png" class="collaborator-avatar" alt="${c}">
                            </a>
                        `).join('')}
                    </div>
                </div>
                <span class="discussed-pr-count">${pr.totalComments} comments</span>
            </li>
        `).join('');
  }
}

export default new UIManager();
