# AGENTS.md

Guidelines for any AI agent working on the Sellio mobile prototype in this repository.

## Critical: Check shared components BEFORE writing anything
Before creating or editing any CSS, JS, HTML, SVG, or mock data for a screen, **first read the existing shared components** to reuse what already exists. Do NOT duplicate styles, icons, or data.

Shared files (read these first):
- `assets/tokens.css` — design tokens (colors, typography, spacing)
- `assets/components.css` — shared component styles
- `assets/shared.css` — device frame, status bar, bottom nav, home indicator, search bar, product card, toast
- `assets/auth.css` — shared auth form styles (inputs, country picker, toast, OTP, bottom sheet)
- `assets/shared-icons.js` — all Flutter SVG icons as JS constants (`ICONS`, `SHARED_ICONS`) + `getStatusHTML()`
- `components/` — `bottom-nav.js`, `product-counter.js`, `favorites.js`, `toast.js`
- `data/mock-data.js` — shared `CATEGORIES`, `PRODUCTS`, `STORES`, `THRIFT_PRODUCTS`

If something already exists in a shared file, import and reuse it. Only add screen-specific code that does not already exist.

## Project rules
- **NEVER read from or work on the C version — only work on the D (design) version.**
- **NEVER write files to the Open Design workspace (C:\Users\aboud\AppData\Roaming\Open Design\...). All files MUST be written to `D:\workshop\sellio_mobile\design\`.**
- **NEVER copy files to the workspace.** The workspace is read-only for preview. All edits go to D.
- **Match the Flutter design 100%** — same tokens, same SVG icons, same spacing, same layout.
- **Mock data only** — no business logic. This is a design prototype.
- **Feature-by-feature** — build/refine one screen at a time.
- Use **actual Flutter SVG icons** from `packages/design_system/assets/svg/`.

## Project structure
```
design/
├── assets/      (tokens.css, components.css, shared.css, auth.css, shared-icons.js, images)
├── components/  (bottom-nav.js, product-counter.js, favorites.js, toast.js)
├── data/        (mock-data.js)
├── design-system/ (preview)
└── screens/
    ├── index.html
    ├── login/         (index.html, style.css, script.js)
    ├── create-account/
    ├── forgot-password/
    ├── home/
    ├── cart/
    └── thrift/
```

## Conventions
- Each screen lives in its own directory: `index.html` + `style.css` + `script.js`.
- Screens import shared files via `../../assets/` and `../../components/`.
- Auth screens (login, create-account, forgot-password) must import `auth.css` after `shared.css` and before their own `style.css`.
- `bottom-nav.js` must use **backtick** template literals (double quotes break SVGs with `width="24"`).
- Force monochrome SVGs white with `filter: brightness(0) invert(1)` (matches Flutter `ColorFilter.mode(onPrimary, BlendMode.srcIn)`).
- Auth simulation via `sessionStorage`: `isLoggedIn`, `isGuest`. OTP code is `9999`.
- Country flags render as real PNGs via `flagcdn.com/w40/<code>.png` (not emoji).
