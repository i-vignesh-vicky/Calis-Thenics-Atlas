# Atlas UI Foundation Skill

This skill defines how Claude should design and implement the Atlas mobile UI foundation.

It does NOT duplicate project requirements, architecture, or domain decisions from `docs/`.

| Source | Purpose |
|--------|---------|
| `CLAUDE.md` | Repository instructions and navigation |
| `ARCHITECTURE.md` | Routing, framework, and platform decisions |
| `CONVENTIONS.md` | Naming and folder structure |
| `docs/03-engineering/frontend.md` | Frontend architecture, principles, navigation, and state |
| `docs/03-engineering/design-system.md` | Atlas design tokens and visual decisions (source of truth) |
| `docs/delivery/` | MVP scope and active stories |
| `SKILL.md` | UI engineering behavior and workflow |

---

## Skill Scope

This skill activates for work in:

- `frontend/lib/core/` — theme, constants, styles
- `frontend/lib/design-system/` — primitives and shared components
- `frontend/lib/shared/` — shared components and utilities
- `frontend/lib/app/` — app shell, router, navigation state
- Any task that establishes the visual language, layout containers, or navigation structure

For feature implementation (authentication, exercises, workouts, etc.), follow the `atlas-engineering` skill. This skill governs the foundation those features sit on.

---

## Design Workflow

For any UI foundation work:

```
Understand requirement
-> Check docs/03-engineering/frontend.md
-> Check docs/03-engineering/design-system.md
-> Inspect existing implementation
-> Identify reusable patterns
-> Design or propose when decision is non-obvious
-> Implement
-> Test
-> Review consistency against design system
```

Do not generate a screen or component without understanding the surrounding system.

Before introducing a new visual pattern, verify no existing Atlas pattern already solves it.

---

## Design References

Two external references inform Atlas design thinking:

- **Taste** — visual quality, composition, hierarchy, and design thinking
- **Vercel Design Guidelines** — simplicity, hierarchy, spacing, interaction quality, and usability

These are sources of **principles only**. Do not copy either system.

For mobile, translate useful web principles into Flutter/mobile interaction patterns.

**The Atlas Design System is the final authority.**

---

## Atlas Design Principles

Favor:

- Clear visual hierarchy
- Strong and approachable visual identity
- Purposeful whitespace
- Mobile-first, one-handed layouts
- Touch-friendly targets and interactions
- Consistency across screens
- Simple and understandable interfaces
- Purposeful motion that communicates
- Accessible interactions built in
- Reusable patterns over one-off styling
- Visual clarity over decoration

Avoid:

- Visual clutter
- Excessive cards or containers
- Unnecessary gradients or effects
- Excessive or distracting animation
- One-off inline styling
- Random spacing or typography values
- Generic fitness-app visual patterns
- Copying other apps' design systems
- Premature design-system complexity

Every visual decision should have a reason.

---

## Design System Source of Truth

All Atlas visual decisions live in:

```
docs/03-engineering/design-system.md
```

It defines the canonical values and decisions for:

- Colors and palette
- Typography (scale, weights, line heights)
- Spacing scale
- Shape and border radius
- Surfaces and elevation
- Borders
- Iconography
- Motion and animation
- Accessibility requirements
- Component behavior conventions

**Implementation rule:** Use centralized design tokens and theme values throughout. Do not hardcode color, spacing, or typography values in individual files.

If implementation reveals a missing design decision, add it to `design-system.md` rather than creating an isolated workaround.

---

## Flutter Foundation Responsibilities

The UI foundation establishes:

- Global `ThemeData` and `ColorScheme`
- Design tokens accessible throughout the app
- Typography scale
- Spacing constants
- Shape and radius definitions
- Reusable core component styles
- Navigation shell with `go_router`
- Reusable UI primitives (button, card, input, empty state, loading state, error state)

Do not build for hypothetical future requirements. Build what current stories actually need.

---

## Project Structure Alignment

Follow the folder structure from `docs/03-engineering/frontend.md`:

```
frontend/lib/
  core/
    theme/       <- ThemeData, ColorScheme, TextTheme
    constants/   <- spacing, radius, duration constants
    styles/      <- shared style helpers
  design-system/
    buttons/
    cards/
    inputs/
    typography/
    dialogs/
    lists/
  shared/
    components/  <- higher-order shared components
    utilities/
  app/
    router.dart  <- go_router configuration
    shell.dart   <- navigation shell scaffold
```

Do not reorganize this structure without an explicit decision.

---

## Navigation

Routing uses **`go_router`** — the project-wide approved package. This is an architecture invariant.

Do not use Navigator 1.0 `push`/`pop` for feature navigation. All routes are declared centrally under `lib/app/`.

The navigation shell must support (without implementing early):

