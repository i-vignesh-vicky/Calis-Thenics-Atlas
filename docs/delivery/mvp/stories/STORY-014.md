# STORY-014 · Add Auth Regression Tests

Epic: [epic-03-authentication](../epics/epic-03-authentication.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Add unit or integration coverage for the main auth flow.

## Implementation Steps

- [ ] Add tests for signup validation and success path.
- [ ] Add tests for login failure and success cases.
- [ ] Add one end-to-end test for the login screen flow and the route change after authentication.

## Technical Notes

- Keep the regression suite scoped to the core auth flow rather than broad end-to-end coverage.
- Use the tests to protect the main happy path and the most likely failure cases.

## Tests

- [ ] Ensure the auth tests pass in the local test suite.
- [ ] Confirm the tests are runnable in CI.

## Documentation

- [ ] Document the test commands required to run the auth suite locally.

## Acceptance Criteria

- [ ] Auth tests pass in the local test suite.
- [ ] Regression coverage exists for the core flow.
- [ ] The test commands are documented.

## Deliverables

- Auth tests
- Test docs
- Regression coverage
