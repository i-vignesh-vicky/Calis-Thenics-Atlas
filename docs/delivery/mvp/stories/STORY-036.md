# STORY-036 · Implement Streak and Milestone Calculations

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the domain logic for streaks, active days, and milestones.

## Implementation Steps

- [ ] Add deterministic functions for streak calculation from workout history.
- [ ] Add milestone thresholds and personal record detection logic using the saved workout metrics.
- [ ] Ensure the logic is testable and independent of the UI layer.

## Technical Notes

- The calculations should work off a clean domain model rather than ad hoc UI state.
- Keep the thresholds explicit so they can be adjusted later without rewriting the full calculation path.

## Tests

- [ ] Add unit tests for streak calculation over sample workout histories.
- [ ] Verify milestone thresholds and personal record detection return the expected values.

## Documentation

- [ ] Document the progress rules and the meaning of each metric.

## Acceptance Criteria

- [ ] Streak values are computed correctly for sample data.
- [ ] Milestone thresholds produce expected results.
- [ ] Personal record detection works for tracked metrics.

## Deliverables

- Progress calculation logic
- Milestone rules
- Testable domain functions
