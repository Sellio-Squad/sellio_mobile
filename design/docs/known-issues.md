# Known Issues

## Fixed

| Issue | Status | Lines saved | Ticket |
|---|---|---|---|
| Auth CSS duplication (inputs, country picker, toast, OTP, bottom sheet, loading dots) | ✅ Fixed | 552 | #1 |
| Country picker data/JS duplication across 3 auth screens (COUNTRIES, flagImg, render/search/select) | ✅ Fixed | ~360 | #2 |

## Remaining

### 🟠 Issue #3 — Inline SVG Icon Duplication

**Files:** `screens/login/index.html`, `screens/create-account/index.html`, `screens/forgot-password/index.html`

**Problem:** Same SVG paths inlined across multiple HTML files instead of using `SHARED_ICONS` constants from `assets/shared-icons.js`.

| SVG Icon | Occurrences |
|---|---|
| Close/X (`M18 6 6 18M6 6l12 12`) | login, create-account |
| Phone (`M6.62 10.79...`) | login, create-account, forgot-password |
| Chevron down (`M7 10l5 5 5-5z`) | login, create-account (×2), forgot-password |
| Lock/password (`M18 8h-1V6...`) | login, create-account (×2), forgot-password (×4) |
| Eye open/closed | login, create-account, forgot-password |
| Search (`M15.5 14h-.79...`) | login, create-account (×2), forgot-password |
| Back arrow (`M20 12H4M10 18l-6-6 6-6`) | create-account, forgot-password |

---

### 🟠 Issue #4 — Auth Script Logic Duplication

**Files:** `screens/login/script.js`, `screens/create-account/script.js`, `screens/forgot-password/script.js`

**Problem:** Three auth scripts share ~60% of their code (country picker render/search/selection, phone input validation, field focus/blur/error handling, toast, loading state), but are maintained independently.

---

### 🟡 Issue #5 — CSS Class Naming Inconsistency

**Files:** `screens/cart/style.css`, `screens/store/style.css`, `screens/thrift/style.css`, `screens/home/style.css`

**Problem:** Multiple naming conventions used across screens instead of extending `.sellio-*` from `components.css`:

| Screen | Custom classes | Equivalent `.sellio-*` |
|---|---|---|
| cart | `.cart-item`, `.cart-counter` | `.sellio-product-h-card`, `.sellio-product-h-card__counter` |
| cart | `.order-overlay`, `.order-sheet` | `.sellio-sheet-overlay`, `.sellio-sheet` |
| home | custom appbar/search markup | `.sellio-appbar`, `.sellio-search` |
| store | `.store-header`, `.store-tabs` | — |

---

### 🟡 Issue #6 — Device Frame Boilerplate

**Files:** All 7 screen `index.html` files

**Problem:** Every screen's HTML repeats identical device frame markup:
```html
<span class="btn-rail left-1" aria-hidden></span>
<span class="btn-rail left-2" aria-hidden></span>
<span class="btn-rail left-3" aria-hidden></span>
<span class="btn-rail right-1" aria-hidden></span>
<span class="island" aria-hidden></span>
```
5 lines × 7 screens = 35 lines of identical markup.

---

### 🟡 Issue #7 — Import Block Boilerplate

**Files:** All 7 screen `index.html` files

**Problem:** The CSS/Google Fonts import block is identical across all screens:
```html
<link rel="stylesheet" href="../../assets/tokens.css">
<link rel="stylesheet" href="../../assets/components.css">
<link rel="stylesheet" href="../../assets/shared.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
...
```
6 lines × 7 files = 42 lines.

---

### 🟢 Issue #8 — Underutilized `components.css` Classes

**Files:** `screens/cart/style.css`, all auth `style.css` files

**Problem:** Several screens reimplement styles that exist in `components.css`. Cart defines its own `.cart-item` matching `.sellio-product-h-card`. Auth screens (pre-fix) had custom inputs matching `.sellio-field__*`.

---

### 🟢 Issue #9 — No CSS Build / Optimization

**Files:** All screens

**Problem:** 3–4 CSS files loaded per screen with no bundling or minification. Total ~2,800 CSS lines per screen.

---

### 🟢 Issue #10 — Redundant Home Indicator in auth.css

**File:** `assets/auth.css`

**Problem:** `assets/auth.css` overrides `.home-indicator` (from `shared.css`) with `flex: 0 0 28px; position: relative;` because auth screens use a different layout. This is a necessary override, but the duplication between `shared.css` and `auth.css` is a maintenance concern if the indicator design changes.
