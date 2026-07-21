# Sellio Mobile Prototype — Code Improvement Analysis

## Priority Summary

| Priority | Category | Impact | Effort |
|----------|----------|--------|--------|
| 🔴 **Critical** | Auth CSS duplication | ~600 lines duplicated across 3 files | Medium |
| 🔴 **Critical** | Auth country picker duplication | ~47 lines HTML + ~300 lines CSS across 3 files | Medium |
| 🟠 **High** | Inline SVG duplication | ~20+ duplicate SVG paths across 3-4 files | Low |
| 🟠 **High** | Auth scripts duplicated logic | Login/Create/ForgotPassword share 60%+ code | High |
| 🟡 **Medium** | CSS class naming inconsistency | Mix of conventions (`.btn-*`, `.sellio-*`, `.cart-*`, `.store-*`) | Low |
| 🟡 **Medium** | Device frame boilerplate | 5 identical lines × 7 screens | Low |
| 🟡 **Medium** | Import block duplication | ~6 lines × 7 screens | Low |
| 🟢 **Low** | CSS `components.css` underutilized | Auth screens ignore `.sellio-*` component classes | Medium |
| 🟢 **Low** | No CSS minification/concatenation | 9+ CSS requests per page | Low |
| 🟢 **Low** | Reduced motion duplicated | Same media query in 4 CSS files | Low |

---

## 1. 🔴 Auth CSS Duplication (~600 lines)

**Problem:** Three auth screens (`login`, `create-account`, `forgot-password`) duplicate nearly identical CSS for form controls, country selector, buttons, loading dots, toast, and the home indicator.

| CSS Feature | login/ | create-account/ | forgot-password/ |
|---|---|---|---|
| `.input-container` | ✓ | ✓ | ✓ |
| `.input-icon` | ✓ | ✓ | ✓ |
| `.input-field` | ✓ | ✓ | ✓ |
| `.country-selector` | ✓ | ✓ | ✓ |
| `.country-flag` / `.country-code` | ✓ | ✓ | ✓ |
| `.password-field` / `.eye-btn` | ✓ | ✓ | ✓ |
| `.error-msg` | ✓ | ✓ | ✓ |
| `.phone-counter` | ✓ | ✓ | ✓ |
| `.loading-dots` | ✓ | ✓ | ✓ |
| `.btn-login` / `.btn-send` / `.btn-continue` | ✓ | ✓ | ✓ |
| `.toast` | ✓ | ✓ | ✓ |
| `.home-indicator` | ✓ | ✓ | ✓ |
| Bottom sheet styles | ✓ | ✓ | ✓ |

**Solution:** Create `assets/auth.css` with all shared auth form styles. Each auth screen's `style.css` then only contains screen-specific styles (`.forget-row`, `.divider-row`, `.success-overlay`, OTP styles, etc.).

**Estimated reduction:** ~500 lines removed, ~200 lines added to shared file = **~300 lines net reduction**.

---

## 2. 🔴 Country Picker Bottom Sheet Duplication (HTML + CSS + JS)

**Problem:** The country picker bottom sheet is duplicated across all three auth screens with slight class name differences:

| Aspect | login/ | create-account/ | forgot-password/ |
|---|---|---|---|
| Sheet class | `.country-sheet` | `.bottom-sheet` | `.bottom-sheet` |
| HTML lines | 17 | 15 | 15 |
| CSS lines | ~132 | ~107 | ~71 |
| JS lines | ~120 (COUNTRIES + render + events) | ~120 (duplicate) | ~120 (duplicate) |

The `COUNTRIES` array (20 countries with dial codes, flags, max lengths) is identical in all three `script.js` files.

**Solution:**

1. **Move `COUNTRIES` and `FAVORITE_CODES` to `data/mock-data.js`** (shared data).
2. **Create a `country-picker.js` component** in `components/` that handles rendering, search/filter, selection, and emits a callback.
3. **Use shared `.sellio-sheet-*` classes** from `components.css` instead of custom `.sheet-overlay`/`.bottom-sheet` classes.

**Estimated reduction:** ~350 lines removed across 3 files, ~80 lines added to shared files = **~270 lines net reduction**.

