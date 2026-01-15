# Sellio Team Metrics Dashboard

Real-time PR performance dashboard powered by GitHub Actions and real metrics data.

## 🎯 Overview

This dashboard provides real-time insights into your team's pull request performance, including:

- **PR Velocity**: Track PRs opened vs merged over time
- **Time to Merge**: Understand how long PRs take to get merged
- **Review Efficiency**: Monitor approval times and review SLAs
- **Bottleneck Analysis**: Identify PRs stuck in review
- **Team Performance**: Individual contributor metrics

## 🏗️ Architecture

The dashboard follows **Clean Architecture** principles with clear separation of concerns:

```
team_metrics_dashboard/
├── config.js                    # Configuration constants
├── services/
│   ├── dataService.js          # API calls and data fetching
│   └── metricsCalculator.js    # Business logic and calculations
├── ui/
│   ├── chartManager.js         # Chart rendering
│   └── uiManager.js            # DOM manipulation
├── app.js                       # Main application orchestrator
├── index.html                   # HTML structure
└── styles.css                   # Styling
```

### Layers

1. **Configuration Layer** (`config.js`)
   - Repository settings
   - Metrics thresholds
   - Theme configuration

2. **Data Layer** (`services/dataService.js`)
   - Fetches PR metrics from GitHub
   - Handles API errors
   - Data caching

3. **Business Logic Layer** (`services/metricsCalculator.js`)
   - Calculates all metrics from raw PR data
   - Generates chart data
   - Identifies bottlenecks
   - Computes team performance

4. **Presentation Layer** (`ui/`)
   - **chartManager.js**: Chart.js rendering
   - **uiManager.js**: DOM updates, loading states, error handling

5. **Application Layer** (`app.js`)
   - Orchestrates all layers
   - Manages application lifecycle
   - Handles theme and refresh

## 📊 Metrics Collected

The GitHub workflow (`sellio-metrics-bot.yml`) automatically collects:

- PR number, title, URL
- Creator, assignees, reviewers
- Opened/closed/merged timestamps
- Approval times (first approval, required approvals met)
- Comments grouped by author
- Diff stats (additions, deletions, changed files)
- PR status (pending, approved, merged, closed)
- Week-based grouping for trends

## 🚀 Setup

### 1. GitHub Workflow

The workflow is already configured at `.github/workflows/sellio-metrics-bot.yml`. It uses:

- `vars.APP_ID` - Your Sellio bot app ID
- `secrets.APP_PRIVATE_KEY` - Your Sellio bot private key

The workflow automatically:
- Triggers on PR events (opened, closed, synchronize, etc.)
- Triggers on review events (approved, dismissed)
- Triggers on comment events
- Stores metrics in `pr_metrics.json` on the `metrics` branch

### 2. Backfill Historical Data

To populate metrics for existing PRs:

1. Go to **Actions** tab in GitHub
2. Select **Sellio Metrics Bot** workflow
3. Click **Run workflow**
4. Set `backfill_existing_prs` to `true`
5. Set `backfill_days` (e.g., 30 for last 30 days)
6. Click **Run workflow**

### 3. Local Development

#### Option A: Simple HTTP Server (Recommended)

```bash
cd team_metrics_dashboard
python -m http.server 8000
```

Then open `http://localhost:8000`

#### Option B: Live Server (VS Code)

1. Install "Live Server" extension
2. Right-click `index.html`
3. Select "Open with Live Server"

### 4. Configuration

Edit `config.js` to customize:

```javascript
const CONFIG = {
  GITHUB: {
    OWNER: 'Sellio-Squad',           // Your GitHub organization
    REPO: 'sellio_mobile',            // Your repository name
    METRICS_BRANCH: 'metrics',        // Branch storing metrics
    METRICS_FILE: 'pr_metrics.json',  // Metrics file name
  },
  METRICS: {
    REQUIRED_APPROVALS: 2,            // Required approvals for PRs
    BOTTLENECK_THRESHOLD_HOURS: 48,   // Hours before PR is bottleneck
    REFRESH_INTERVAL_MINUTES: 5,      // Auto-refresh interval
  },
};
```

## 📈 Dashboard Features

### Metric Cards

- **PRs Merged**: Total PRs merged
- **Avg Time to Merge**: Average time from open to merge
- **PR Velocity**: PRs merged per week
- **PRs Awaiting Review**: PRs waiting > 48 hours
- **Review Efficiency**: % of PRs approved within SLA
- **Active PRs**: Currently open PRs

### Charts

- **PR Velocity Trend**: PRs opened vs merged by week
- **Time to Merge Distribution**: Histogram of merge times
- **PR Distribution**: Top contributors by PR count
- **PR Status Flow**: PR states over time (pending/approved/merged)

### Bottleneck Analysis

Shows PRs with longest wait times, including:
- PR title and number (clickable link to GitHub)
- Author and current status
- Number of approvals
- Wait time in days
- Severity indicator (low/medium/high)

### Team Performance

Individual metrics for each team member:
- PRs created
- PRs merged
- PRs reviewed
- Average review time
- Productivity score

## 🎨 Theming

The dashboard supports light and dark themes:
- Click the theme toggle button (🌙/☀️) in the header
- Theme preference is saved to localStorage
- Charts automatically update with theme

## 🔄 Data Refresh

- **Manual**: Click the "Refresh" button in the header
- **Automatic**: Dashboard refreshes every 5 minutes (configurable)
- **Workflow**: Metrics update on every PR event

## 🐛 Troubleshooting

### No Data Showing

1. Check if metrics branch exists:
   ```bash
   git fetch origin metrics
   git checkout metrics
   cat pr_metrics.json
   ```

2. Verify workflow has run:
   - Go to Actions tab
   - Check Sellio Metrics Bot runs
   - Look for errors in logs

3. Check browser console for errors

### CORS Errors

If running locally and seeing CORS errors:
- Use a local HTTP server (not `file://` protocol)
- GitHub raw content should allow CORS

### Metrics Not Updating

1. Check workflow triggers in `.github/workflows/sellio-metrics-bot.yml`
2. Verify bot has permissions (pull requests: write, contents: write)
3. Check workflow run logs for errors

## 📝 Extending the Dashboard

### Adding New Metrics

1. Update `metricsCalculator.js` to calculate new metric
2. Update `uiManager.js` to display it
3. Add HTML element in `index.html`
4. Add styles in `styles.css`

### Adding New Charts

1. Add chart data generator in `metricsCalculator.js`
2. Add chart renderer in `chartManager.js`
3. Add canvas element in `index.html`
4. Call from `app.js` in `refreshData()`

## 🤝 Contributing

When making changes:

1. Follow Clean Architecture principles
2. Keep concerns separated (data, business logic, UI)
3. Add error handling
4. Update this README if adding features

## 📄 License

Part of the Sellio project.

---

**Last Updated**: 2026-01-16
