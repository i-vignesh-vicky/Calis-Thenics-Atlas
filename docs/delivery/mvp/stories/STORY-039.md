# STORY-039 · Add Progress Logic Tests

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Add tests for the progress calculation rules.

## Implementation Steps

- [ ] Add unit tests for streak and milestone logic.
- [ ] Add tests for empty or partial progress inputs.
- [ ] Add a simple API test for the summary endpoint.

## Technical Notes

- Prioritize deterministic progress logic tests over broad UI tests for this week.
- Keep the test data small but representative so regressions are easy to understand.

## Tests

- [ ] Ensure progress tests pass locally.
- [ ] Confirm the core logic has clear regression coverage in CI.

## Documentation

- [ ] Document the progress test commands and the test data assumptions.

## Acceptance Criteria

- [ ] Progress tests pass locally.
- [ ] Core logic has clear regression coverage.
- [ ] The test suite is runnable in CI.

## Deliverables

- Progress tests
- Regression coverage
- CI readiness note
