# STORY-005B · Add Baseline Smoke Test and Startup Validation

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add a smoke test that proves the initial app can build and boot.

## Implementation Steps

- [ ] Add one smoke test for a health or startup path in the backend or frontend shell.
- [ ] Ensure the test can run locally and in CI without requiring manual setup.
- [ ] Wire the smoke test into the repository scripts and the CI workflow.

## Technical Notes

- Use the smallest test that proves the app is booting correctly rather than over-testing the shell.
- Keep the assertion focused on startup success and basic renderability.

## Tests

- [ ] Run the smoke test locally and in CI.
- [ ] Confirm the test fails loudly if the health or startup path regresses.

## Documentation

- [ ] Document the smoke test command in the repository README or contributing notes.

## Acceptance Criteria

- [ ] A smoke test passes locally and in CI.
- [ ] The workflow includes the smoke test in the default validation path.
- [ ] The test command is documented for the repo.

## Deliverables

- Smoke test
- CI test wiring
- CI documentation
