# STORY-016 · Add Profile CRUD API

Epic: [epic-04-user-profile](../epics/epic-04-user-profile.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Expose profile create and update endpoints for the authenticated user.

## Implementation Steps

- [ ] Implement create and update handlers for profile data and attach the authenticated user ID.
- [ ] Add validation for required onboarding fields and a safe update strategy.
- [ ] Return the saved profile state after a successful save so the frontend can refresh local state.

## Technical Notes

- Prevent one user from updating another user's profile by enforcing ownership checks in the API.
- Keep the response contract simple and predictable for the onboarding UI.

## Tests

- [ ] Add API tests for create, update, and validation failure cases.
- [ ] Verify unauthorized updates are rejected.

## Documentation

- [ ] Document the profile API request/response contract and field rules.

## Acceptance Criteria

- [ ] Profile data can be created and updated.
- [ ] Invalid payloads are rejected with clear errors.
- [ ] The API returns the saved profile state.

## Deliverables

- Profile API endpoints
- Validation rules
- Saved profile response model
