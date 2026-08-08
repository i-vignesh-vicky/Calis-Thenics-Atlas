# STORY-054 · Add Regression Tests for Critical Journeys

Epic: [epic-12-quality](../epics/epic-12-quality.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Add end-to-end regression tests covering the most critical user journeys in the MVP.

## Implementation Steps

- [ ] Identify the five to seven critical journeys: sign-up, first workout, routine creation, progress view, settings change.
- [ ] Write an automated regression test for each critical journey.
- [ ] Ensure the tests run in CI so regressions are caught before merge.

## Technical Notes

- Focus on journeys that span multiple features so a cross-cutting regression is caught early.
- Keep individual tests focused on the happy path; edge cases belong in unit or integration tests.

## Tests

- [ ] Regression tests for each identified critical journey.
- [ ] CI configuration that runs the regression suite.

## Documentation

- [ ] Document the covered journeys and how to run the suite locally.

## Acceptance Criteria

- [ ] Regression tests exist for the five to seven critical journeys.
- [ ] Tests pass in the CI environment.
- [ ] The suite is documented and runnable locally.

## Deliverables

- Regression test suite
- CI integration
- Journey coverage documentation
