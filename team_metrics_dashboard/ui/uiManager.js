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
}

export default new UIManager();