---

## 3. 🟠 Inline SVG Duplication

**Problem:** The same SVG paths are inlined in multiple HTML files instead of being extracted into `shared-icons.js`.

| SVG Icon | Currently in | Should be in `SHARED_ICONS` |
|---|---|---|
| Close/X | login, create-account | `close` |
| Phone | login, create-account, forgot-password | `phone` |
| Chevron down | login, create-account (×2), forgot-password | `chevronDown` |
| Lock/password | login, create-account (×2), forgot-password (×4) | `lock` |
| Eye open/closed | login, create-account, forgot-password | `eyeOpen` / `eyeClosed` |
| Search | login, create-account (×2), forgot-password | `searchSmall` |
| Back arrow | create-account, forgot-password | `arrowBack` |

**Example duplication:** The phone SVG path `M6.62 10.79...` (~113 chars) appears 3 times. The lock icon appears **7 times** across auth screens.

**Solution:** Add all missing icons to `SHARED_ICONS` in `assets/shared-icons.js`, then reference them as `SHARED_ICONS.phone` in HTML (via `innerHTML`).

**Estimated reduction:** ~20+ inline SVG blocks → 7 constants in shared file.

---

## 4. 🟠 Auth Script Logic Duplication

**Problem:** The three auth scripts share ~60% of their code:

- Country list data + render + search/filter + selection
- Phone input validation (format, length, counter)
- Field focus/blur/error state management
- Toast show/hide logic
- Password eye toggle

Yet these are maintained as separate files with copy-paste.

**Solution:** Create a shared `auth-helpers.js` in `components/`:

```js
// components/auth-helpers.js
var AuthHelpers = {
  // Country picker
  initCountryPicker: function(opts) { ... },
  // Phone field
  initPhoneField: function(inputId, counterId, errorId) { ... },
  // Password field
  initPasswordField: function(inputId, toggleId, errorId) { ... },
  // Toast
  showToast: function(type, message) { ... },
  // Loading state
  setLoading: function(btnEl, isLoading) { ... },
};
```

**Estimated reduction:** ~200 lines per auth script → ~400 lines net reduction.

---

## 5. 🟡 CSS Class Naming Inconsistency

**Problem:** The codebase uses multiple naming conventions inconsistently:

| Convention | Examples | Location |
|---|---|---|
| `.sellio-*` | `.sellio-button`, `.sellio-field` | `components.css` (shared) |
| `.cart-*` | `.cart-item`, `.cart-counter` | `screens/cart/style.css` |
| `.store-*` | `.store-header`, `.store-tabs` | `screens/store/style.css` |
| `.btn-*` | `.btn-login`, `.btn-create`, `.btn-send` | auth `style.css` files |
| `.order-*` | `.order-overlay`, `.order-sheet` | `screens/cart/style.css` |
| `.thrift-*` | `.thrift-tabs`, `.thrift-content` | `screens/thrift/style.css` |

Cart's `.cart-counter` duplicates the same logic as `components.css` `.counter`. Cart's `.cart-item` duplicates `.sellio-product-h-card`.

**Solution:** Prefer extending `.sellio-*` classes from `components.css` over creating new screen-specific class names for the same visual patterns. Add new generic `.sellio-*` components to `components.css` when a pattern appears in 2+ screens.

---

## 6. 🟡 Device Frame Boilerplate

**Problem:** Every screen's HTML includes identical device frame markup:

```html
<span class="btn-rail left-1" aria-hidden></span>
<span class="btn-rail left-2" aria-hidden></span>
<span class="btn-rail left-3" aria-hidden></span>
<span class="btn-rail right-1" aria-hidden></span>
<span class="island" aria-hidden></span>
<!-- + home-indicator at end -->
```

This is 5 lines × 7 screens = **35 lines of identical markup**.

**Solution:** Generate the device frame shell via JS, similar to how `getDeviceFrameHTML()` exists in `shared-icons.js` but is only used by the design system preview. Create a `components/device-frame.js` that screens can call to inject the frame wrapper:

```js
// Components would then only need:
<div id="screen-shell"></div>
<script>renderDeviceFrame('screen-shell', 'Home', contentHTML);</script>
```

