# Frontend Architecture

## Purpose

This document defines the frontend architecture, design principles, state management philosophy, module organization, and development guidelines for the mobile application.

The frontend must deliver a world-class user experience while remaining scalable, maintainable, and extensible for years of product evolution.

---

## Design Philosophy

The frontend is where users experience the product. Every interaction should reinforce the core mission: **helping people become healthier through consistency, discipline, and meaningful progress.**

### Core Principles

The frontend prioritizes:

1. **Simplicity** — Remove unnecessary complexity
2. **Speed** — Responsive interactions and fast loading
3. **Clarity** — Obvious intent and direction
4. **Consistency** — Unified design language and behavior
5. **Accessibility** — Usable by everyone
6. **Delight** — Thoughtful details that enhance experience
7. **Predictability** — Behavior matches user expectations

The best interface disappears, allowing users to focus on their fitness journey rather than learning the application.

---

## User Experience Principles

### Question Every Screen Answers

Every screen must answer: **"What is the user trying to accomplish right now?"**

Not: "What data do we have?"

The UI exists to help users complete tasks, not to expose database records.

### Mobile-First Design

The MVP targets mobile users. Optimize for:

- One-handed usage
- Fast interactions
- Short attention spans
- Network interruptions
- Small screens

Desktop experiences can evolve later.

### Frontend Responsibilities

The frontend is responsible for:
- ✓ Presenting information clearly
- ✓ Capturing user interactions
- ✓ Managing local UI state
- ✓ Input validation and feedback
- ✓ Offline support and sync
- ✓ Smooth animations and transitions
- ✓ Navigation and routing
- ✓ Accessibility compliance

