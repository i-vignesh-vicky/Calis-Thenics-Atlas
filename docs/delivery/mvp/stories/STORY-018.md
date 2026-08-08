# STORY-018 · Add Profile Testing Coverage

Epic: [epic-04-user-profile](../epics/epic-04-user-profile.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Add regression coverage for profile create and update workflows.

## Implementation Steps

- [ ] Add tests for the profile API handlers and validation logic.
- [ ] Add one UI test for onboarding submission and a test for the save state.
- [ ] Add a test for validation failure handling and unauthorized updates.

## Technical Notes

- Focus the tests on the core onboarding save path and the most likely failure states.
- Keep the assertions explicit so regressions are easy to diagnose.

## Tests

- [ ] Ensure profile tests pass locally.
- [ ] Confirm the onboarding flow has basic regression coverage in CI.

## Documentation

- [ ] Add a short note documenting how to run the profile tests.

## Acceptance Criteria

- [ ] Profile tests pass locally.
- [ ] The onboarding flow has basic regression coverage.
- [ ] The tests are runnable in CI.

## Deliverables

- Profile tests
- Regression coverage
- Test notes
