# Sellio Squad Dashboard

Real-time team metrics dashboard with modular architecture and clean separation of concerns.

## 🎯 Overview

This dashboard provides real-time insights into your team's pull request performance:

- **PR Velocity**: Track PRs opened vs merged over time
- **Time to Merge**: Understand merge efficiency
- **Review Efficiency**: Monitor approval times
- **❗ Bottleneck Analysis**: Identify stuck PRs with severity indicators
- **Team Performance**: Individual contributor metrics

---

## 🏗️ Architecture

The dashboard follows **Clean Architecture** with modular organization:

```
team_metrics_dashboard/
├── index.html                  # Main HTML
├── package.json
├── README.md
│
├── styles/
│   └── main.css               # All styles with Sellio theme
│
└── src/
    ├── app.js                 # Main entry point
    │
    ├── config/                # Configuration
    │   ├── constants.js       # App constants (PR types, thresholds)
    │   ├── theme.js           # Sellio color palette & design tokens
    │   └── settings.js        # User settings with localStorage
    │
    ├── resources/
    │   └── strings.js         # All UI text & messages
    │
    ├── utils/                 # Utilities
    │   ├── dateUtils.js       # Date manipulation
    │   ├── formatters.js      # Number/text formatting
    │   └── mockDataGenerator.js  # Mock data for testing
    │
    ├── services/
    │   └── analyticsService.js   # Business logic & calculations
    │
    ├── components/            # UI Components
    │   ├── kpiCards.js        # KPI card rendering
    │   ├── bottleneckPanel.js # Bottleneck visualization
    │   ├── mergeHealth.js     # Merge process health
    │   └── otherComponents.js # Daily activity, PR types, etc.
    │
    └── core/
        └── dashboard.js       # Main Dashboard class
```

### Architecture Benefits

✨ **Separation of Concerns**: Each module has single responsibility  
🔄 **Reusability**: Components can be used independently  
📖 **Maintainability**: Easy to find and update code  
🧪 **Testability**: Pure functions easy to test  
🎨 **Consistency**: Centralized theme and strings  
⚙️ **Customization**: User-configurable settings  

---

## 📊 Features

### Core Metrics
- Total PRs, Merged PRs, Closed PRs
- Average PR Size (additions/deletions)
- Comments statistics
- Time to first approval
- PR lifespan

### 🚨 Bottleneck Analysis
Identifies PRs stuck in review with:
- **Severity Classification**: Low, Medium, High
- **Wait Time Tracking**: Days/hours waiting
- **Configurable Threshold**: Default 48 hours
- **Visual Indicators**: Color-coded severity

### Spotlight Metrics
- 🔥 Hot Streak: Most active contributor
- ⚡ Fastest Reviewer: Quickest reviews
- 💬 Top Commenter: Most engaged in discussions

### Additional Insights
- Daily activity breakdown by week
- PR type distribution (fix, feature, chore, etc.)
- Collaboration pairs (who reviews whose PRs)
- Most discussed PRs

---

## 🚀 Quick Start

### Local Development

```bash
cd team_metrics_dashboard

# Option 1: Python HTTP server
python -m http.server 8000

# Option 2: Node.js HTTP server
npx http-server -p 8000

# Open browser
open http://localhost:8000
```

### Configuration

Edit `src/config/constants.js` to customize:

```javascript
export const BOTTLENECK = {
    DEFAULT_THRESHOLD_HOURS: 48,  // Adjust threshold
    MAX_DISPLAY_COUNT: 10         // Max bottlenecks shown
};

export const ANALYTICS = {
    REQUIRED_APPROVALS: 2         // Required approvals
};
```

Edit `src/config/theme.js` for Sellio branding colors.

Edit `src/resources/strings.js` for UI text customization.

---

## 🎨 Theme System

The dashboard uses a comprehensive theme system with Sellio branding:

```javascript
// Light mode colors
primary: '#4f46e5'         // Indigo
success: '#10b981'         // Green  
warning: '#f59e0b'         // Amber
danger: '#ef4444'          // Red

// Semantic tokens for consistency
bgPrimary, bgSecondary, border
textPrimary, textSecondary, textTertiary
```

Supports dark mode with automatically adjusted colors.

---

## 💾 Settings & Persistence

User settings are stored in localStorage:

```javascript
{
    bottleneck: {
        thresholdHours: 48,
        enableNotifications: false
    },
    analytics: {
        requiredApprovals: 2,
        autoRefreshEnabled: false
    },
    filters: {
        rememberFilters: true
    }
}
```

Settings API:
```javascript
import { loadSettings, saveSettings, updateSetting } from './src/config/settings.js';

const settings = loadSettings();
updateSetting('bottleneck.thresholdHours', 72);
```

---

## 🔧 Development

### Module Structure

**Config**: Constants, theme, settings  
**Resources**: UI strings for localization  
**Utils**: Pure utility functions  
**Services**: Business logic (analytics calculations)  
**Components**: UI rendering functions  
**Core**: Main application class  

### Adding New Features

1. **New Metric**: Add to `services/analyticsService.js`
2. **New Component**: Create in `components/`
3. **New Constant**: Add to `config/constants.js`
4. **New UI Text**: Add to `resources/strings.js`

### Code Style

- ES6 modules with named exports
- JSDoc comments on all exports
- Pure functions where possible
- Descriptive variable/function names

---

## 📈 Metrics Data

Currently uses mock data generated by `utils/mockDataGenerator.js`.

**To integrate real data**:
1. Replace `generateMockPRData()` in `core/dashboard.js`
2. Fetch from GitHub API or metrics backend
3. Ensure data matches PR object schema

---

## 🎯 Roadmap

- [ ] **Configurable Thresholds UI**: Settings panel for bottleneck threshold
- [ ] **Notification System**: Alerts for new bottlenecks
- [ ] **Historical Trends**: Track metrics over time
- [ ] **GitHub API Integration**: Real PR data
- [ ] **Export Features**: Download reports as CSV/PDF
- [ ] **Team Comparison**: Side-by-side developer stats

---

## 🐛 Troubleshooting

### No Data Showing
- Check browser console for errors
- Verify all modules loaded correctly
- Ensure using HTTP server (not `file://`)

### Module Loading Errors
- Check all file paths in imports
- Ensure using `type="module"` in script tag
- Verify browser supports ES6 modules

### Styles Not Loading
- Check `styles/main.css` path in HTML
- Clear browser cache
- Verify CSS file exists

---

## 📝 License

Part of the Sellio project.

---

**Last Updated**: 2026-01-18  
**Version**: 2.0.0 (Modular Architecture)
