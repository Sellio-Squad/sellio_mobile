# Sellio Mobile Prototype — Code Structure Analysis

## Overview

This is an **HTML/CSS/JS design prototype** of the Sellio e-commerce mobile app, matching the Flutter design system 1:1. It uses mock data only — no business logic, no backend. Each screen is self-contained within a device frame (iPhone-like mockup) with a status bar, bottom navigation, and home indicator.

---

## Directory Structure

```
design/
├── AGENTS.md                  # Guidelines for AI agents working on this repo
├── assets/                    # Shared design resources
│   ├── tokens.css             # Design tokens (colors, typography, spacing, shadows)
│   ├── components.css         # Reusable component styles (buttons, fields, chips, etc.)
│   ├── shared.css             # Device frame, status bar, nav, search bar, product cards, toast
│   ├── shared-icons.js        # Flutter SVG icons as JS constants + status bar/device frame HTML
│   ├── .webp / .svg           # Static images (logos, illustrations)
├── components/                # Reusable JS components
│   ├── bottom-nav.js          # Bottom nav bar — icons, populateNav(), initNavClickHandlers()
│   ├── product-counter.js     # Cart add/remove/increment counter logic
│   ├── favorites.js           # Heart toggle for product favorite/unfavorite
│   └── toast.js               # Simple toast notification
├── data/
│   └── mock-data.js           # CATEGORIES, PRODUCTS, STORES, STORE_DETAIL, THRIFT_PRODUCTS
├── design-system/             # Design system preview page
│   ├── index.html             # Full visual reference of all tokens + components
│   ├── tokens.css             # Duplicate of assets/tokens.css (self-contained preview)
│   └── components.css          # Duplicate of assets/components.css (self-contained preview)
├── screens/                   # All app screens
│   ├── index.html             # Screen hub / navigation page
│   ├── login/                 # Login with phone/password, country picker, validation
│   ├── create-account/        # Registration with name, phone, city, password, OTP verification
│   ├── forgot-password/       # 3-step flow: phone → OTP → reset password
│   ├── home/                  # App bar, search, categories grid, trending, stores, guest overlay
│   ├── cart/                  # Cart items, counters, dashes, note, order confirmation sheet
│   ├── store/                 # Store detail page with shimmer loading, categories, products
│   └── thrift/                # Thrift section with search, category tabs, 2-column product grid
└── docs/                      # Documentation
    └── code-structure-analysis.md   # This file
```

---

## Architecture & Patterns

### 1. Screen Convention
Every screen follows the same pattern:
- `index.html` — markup with `stage` → `device` → `screen` → content structure
- `style.css` — screen-specific styles (imports shared assets via `../../assets/`)
- `script.js` — screen-specific behavior (imports shared scripts via `../../`)

### 2. Shared Resource Imports
Screens load shared resources in this order:
```html
<link rel="stylesheet" href="../../assets/tokens.css">
<link rel="stylesheet" href="../../assets/components.css">
<link rel="stylesheet" href="../../assets/shared.css">
<script src="../../assets/shared-icons.js"></script>
<script src="../../components/bottom-nav.js"></script>
<!-- screen-specific component scripts -->
<script src="../../data/mock-data.js"></script>
<script src="script.js"></script>
```

### 3. Device Frame Wrapper
Each screen is wrapped in a device mockup with:
- Phone silhouette with rounded corners, bezels, button rails
- Dynamic Island (notch) at top
- Status bar (time + signal/WiFi/battery icons)
- Screen area with `screen-content` scrollable region
- Home indicator bar at bottom
- Caption label above the device

### 4. Auth Simulation
- Uses `sessionStorage` keys: `isLoggedIn`, `isGuest`
- OTP verification code is hardcoded as `9999`
- Country flags rendered as real PNGs via `flagcdn.com/w40/<code>.png`

### 5. Component System

#### Bottom Navigation (`components/bottom-nav.js`)
- 5 tabs: Home, Cart, Sell (center FAB), Thrift, Account
- SVG icons stored in `BOTTOM_NAV_ICONS` constant with selected/unselected variants
- `populateBottomNav(activeTab)` sets icons + highlights the active tab
- `initNavClickHandlers(handlers)` manages tab switching + page navigation

#### Product Counter (`components/product-counter.js`)
- Manages cart state via `cartCounts` object (productId → quantity)
- Renders "Add" button or counter (+/-) depending on quantity
- Zero state: add button → increment creates counter
- Counter: minus (or delete icon when count=1), value, plus

#### Favorites (`components/favorites.js`)
- Toggles `.favorited` class on click
- Swaps between `heart` (outline) and `heartFav` (filled) icons from `SHARED_ICONS`

#### Toast (`components/toast.js`)
- Simple `showToast(message, duration)` — fades in at bottom, auto-dismisses

### 6. Design Token System (`assets/tokens.css`)

| Category | Details |
|---|---|
| **Colors** | Brand (`#520826`, `#F5A623`), surfaces, text with opacity (87%, 66%, 38%, 12%), states (error, success), auth background |
| **Typography** | Rubik font family, 12 text styles (headline, title, body, label) with weight/size/line-height |
| **Spacing** | Padding (8/12/16px), section/item spacing, icon sizes (16/24/32px), radius (4/8/12/100px) |
| **Shadows** | Field focus, nav bar, snackbar (error/success), checkbox, OTP focus, dropdown |
| **Animation** | Durations for loading dots, switch, thumbnail, indicator, nav, snackbar |

### 7. Component Styles (`assets/components.css`)

