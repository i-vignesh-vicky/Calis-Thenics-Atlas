# Week 07 - Workout Execution

## Goal
Deliver the core training experience by allowing users to start, complete, and revisit workout sessions.

## Weekly Snapshot
- Outcome: A usable workout execution flow from start to finish
- Focus: Workout session schema, API, UI, and persistence
- Status: Todo

## Implementation Backlog

# TASK-027 · Create Workout Session Schema
Epic: Workouts
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the database objects for workout sessions and logged sets.

## Implementation Steps
- [ ] Add the workout session and workout log tables with references to users and routines.
- [ ] Create the migration and rollback scripts and verify the schema in a local database.
- [ ] Add fields for status, started at, completed at, duration, and notes.

## Technical Notes
- The workout model should support the state transitions of active, paused, and completed sessions.
- Keep the schema flexible enough to record per-exercise set data without overcomplicating the first version.

## Tests
- [ ] Add a migration or schema verification test.
- [ ] Verify session rows can be created and retrieved from the test database.

## Documentation
- [ ] Document the workout session model and the meaning of each state field.

## Acceptance Criteria
- [ ] The migration runs successfully.
- [ ] Session rows can be created and retrieved.
- [ ] The schema supports future summary and history work without schema churn.

## Deliverables
- Workout schema migration
- Session and log models
- Migration notes

---

# TASK-028 · Add Workout Session API
Epic: Workouts
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
- The API should protect the session ownership rules so one user cannot edit another user’s workout.
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

---

# TASK-029 · Build Workout Execution Screen
Epic: Workouts
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

---

# TASK-030 · Add Set Logging and Auto-Save
Epic: Workouts
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

---

# TASK-031 · Add Workout Lifecycle Tests
Epic: Workouts
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add regression coverage for workout session lifecycle behavior.

## Implementation Steps
- [ ] Add tests for session creation and completion.
- [ ] Add a test for pause and resume behavior.
- [ ] Add a test for saving logged sets and ensuring the final state is preserved.

## Technical Notes
- The test suite should focus on the critical transitions rather than every possible workout edge case.
- Keep the tests easy to run in CI to prevent regressions in the main workout path.

## Tests
- [ ] Ensure the core workout lifecycle tests pass locally.
- [ ] Verify the tests are wired into CI.

## Documentation
- [ ] Document the test commands for workout lifecycle coverage.

## Acceptance Criteria
- [ ] Core workout lifecycle tests pass.
- [ ] Regression coverage exists for the main flow.
- [ ] The tests run through CI.

## Deliverables
- Workout tests
- Regression coverage
- CI test notes