- Authentication route guarding
- Bottom tab navigation for the five main areas
- Nested navigation within feature modules
- Deep links
- Future feature modules added without restructuring the shell

The five primary navigation areas (from `docs/03-engineering/frontend.md`):

| Tab | Purpose |
|-----|---------|
| Home | Dashboard and quick access |
| Workouts | Log and view workouts |
| Community | Social feed |
| Progress | Statistics and achievements |
| Profile | Settings and preferences |

Do not implement feature functionality merely to demonstrate navigation working. Placeholder screens are sufficient during foundation work.

---

## Component Rules

Before creating any new component:

1. Search the existing codebase.
2. Check `design-system.md` for a documented pattern.
3. Reuse an existing component if one exists.
4. Extend it when appropriate.
5. Create new only when the pattern is genuinely reusable and not already solved.

Do not create duplicate components that solve the same problem with slightly different styling.

Feature-specific business logic must not appear in reusable UI components.

Components must be:

- Reusable across feature screens
- Composable from smaller primitives
- Accessible (contrast, touch targets, semantic labels)
- Testable in isolation
- Independent of feature state or services

---

## States

Every reusable component or screen region must handle:

| State | Approach |
|-------|----------|
| Loading | Skeleton screen or progress indicator (no blank screens) |
| Empty | Informative message + primary action (guide, do not abandon) |
| Error | Friendly, actionable message (no raw exceptions) |
| Content | Normal rendered content |

These states are part of the foundation, not features. Wire them into reusable wrappers so feature screens do not re-implement them.

---

## Foundation Showcase

A small internal showcase surface may be used to validate the design system visually before feature development begins.

Include in the showcase:

- Typography scale
- Color palette and surfaces
- Spacing and layout grid
- Button variants and states
- Card variants
- Input variants
- Loading/empty/error states
- Navigation structure

This is a **design validation tool**, not a production feature. It should be clearly separated from feature code and excluded from production routes if built.

---

## Accessibility

Treat accessibility as a foundation requirement, not a feature.

Built-in requirements for all reusable components:

- Color contrast meets WCAG AA minimum
- Touch targets are at least 48x48 dp
- Text scales with system font size
- Semantic labels on interactive elements
- Screen reader support for critical interactions
- Focus behavior is logical and predictable
- Motion respects reduced-motion preferences where Flutter supports it

Accessibility must be built into the components, not fixed separately on every feature screen.

---

## Design Decisions — When to Escalate

Some UI decisions have identity or architectural weight. Do not decide silently.

Stop and propose before implementing when:

- Choosing the core visual identity (primary colors, typeface, overall tone)
- Establishing the navigation structure for the first time
- Introducing a new interaction pattern not documented in `design-system.md`
- Making changes to the global theme that affect every screen
- Adding a dependency for a UI component library or animation package

For these decisions:

```
Identify the decision
-> Explain the options and trade-offs
-> Recommend one
-> Ask for approval before locking it in
```

For small, low-risk decisions aligned with documented principles, proceed and note the choice briefly.

---

## Engineering Discipline

Follow `docs/03-engineering/frontend.md` and `CONVENTIONS.md` at all times.

Do not:

- Add UI library dependencies without explicit approval
- Introduce a new state-management approach without checking the architecture
- Create a second or parallel theme system
- Hardcode colors, spacing, or typography in feature files
- Mix feature business logic into shared UI components
- Over-engineer the foundation for hypothetical future screens
- Modify feature areas while building the foundation
- Import feature-layer packages into `core/` or `design-system/`

Prefer clear, simple Flutter code. The foundation should be easy for one developer to read and maintain at 2 AM.

---

## Definition of Done

The UI foundation is complete when it provides:

- A documented Atlas visual language in `design-system.md`
- Centralized design tokens consumed by the global `ThemeData`
- Typography and spacing constants available to all screens
- Reusable core components (button, card, input, empty state, loading state, error state)
- Consistent loading, error, and empty state patterns
- Accessible component behavior built in
- A stable `go_router` navigation shell for the five main areas
- Route placeholders for every MVP screen area
- A way to visually validate the foundation (showcase or equivalent)
- Tests for important reusable component behavior
- No feature-specific business logic in the foundation layer

Most importantly:

> **Future screens should consume the Atlas foundation instead of inventing their own visual language.**

---

## Source of Truth Hierarchy

```
Atlas Product / Domain / Architecture docs
              |
      docs/03-engineering/design-system.md
              |
      Flutter UI Foundation (core/, design-system/, app/)
              |
        Feature Screens
```

External references:

```
Taste ---------------+
                     +-> Atlas Design Decisions -> design-system.md
Vercel Guidelines ---+
```

Taste and Vercel provide principles and inspiration only. They do not define Atlas.

---

**The Atlas design system defines the visual language. This skill defines how Claude builds it.**