The frontend is **NOT** responsible for:
- ✗ Business rule enforcement (backend's responsibility)
- ✗ Complex calculations (backend's responsibility)
- ✗ Data transformation for business logic (backend's responsibility)

---

## Technology Decisions

| Concern | Choice | Rationale |
|---------|--------|-----------|
| Framework | Flutter (stable channel) | Cross-platform, single codebase, strong UI toolkit |
| Language | Dart | Flutter's native language; strong typing, async support |
| Routing | **go_router** | Declarative routing, deep-link support, well-maintained; consistent with ARCHITECTURE.md |
| CI | GitHub Actions | Integrated with the GitHub repository |

**go_router** is the project-wide routing package. Do not introduce Navigator 1.0 push/pop patterns
for feature navigation — all routes are declared in the central router configuration under `lib/app/`.

---

## Architecture & Organization

### Project Structure

Organize by **feature first**, then by **technical concern**:

```
features/
  authentication/
    screens/
    components/
    services/
    state/
    tests/
    
  home/
  workouts/
  routines/
  programs/
  exercises/
  skills/
  progress/
  timeline/
  community/
  profile/

shared/
  components/
  services/
  utilities/

core/
  theme/
  constants/
  styles/

design-system/
  buttons/
  cards/
  inputs/
  lists/
  dialogs/
  typography/
```

Each feature owns:
- Screens and pages
- Feature-specific components
- Local state management
- Feature services
- Feature tests

### Component Hierarchy

Build UIs using reusable, hierarchical layers:

```
Screen
  ↓
Feature Section
  ↓
Reusable Component
  ↓
Design System Primitive
```

Example:
```
Workout Screen
  ↓
Exercise List Section
  ↓
Exercise Card
  ↓
Button + Text (Design System)
```

Avoid monolithic screens. Decompose into focused components.

---

## State Management

Different types of state belong in different places:

### 1. Local UI State

**What:** Dialog open/closed, selected tab, input field value, form state

**Where:** Inside the specific screen/component

**Lifespan:** Duration of screen visibility

**Example:**
```dart
bool _isDialogOpen = false;
String _selectedTab = "overview";
```

### 2. Shared Application State

**What:** Logged-in user, theme preference, authentication tokens, app-wide settings

**Where:** Global state container (Provider, BLoC, Riverpod, etc.)

**Lifespan:** Application session

**Example:**
```dart
class AppState {
  User currentUser;
  Theme theme;
  String authToken;
}
```

### 3. Server State (Remote Data)

**What:** Workout history, programs, statistics, community feed, user data

**Where:** Backend as source of truth, cached locally for offline support

**Lifespan:** Until invalidated or refreshed

**Strategy:**
- Keep backend as source of truth
- Cache locally for offline access
- Sync changes automatically when online
- Show optimistic updates while syncing

**Example:**
```dart
// Cache locally
List<Workout> _cachedWorkouts;

// Sync with backend
Future<void> syncWorkouts() async {
  final remoteWorkouts = await api.fetchWorkouts();
  _cachedWorkouts = remoteWorkouts;
  await _saveToLocalDatabase();
}
```

---

## Navigation

Navigation should reflect user mental models and goals.

### Primary Navigation (Bottom Tabs)

- **Home** — Dashboard and quick access
- **Workouts** — Log and view workouts
- **Community** — Social features and feed
- **Progress** — Statistics and achievements
- **Profile** — User settings and preferences

### Navigation Guidelines

- Limit navigation depth to 2-3 taps for major features
- Use clear back navigation
- Preserve scroll position when returning
- Show badges for unread/urgent items
- Avoid ambiguous navigation states

---

## Offline Support

The application should remain functional during temporary network loss.

### What Works Offline

- ✓ View saved routines and programs
- ✓ Log workouts
- ✓ View recent progress and statistics
- ✓ Read cached community content
- ✓ Compose posts (synced when online)
- ✓ Access settings

### Offline Behavior

- Show offline indicator when disconnected
- Queue changes locally
- Auto-sync when connectivity returns
- Resolve conflicts transparently
- Preserve user effort across network failures

---

## Performance

Performance is a feature, not an afterthought.

### Targets

- **App startup:** < 2 seconds
- **Screen transitions:** Instant
- **List scrolling:** 60 FPS
- **Loading indicators:** Visible within 100ms of action

### Strategies

- Lazy load screens and content
- Use skeleton screens for placeholders
- Implement efficient rendering (avoid unnecessary rebuilds)
- Optimize images and media
- Minimize bundle size
- Cache aggressively

Users should rarely feel the app waiting.

---

## Error Handling

Errors should be friendly, actionable, and non-technical.

### Bad Error Messages
```
❌ "Error 500: Internal Server Error"
❌ "NetworkException: timeout_exception"
❌ "NullPointerException"
```

### Good Error Messages
```
✓ "We couldn't save your workout. 
   Your progress is safe and we'll retry automatically."

✓ "No internet connection. 
   You can still log workouts offline."

✓ "That program is no longer available. 
   Check out our recommended alternatives."
```

The goal is to maintain user trust and guide recovery.

---

## Loading & Empty States

### Loading States

Never leave users wondering. Use:

- **Skeleton screens** — Show content layout while loading
- **Progress indicators** — Animated loaders for indeterminate progress
- **Optimistic updates** — Update UI immediately, sync in background
- **Incremental loading** — Show data as it arrives

Avoid blank screens whenever possible.

### Empty States

Empty screens educate and encourage. They're opportunities to guide users.

**Bad:**
```
No workouts yet.
```

**Good:**
```
🏋️ Your journey starts here

Create your first workout and begin tracking 
your progress toward your fitness goals.

[Create Workout] button
```

---

## Forms & Input

Forms should minimize user effort:

- Few required fields
- Smart defaults (remember previous selections)
- Auto-save where appropriate
- Real-time validation with helpful errors
- Keyboard optimization (numeric keyboards for numbers, etc.)
- Auto-fill support

Logging a workout should feel effortless.

---

## Visual Design

### Design System

Centralize all visual primitives:

- Colors and palette
- Typography (font sizes, weights, line heights)
- Icons (consistent style and sizing)
- Spacing and layout grid
- Shadows and elevation
- Border radius and shape
- Animations and transitions

No feature should invent its own visual language.

### Visual Consistency

Maintains:
- Color usage (primary, secondary, success, warning, error)
- Icon library and sizing
- Button styles and states
- Card and container styling
- Typography hierarchy
- Spacing consistency

Consistency builds familiarity and trust.

---

## Accessibility

The application must be usable by everyone.

### Support Required

- ✓ Screen reader compatibility
- ✓ Sufficient color contrast
- ✓ Adjustable text sizes
- ✓ Large touch targets (min 48x48 dp)
- ✓ Meaningful focus indicators
- ✓ Keyboard navigation
- ✓ Captions for videos (future)

Accessibility should be considered from day one, not added later.

---

## Animations & Transitions

Animations communicate and delight, not distract.

### Use Animations For

- ✓ Showing transitions between screens
- ✓ Confirming successful actions
- ✓ Highlighting achievements ("Skill Unlocked!")
- ✓ Reinforcing interactions (button press, pull-to-refresh)
- ✓ Guiding attention to important changes

### Avoid

- ✗ Excessive motion that slows interaction
- ✗ Animations that don't serve a purpose
- ✗ Long delays for animations
- ✗ Animations that conflict with user actions

Animation should enhance, never obstruct.

---

## User Feedback

Every meaningful action should provide clear feedback:

- ✓ Workout saved
- ✓ Skill unlocked
- ✓ Streak continued
- ✓ Challenge joined
- ✓ Post published

The user should never wonder whether an action succeeded.

---

## Code Quality & Standards

Frontend code should be:

- **Modular** — Features are self-contained
- **Reusable** — Components solve general problems
- **Testable** — Easy to verify behavior
- **Predictable** — Follows established patterns
- **Well-typed** — Static types catch errors early
- **Documented** — Non-obvious intent is explained
- **Refactorable** — Clean architecture enables changes

Favor clear, simple architecture over clever shortcuts.

---

## Future Scalability

Design the foundation to accommodate:

- AI Coach (personalized guidance)
- Recovery Dashboard (sleep, fatigue, readiness)
- Nutrition Tracking (complementary feature)
- Wearable Integration (Apple Watch, Fitbit, etc.)
- Live Coaching (real-time video sessions)
- Competitions & Leaderboards (social motivation)
- Local Communities (geographic connections)

These should integrate naturally without requiring app redesign.

---

## Design Principles

Before shipping any screen, answer these questions:

- ✓ Is the primary action obvious?
- ✓ Can a new user understand it quickly?
- ✓ Does it reduce cognitive load?
- ✓ Does it support the user's fitness journey?
- ✓ Is it visually consistent with the design system?
- ✓ Is it accessible?
- ✓ Does it feel fast and responsive?

If not, refine before implementation.

---

## The Guiding North Star

> **The interface should disappear, leaving only the user's journey.**

Users open this app not because they love apps, but because they want to become stronger, healthier, and more consistent. Every design decision should serve that goal.

A beginner should feel welcomed. An advanced athlete should feel empowered. Neither should feel overwhelmed.

As your vision evolves toward an AI fitness companion, the frontend must remain calm and focused. Even if the platform gains hundreds of features over the years, the experience should continue to feel simple. That will become one of your greatest competitive advantages.

---

## My recommendation before moving on

At this point, your `03-engineering` folder has grown significantly. The remaining documents (`api-guidelines.md`, `database.md`, `coding-standards.md`, `testing.md`, `observability.md`, and `security.md`) become much more implementation-oriented.

These are the documents that Claude Code will rely on daily while generating production code. They should be written at the level of an experienced software architect, with concrete conventions, examples, and enforceable standards rather than high-level philosophy.

So from the next document onward, I'll increase the technical depth substantially, moving from architectural guidance into engineering specifications. That will make this repository a true engineering handbook rather than just product documentation.
