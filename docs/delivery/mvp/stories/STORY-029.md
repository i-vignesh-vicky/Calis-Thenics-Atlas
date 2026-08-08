# STORY-029 · Build Workout Execution Screen

Epic: [epic-07-workout-execution](../epics/epic-07-workout-execution.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Create the workout screen with timer controls and the current routine context.

## Implementation Steps

- [ ] Build the workout execution view with timer controls, pause/resume actions, and a clear current exercise context.
- [ ] Add a simple list of exercises for the current session and show the active exercise clearly.
- [ ] Connect the screen to the workout session API and update the UI as the workout state changes.

## Technical Notes

- The first version should focus on the workout lifecycle rather than a fully polished fitness tracker UI.
- Make the flow usable even if the timer or session state is temporarily unavailable.

## Tests

- [ ] Add a UI test for starting a workout and switching to the active exercise.
- [ ] Verify pause and resume actions update the UI state correctly.

## Documentation

- [ ] Document the workout screen flow and the expected session state changes.

## Acceptance Criteria

- [ ] A user can start a workout from the UI.
- [ ] The workout screen shows the routine context.
- [ ] The screen updates as the workout state changes.

## Deliverables

- Workout execution screen
- Timer UI
- Session integration