Over 1500 lines covering:
- **Button** — primary, secondary, disabled, outline, small, loading dots
- **Text Field** — default, focused, error, phone (with country selector), picker field
- **Chip** — selected/unselected with icon container
- **Switch** — on/off/disabled with animated thumb
- **Checkbox & Radio** — checked/unchecked/disabled states
- **OTP Input** — focused/filled/empty card states with blinking cursor
- **App Bar** — back button, title, subtitle
- **Bottom Nav** — 5-tab layout with center FAB
- **Bottom Sheet** — overlay with drag handle, list items, search
- **Snackbar** — error/success with icon, title, message, close button
- **Section Header** — title + optional "See All" action
- **Empty State** — icon, title, description, CTA button
- **Product Cards** — vertical card (for grid), horizontal card (for cart), with counter, favorite, discount, out-of-stock overlay
- **Store Card** — image with gradient overlay, favorite, title
- **Search Bar** — input with filter button
- **Discount Tag** — sparkle icon + text
- **Page Indicator** — active/inactive dots
- **Dividers** — solid and dashed
- **Auth Background** — gradient pattern, logo, close button, white card overlay

### 8. Shared Layout (`assets/shared.css`)

- Device frame (390×844px iPhone mockup)
- Status bar component
- Home indicator
- Bottom navigation bar
- App bar
- Search bar
- Scrollable content area
- Product card (vertical)
- Product counter
- Toast
- Section header
- Reduced motion media query

### 9. Mock Data (`data/mock-data.js`)

| Dataset | Description |
|---|---|
| `CATEGORIES` | 8 categories (Electronics, Fashion, Home, Beauty, Sports, Books, Toys, More) with images |
| `PRODUCTS` | 12 products with id, title, price, discount, category, image, favorited status |
| `STORES` | 3 stores with name, discount, gradient background, image |
| `STORE_DETAIL` | Full store profile with categories, 8 products, 2 featured products |
| `THRIFT_PRODUCTS` | 12 thrift products with price, discount, category, favorite status |

---

## Screen-by-Screen Breakdown

### Screen Hub (`screens/index.html`)
- Grid of links to all screens organized by category (App Screens, Auth Screens, Design Tokens)
- Describes each screen's features

### Login (`screens/login/`)
- Phone field with country selector (bottom sheet)
- Password field with eye toggle
- Validation with error messages
- Loading state on submit
- "Forget your Password?" link
- "Create account" alternative
- Success overlay on login
- Country picker with search + favorites

### Create Account (`screens/create-account/`)
- Full name, phone (country picker), city (picker), password, confirm password
- Validation for each field
- OTP verification overlay (4-digit input, countdown resend)
- Country picker + City picker bottom sheets
- Back button, close button

### Forgot Password (`screens/forgot-password/`)
- 3-step flow: Phone → OTP → New Password
- Phone section with lock icon + country picker
- Reset password section (shown after OTP)
- Password visibility toggle
- Loading + success handling

### Home (`screens/home/`)
- Custom app bar with logo, welcome text, location, notification bell + badge
- Search bar (read-only)
- Categories horizontal grid (populated from mock data)
- Trending products (horizontal scroll cards)
- Top stores (horizontal scroll cards)
- Guest overlay (shown when not logged in)
- Bottom navigation with cart badge
- Product counter + favorites integration

### Cart (`screens/cart/`)
- App bar with back + title
- Cart items list (horizontal product cards)
- Quantity counters per item
- Dashed dividers between items
- Note/special request section
- Bottom bar with total price + confirm button
- Order confirmation bottom sheet with order number
- Empty cart state
- Bottom navigation

### Store (`screens/store/`)
- Loading shimmer animation (cover, profile, lines, tabs, product cards)
- Store header: cover image, profile circle, discount tag
- Store info: name, location, rating, categories, description
- Featured items horizontal scroll
- Category tabs (horizontal scroll)
- Products grid (2-column)
- Favorite button + info button
- Back navigation
- Bottom navigation

### Thrift (`screens/thrift/`)
- App bar with title
- Search bar with filter button
- Category tabs (loaded from categories)
- 2-column product grid
- Product cards with discount tags, favorite buttons, add-to-cart
- Filter button with bottom sheet (under development)
- Loading shimmer state
- Bottom navigation

---

## Key Architecture Decisions

1. **No framework** — pure vanilla HTML/CSS/JS for maximum simplicity
2. **SVG icons** — imported 1:1 from Flutter design system SVG files, embedded as JS template literals
3. **Device frame pattern** — every screen is rendered inside a phone mockup for presentation-ready previews
4. **Modular components** — shared JS modules (bottom-nav, product-counter, favorites, toast) avoid code duplication
5. **CSS custom properties** — single source of truth for design tokens via `:root` variables
6. **Mock data first** — all data is static JS objects, no API calls
7. **Auth via sessionStorage** — simple login simulation without real authentication
8. **Screen-specific CSS** — each screen has its own `style.css` that only adds what's not already in shared files

---

## Naming Conventions

| Pattern | Example | Location |
|---|---|---|
| `--color-*`, `--text-*`, `--spacing-*` | `--color-primary`, `--text-title-medium` | CSS custom properties |
| `.sellio-*` | `.sellio-button`, `.sellio-field` | Component classes in `components.css` |
| `.screen-*` | `.screen-content`, `.screen--primary` | Layout in `shared.css` |
| `*__*` (BEM) | `.product-card__title`, `.sellio-nav__item` | BEM-style element selectors |
| `*--*` (modifier) | `.sellio-button--primary`, `.sellio-chip--selected` | BEM-style state modifiers |
| `UPPER_CASE` | `CATEGORIES`, `PRODUCTS`, `SHARED_ICONS` | JS constants (global) |
| `camelCase` | `getDeviceFrameHTML`, `populateBottomNav` | JS functions |
