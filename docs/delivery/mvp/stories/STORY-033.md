# STORY-033 · Build Workout History List UI

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the history list experience for completed workouts.

## Implementation Steps

- [ ] Build the history list screen with session cards or rows that summarize the workout.
- [ ] Add loading, error, and empty states for the list.
- [ ] Connect the UI to the history API and render the returned summary fields.

## Technical Notes

- The history list should make the next action obvious, such as opening a detail screen or returning to the workout flow.
- Keep the visual treatment simple but consistent with the rest of the app shell.

## Tests

- [ ] Add a UI test for the history list and the empty state.
- [ ] Verify the list renders correctly when the API returns a populated or empty history set.

## Documentation

- [ ] Document the expected history list behavior and fallback states.

## Acceptance Criteria

- [ ] Completed workouts appear in the history list.
- [ ] Empty state is shown when no history exists.
- [ ] The list renders without crashes.

## Deliverables

- History list screen
- API integration
- Loading/empty states
