# STORY-049 · Add Settings API Endpoints

Epic: [epic-11-settings](../epics/epic-11-settings.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Expose endpoints to read and update user app settings.

## Implementation Steps

- [ ] Implement a read handler that returns the current settings for the authenticated user.
- [ ] Implement an update handler that validates and persists the incoming settings object.
- [ ] Return the full saved settings in the response so the UI can refresh immediately.

## Technical Notes

- Scope to the authenticated user only; never expose another user's settings.
- Validate the incoming values to reject unsupported theme names, invalid unit values, or malformed data.

## Tests

- [ ] Add API tests for read and update flows.
- [ ] Verify invalid values are rejected with clear error messages.

## Documentation

- [ ] Document the settings API request and response contract.

## Acceptance Criteria

- [ ] Users can read their current settings via the API.
- [ ] Valid updates are persisted and returned.
- [ ] Invalid values are rejected with clear errors.

## Deliverables

- Settings read endpoint
- Settings update endpoint
- Validation rules
