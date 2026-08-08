# STORY-047 · Add Search Regression Tests

Epic: [epic-10-search](../epics/epic-10-search.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Add regression tests covering the search query service, API, and UI interaction path.

## Implementation Steps

- [ ] Add tests for the query service with known inputs and expected outputs.
- [ ] Add API-level tests for the search endpoint including edge cases such as empty strings and special characters.
- [ ] Add UI regression tests that verify the search flow from input to result display.

## Technical Notes

- Cover the rank order invariants so a future change to ranking does not silently regress.
- Include a test for the no-results case to ensure the UI handles it correctly.

## Tests

- [ ] Query service unit tests.
- [ ] API integration tests.
- [ ] UI regression tests for search flow.

## Documentation

- [ ] Document the test scope and any known gaps in coverage.

## Acceptance Criteria

- [ ] Query service tests pass for known inputs.
- [ ] API tests cover empty, partial, and exact queries.
- [ ] UI regression tests verify the end-to-end search path.

## Deliverables

- Query service tests
- API tests
- UI search regression tests
