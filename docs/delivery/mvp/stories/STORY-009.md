# STORY-009 · Add Route Skeletons and Navigation State

Epic: [epic-02-design-system](../epics/epic-02-design-system.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Add the initial route map and navigation state for MVP screens.

## Implementation Steps

- [ ] Define route names for home, auth, profile, exercises, routines, workouts, and settings.
- [ ] Add route placeholders for each page and wire them into the shell navigation.
- [ ] Add basic navigation state such as active route tracking and a fallback route.

## Technical Notes

- The route structure should reflect the delivery order from the roadmap so the app grows in a predictable way.
- Keep the navigation state simple; the focus is on enabling feature slices, not a full router abstraction.

## Tests

- [ ] Add tests for the route map and fallback handling.
- [ ] Verify the main navigation state changes when switching routes.

## Documentation

- [ ] Document the route map and the intended page ownership in the frontend docs.

## Acceptance Criteria

- [ ] The app has route placeholders for each main area.
- [ ] Navigation can switch between the placeholder screens.
- [ ] The active route can be represented in the shell and tested reliably.

## Deliverables

- Route map
- Navigation state
- Placeholder screens
