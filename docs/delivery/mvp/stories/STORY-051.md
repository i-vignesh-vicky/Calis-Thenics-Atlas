# STORY-051 · Add Settings Tests

Epic: [epic-11-settings](../epics/epic-11-settings.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Add regression tests covering the settings schema, API, and UI preference flow.

## Implementation Steps

- [ ] Add unit tests for the settings model defaults and validation rules.
- [ ] Add API integration tests for read and update flows.
- [ ] Add UI regression tests that verify the end-to-end preference change flow.

## Technical Notes

- Verify the defaults are applied consistently for new users.
- Cover the validation rejection cases so invalid inputs are caught reliably.

## Tests

- [ ] Schema and model tests.
- [ ] API integration tests.
- [ ] UI regression tests for the settings flow.

## Documentation

- [ ] Document the test coverage scope and any known gaps.

## Acceptance Criteria

- [ ] Schema tests pass for defaults and persistence.
- [ ] API tests cover valid and invalid update paths.
- [ ] UI tests verify the preference change flow.

## Deliverables

- Settings model tests
- API integration tests
- UI regression tests
