# Week 04 - Profile and Onboarding

## Goal
Capture the user’s training profile so the app can tailor recommendations and future routines.

## Weekly Snapshot
- Outcome: A usable onboarding experience with stored profile information
- Focus: Profile schema, API, UI, and tests
- Status: Todo

## Implementation Backlog

# TASK-015 · Create Profile Schema and Migration
Epic: User Profile
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the database schema for profile and onboarding data.

## Implementation Steps
- [ ] Add profile-related tables and columns for goals, experience level, equipment, and onboarding completion.
- [ ] Create the migration and rollback scripts and verify they run cleanly.
- [ ] Add constraints or defaults for required profile fields to prevent partial or invalid data.

## Technical Notes
- The initial profile model should be broad enough to support onboarding but still simple enough for the MVP.
- Keep a clear distinction between user identity data and preference/profile data.

## Tests
- [ ] Add a migration or schema verification test.
- [ ] Verify profile inserts and reads work with the local database.

## Documentation
- [ ] Document the profile schema and how onboarding data is expected to flow into the app.

## Acceptance Criteria
- [ ] The migration runs successfully.
- [ ] Profile rows can be persisted and fetched.
- [ ] The schema supports onboarding fields and future personalization.

## Deliverables
- Profile schema migration
- Database model notes
- Initial profile structure

---

# TASK-016 · Add Profile CRUD API
Epic: User Profile
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
- Prevent one user from updating another user’s profile by enforcing ownership checks in the API.
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

---

# TASK-017 · Build Onboarding Form UI
Epic: User Profile
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Create the onboarding form and connect it to the profile API.

## Implementation Steps
- [ ] Build the onboarding screens for goals, experience level, and equipment with a clear step flow.
- [ ] Add local form state and submission handling, including loading and error feedback.
- [ ] Connect the form submission to the profile API and redirect or complete the flow on success.

## Technical Notes
- The UI should treat onboarding as a first-run experience, not a generic settings screen.
- Keep the submission path simple so the user can complete the flow without confusion.

## Tests
- [ ] Add a UI test for the happy path and a test for validation failure.
- [ ] Verify network or API errors surface in the form state.

## Documentation
- [ ] Document the onboarding flow and the expected API interaction.

## Acceptance Criteria
- [ ] The onboarding flow can be completed end to end.
- [ ] The form saves profile data correctly.
- [ ] User feedback is shown for errors and loading states.

## Deliverables
- Onboarding UI
- Form submission flow
- Frontend profile integration

---

# TASK-018 · Add Profile Testing Coverage
Epic: User Profile
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
