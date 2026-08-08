# STORY-041 · Add Notification Preference API

Epic: [epic-09-notifications](../epics/epic-09-notifications.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Expose endpoints to read and update reminder preferences.

## Implementation Steps

- [ ] Implement read and update handlers for preferences and ensure the authenticated user owns the record.
- [ ] Validate incoming values for reminder windows and toggles before saving.
- [ ] Return the saved preference state in the response so the UI can refresh immediately.

## Technical Notes

- The API should be simple enough for the frontend to consume without a heavy state wrapper.
- Keep validation rules clear and predictable so invalid values are easy to understand.

## Tests

- [ ] Add API tests for read and update flows.
- [ ] Verify invalid values are rejected with clear errors.

## Documentation

- [ ] Document the preference API request and response contract.

## Acceptance Criteria

- [ ] Users can read and update their reminder settings.
- [ ] Validation rejects bad values clearly.
- [ ] The response shape is stable for the UI.

## Deliverables

- Preference API endpoints
- Validation rules
- Response model
