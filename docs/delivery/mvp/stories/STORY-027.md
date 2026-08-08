# STORY-027 · Create Workout Session Schema

Epic: [epic-07-workout-execution](../epics/epic-07-workout-execution.md)
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
