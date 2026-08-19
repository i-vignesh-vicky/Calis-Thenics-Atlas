# STORY-004 · Configure Frontend App Shell

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 4 hrs
Priority: High
Status: Done

## Objective

Create the Flutter frontend application with a feature-first folder structure, a root app provider,
bottom-navigation shell, initial route setup, and a placeholder landing screen — ready for the
design system (Week 02) and feature screens to plug into.

## Implementation Steps

- [x] Initialize the Flutter project under `frontend/` (or `app/`) with the correct package name.
- [x] Establish the feature-first folder structure under `lib/`:
  ```
  lib/
    app/            — root widget, MaterialApp/router configuration
    core/
      theme/        — placeholder ThemeData (Week 02 will replace this)
      constants/    — app-level constants
      styles/       — shared style tokens placeholder
    features/       — empty; feature folders added per epic
    shared/
      components/   — reusable widgets
      services/     — shared service abstractions
      utilities/    — helpers, extensions
    design-system/  — placeholder; Week 02 populates this
  ```
- [x] Add a root `App` widget that wraps `MaterialApp.router` (or `MaterialApp` with named routes).
- [x] Configure an initial route map with placeholder routes for the five main navigation destinations:
  Home, Workouts, Progress, Profile, and Settings.
- [x] Add a `MainShell` widget with a bottom navigation bar that switches between the five destinations.
- [x] Add a placeholder `LandingScreen` (simple centered text or loading indicator — no real content yet).
- [x] Configure the theme to accept a `ThemeData` parameter so Week 02 can swap in the design system
  without structural changes.

## Technical Notes

- Use `go_router` for routing (project-wide decision — see ARCHITECTURE.md). All routes are declared
  centrally in `lib/app/router.dart`. Do not mix Navigator 1.0 push/pop for feature screens.
- The bottom nav destinations are placeholders. They show an empty scaffold with a title. Real
  content arrives in later epics.
- Do not implement any feature logic, API calls, or state management in this story.
- Offline support is a product requirement for core features. The shell should not assume connectivity,
  but no offline logic is needed yet.
- Keep `pubspec.yaml` dependencies minimal: only what the shell literally needs.

## Tests

- [x] Add a widget smoke test that pumps the root `App` widget and confirms it renders without
  runtime errors.
- [x] Confirm the main route navigates to the landing screen without throwing.

## Documentation

- [x] Document the Flutter start command (`flutter run`) and supported platforms (iOS, Android) in the README.
- [x] Document the folder structure and the routing approach chosen.

## Acceptance Criteria

- [x] `flutter run` starts the app without errors on at least one target (Android emulator, iOS simulator, or Chrome).
- [x] The main route renders the landing screen.
- [x] The bottom navigation bar renders with five destinations.
- [x] The feature-first folder structure is in place and documented.
- [x] The root widget test passes.

## Deliverables

- Flutter project under `frontend/`
- Feature-first `lib/` structure
- Root `App` widget with router configuration
- `MainShell` with bottom navigation bar
- Placeholder `LandingScreen`
- Root widget smoke test
- README section documenting start commands and structure
