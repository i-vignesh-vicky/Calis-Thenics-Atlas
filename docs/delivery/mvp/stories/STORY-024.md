# STORY-024 · Add Routine CRUD API

Epic: [epic-06-routines](../epics/epic-06-routines.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Expose create, update, and fetch endpoints for routines.

## Implementation Steps

- [ ] Implement create, update, and fetch handlers for routines and routine items.
- [ ] Validate routine payloads before saving and prevent invalid item references.
- [ ] Return the created or updated routine from the API with a stable response contract.

## Technical Notes

- The API should enforce that each routine item references a valid exercise and belongs to the correct owner.
- Use a consistent response shape so the editor UI can rely on it.

## Tests

- [ ] Add API tests for create, update, and invalid payload cases.
- [ ] Verify ownership rules prevent cross-user edits.

## Documentation

- [ ] Document the routine API endpoints, payload fields, and expected response shape.

## Acceptance Criteria

- [ ] Routines can be created and fetched.
- [ ] Updates persist changes correctly.
- [ ] Invalid payloads are rejected with clear errors.

## Deliverables

- Routine API endpoints
- Validation rules
- Response contracts