**Alternatively** (lighter-weight): Use a JS template literal in each screen to stamp the rails, island, and home indicator rather than hardcoding them.

---

## 7. 🟡 Import Block Boilerplate

**Problem:** All 7 screens repeat the same 6-line import block:

```html
<link rel="stylesheet" href="../../assets/tokens.css">
<link rel="stylesheet" href="../../assets/components.css">
<link rel="stylesheet" href="../../assets/shared.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
```

7 lines × 7 files = **49 lines of identical markup**.

**Solution:** Since this is a static HTML prototype, you can't use server-side includes. The cleanest approach for pure HTML is to create a small `assets/head.html` snippet as documentation, or use a build tool (parcel, vite) to inject shared `<head>` content. For now, just documenting as a known duplication is acceptable.

---

## 8. 🟢 Underutilized `components.css` Classes

**Problem:** Several screens reimplement styles that already exist in `components.css`:

| Screen | Custom CSS | Equivalent `.sellio-*` class |
|---|---|---|
| auth screens | `.input-container` | `.sellio-field__input-wrap` |
| auth screens | `.input-field` | `.sellio-field__input` |
| auth screens | `.input-icon` | `.sellio-field__prefix-icon` |
| auth screens | `.btn-login` | `.sellio-button--primary` |
| auth screens | `.loading-dots` | `.sellio-loading-dots` |
| auth screens | `.sheet-overlay` / `.bottom-sheet` | `.sellio-sheet-overlay` / `.sellio-sheet` |
| cart | `.cart-item` | `.sellio-product-h-card` |
| cart | `.cart-counter` | `.sellio-product-h-card__counter` |
| cart | `.order-overlay` / `.order-sheet` | `.sellio-sheet-overlay` / `.sellio-sheet` |
| home | custom appbar | `.sellio-appbar` |
| home | custom search | `.sellio-search` |

**Solution:** Refactor screens to use existing `.sellio-*` component classes where possible, then add screen-specific overrides only for unique layout needs. This reduces CSS file sizes and improves consistency.

**Example:** The cart's order confirmation sheet is structurally identical to the bottom sheet in `components.css` (overlay + sheet + handle + bar). Using `.sellio-sheet-overlay` and `.sellio-sheet` would remove ~35 lines from `cart/style.css`.

---

## 9. 🟢 No CSS Minification / Optimization

**Problem:** The prototype loads 3-4 CSS files per page with no bundling or minification. Total CSS per screen:

| Screen | CSS files | Estimated raw CSS |
|---|---|---|
| `login` | tokens(288) + components(1516) + shared(501) + style(546) | ~2851 lines |
| `home` | tokens + components + shared + style(526) | ~2831 lines |
| `store` | tokens + components + shared + style(461) | ~2766 lines |

**Solution:** For a design prototype, this is acceptable. If performance becomes a concern, consider:
- Using a simple build step to concatenate + minify CSS
- Removing unused CSS rules (tokens.css has animation durations that aren't all used)
- Ideally not needed since this is a prototype with mock data

---

## 10. 🟢 Reduced Motion Duplication

**Problem:** The `prefers-reduced-motion` media query appears in:

- `assets/shared.css` (line 496)
- `screens/login/style.css` (line 541)
- `screens/create-account/style.css`
- `screens/forgot-password/style.css`

Since `shared.css` is loaded by every screen, the duplicated queries in auth screen style files are redundant.

**Solution:** Remove the reduced motion query from auth screen CSS files since it's already in `shared.css`.

---

## Overall Recommendation

| Go for quick wins | Plan for later |
|---|---|
| ✅ Extract SVGs to `shared-icons.js` | 🔄 Create `assets/auth-shared.css` |
| ✅ Remove duplicate reduced motion | 🔄 Create `components/auth-helpers.js` |
| ✅ Remove duplicate home indicator CSS | 🔄 Create `components/country-picker.js` |

The **highest ROI** is consolidating the auth screen CSS into a shared file (removes ~500 lines) and extracting the country picker into a reusable component (removes ~350 lines). Together they'd cut the auth screens' size by roughly half.
