# STORY-028 · Add Workout Session API

Epic: [epic-07-workout-execution](../epics/epic-07-workout-execution.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Expose endpoints for creating, updating, and completing workout sessions.

## Implementation Steps

- [ ] Implement create, update, and complete endpoints for workout sessions.
- [ ] Add state transitions for active, paused, and completed sessions.
- [ ] Persist logged exercise sets and timing data in the same transaction or save flow.

## Technical Notes

- The API should protect the session ownership rules so one user cannot edit another user's workout.
- Keep the state transition logic explicit and testable so regressions are easy to catch.

## Tests

- [ ] Add API tests for create, update, complete, and invalid transition paths.
- [ ] Verify paused and resumed sessions preserve the correct state.

## Documentation

- [ ] Document the workout API payloads and expected session states.

## Acceptance Criteria

- [ ] Sessions can be created and updated.
- [ ] State transitions work correctly.
- [ ] The save operation persists workout data and returns the updated session state.

## Deliverables

- Workout session endpoints
- State transition logic
- Persistence layer
