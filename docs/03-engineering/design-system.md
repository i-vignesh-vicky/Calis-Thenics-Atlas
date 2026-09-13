# Atlas Design System

Single source of truth for Atlas visual decisions.
Update this document when any design decision is added, changed, or removed.
Do not hardcode visual values in feature code — always reference the tokens below.

---

## Visual Direction

**Dark/Focused** — disciplined, serious, athletic. Near-black foundation with a warm amber accent.
Inspired by the quality and restraint of tools like Vercel; translated into a mobile-first fitness context.

---

## Colors

### Raw Palette

| Token | Value | Use |
|-------|-------|-----|
| `black` | `#0A0A0A` | App background, nav bar |
| `surface` | `#141414` | Card and container surfaces |
| `surfaceElevated` | `#1E1E1E` | Inputs, elevated surfaces |
| `white` | `#FFFFFF` | Primary text, icons |
| `muted` | `#9E9E9E` | Secondary text, unselected states |
| `amber` | `#F5A623` | Primary accent — CTA, selected state, highlights |
| `error` | `#FF453A` | Errors and destructive actions |
| `success` | `#34C759` | Achievements, streaks, positive states |

### Material 3 Color Scheme Roles (dark)

| Role | Value | Notes |
|------|-------|-------|
| `primary` | `#F5A623` | Amber — main interactive color |
| `onPrimary` | `#1A0F00` | Dark text on amber surfaces |
| `primaryContainer` | `#3A2000` | Dark amber for containers |
| `onPrimaryContainer` | `#FFD9A0` | Light amber text on containers |
| `secondary` | `#2C2C2C` | Neutral secondary |
| `surface` | `#141414` | Default surface |
| `onSurface` | `#FFFFFF` | Primary text |
| `onSurfaceVariant` | `#9E9E9E` | Muted / secondary text |
| `outline` | `#2E2E2E` | Borders |
| `outlineVariant` | `#1C1C1C` | Subtle borders |
| `tertiary` | `#34C759` | Success green — achievements, streaks |
| `error` | `#FF453A` | Error state |
| `surfaceContainerLowest` | `#0A0A0A` | = black |
| `surfaceContainer` | `#141414` | = surface |
| `surfaceContainerHigh` | `#1E1E1E` | = surfaceElevated |
| `surfaceContainerHighest` | `#282828` | Highest elevation |

All values implemented in `frontend/lib/core/theme/app_colors.dart`.

---

## Typography

Material 3 default text theme applied; no additional font package for MVP.
System font: Roboto (Android) / SF Pro (iOS).

Text colors derive from `colorScheme.onSurface` and `colorScheme.onSurfaceVariant` via Material 3 — do not override per-widget.

Open question: custom typeface post-MVP (candidate: Inter or DM Sans).

---

## Spacing

4 pt base grid. All padding, margin, and gap values must use `AppSpacing` constants.

| Token | Value |
|-------|-------|
| `xs` | 4 pt |
| `sm` | 8 pt |
| `md` | 16 pt |
| `lg` | 24 pt |
| `xl` | 32 pt |
| `xxl` | 48 pt |
| `xxxl` | 64 pt |

Implemented in `frontend/lib/core/constants/app_spacing.dart`.

---

## Shape and Radius

| Token | Value | Use |
|-------|-------|-----|
| `none` | 0 | Sharp corners |
| `sm` | 4 pt | Small chips, tags |
| `md` | 8 pt | Buttons, inputs |
| `lg` | 12 pt | Cards |
| `xl` | 16 pt | Bottom sheets, modals |
| `xxl` | 24 pt | Large containers |
| `full` | 100 pt | Pills, avatars |

Implemented in `frontend/lib/core/constants/app_radius.dart`.

---

## Surfaces and Elevation

Atlas uses the Material 3 surface container model, not box shadows.
Elevation is expressed through surface color steps, not drop shadows.

| Level | Color | Token |
|-------|-------|-------|
| Background | `#0A0A0A` | `surfaceContainerLowest` |
| Default surface | `#141414` | `surfaceContainer` |
| Elevated (inputs, sheets) | `#1E1E1E` | `surfaceContainerHigh` |
| Highest | `#282828` | `surfaceContainerHighest` |

Card elevation: 0 (flat). Cards are distinguished by a 1 pt `outline` border.

---

## Borders

- Default border: 1 pt, `#2E2E2E`
- Focus border: 1.5 pt, `#F5A623` (amber)
- Error border: 1 pt, `#FF453A`

---

## Iconography

Material Symbols (outlined variant) — already available via `uses-material-design: true` in pubspec.
Consistent 24 pt size for navigation and content icons.
Icon color follows the component state: `white` for default, `amber` for selected/active, `muted` for disabled.

---

## Motion

| Token | Duration | Use |
|-------|----------|-----|
| `fast` | 150 ms | Micro-interactions (tap feedback, toggle) |
| `normal` | 250 ms | Screen transitions, reveals |
| `slow` | 350 ms | Emphasis moments (achievement unlock) |

Prefer `Curves.easeOut` for entrances, `Curves.easeIn` for exits.
Respect `MediaQuery.disableAnimations` for reduced-motion.

Implemented in `frontend/lib/core/constants/app_durations.dart`.

---

## Accessibility

- Minimum touch target: 48×48 pt (enforced by Material 3 defaults)
- Color contrast: WCAG AA minimum (amber `#F5A623` on black `#0A0A0A` = 5.8:1 — passes AA)
- Text scales with system font size — do not fix font sizes in points where Flutter scaling applies
- All interactive elements must have semantic labels
- Reduced-motion: check `MediaQuery.disableAnimations` before running decorative animations

---

## Component Behavior

### Buttons

| Variant | Background | Text/Icon | Use |
|---------|-----------|-----------|-----|
| Elevated (primary) | Amber `#F5A623` | Dark `#1A0F00` | Primary CTA |
| Outlined | Transparent | White | Secondary action |
| Text | Transparent | Amber | Tertiary / inline action |

Radius: `AppRadius.md` (8 pt). Padding: 24 pt horizontal, 14 pt vertical.

### Cards

Flat (elevation 0), `surface` background, 1 pt `outline` border, `AppRadius.lg` (12 pt) corners.

### Inputs

Filled, `surfaceElevated` background, `outline` border default, amber 1.5 pt border on focus.
Radius: `AppRadius.md` (8 pt).

### Navigation Bar

Background matches `black`. Amber icon + label for selected tab.
Indicator: amber at 15% opacity (`#26F5A623`). No visible elevation.

---

## Open Questions

| # | Question |
|---|----------|
| DS-001 | Custom typeface for stronger identity post-MVP (candidates: Inter, DM Sans) |
| DS-002 | Light theme — defer until post-MVP or user preference is confirmed |
