# STORY-030 · Add Set Logging and Auto-Save

Epic: [epic-07-workout-execution](../epics/epic-07-workout-execution.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Allow users to log sets during a workout and preserve progress automatically.

## Implementation Steps

- [ ] Add a form or stepper to log sets per exercise, with fields for reps, weight, and notes where applicable.
- [ ] Save the log entries as the user interacts with the screen using a debounce or autosave approach.
- [ ] Add a visible save state and protect the user from accidentally losing in-progress workout data.

## Technical Notes

- Auto-save should be resilient to refreshes and should not cause the UI to block on each keystroke.
- Make the saved state explicit so users know whether their latest set entry has been persisted.

## Tests

- [ ] Add tests for set logging and autosave behavior.
- [ ] Verify session progress is preserved after a refresh.

## Documentation

- [ ] Document the set logging flow and the autosave strategy.

## Acceptance Criteria

- [ ] Sets can be logged during a workout.
- [ ] Session progress is preserved after a refresh.
- [ ] The user can continue the workout without losing work.

## Deliverables

- Set logging UI
- Auto-save flow
- Session persistence
