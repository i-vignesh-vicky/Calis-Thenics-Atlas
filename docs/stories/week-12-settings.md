# Week 12 - Settings and Account Experience

## Goal
Improve trust and usability by giving users control over account preferences and settings.

## Weekly Snapshot
- Outcome: A clear settings experience for account preferences
- Focus: Settings schema, API, UI, and persistence
- Status: Todo

## Implementation Backlog

# TASK-048 · Create Settings Schema
Epic: Settings
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the data model for user settings and account preferences.

## Implementation Steps
- [ ] Add settings tables or config storage for user preferences, display choices, and notification toggles.
- [ ] Create the migration and rollback scripts and define defaults for new users.
- [ ] Add any support fields needed for future preference expansion.

## Technical Notes
- Keep the settings model simple and versioned so it can evolve without data migration pain.
- Separate account-level preferences from profile-specific data when possible.

## Tests
- [ ] Add schema or data-store tests for default settings.
- [ ] Verify preferences can be read and updated for a user.

## Documentation
- [ ] Document the settings schema and the default values expected by the app.

## Acceptance Criteria
- [ ] Settings can be stored and retrieved.
- [ ] Default values are applied for new users.
- [ ] The schema supports future preference expansion.

## Deliverables
- Settings schema
- Migration files
- Default settings constants

---

# TASK-049 · Add Settings API Endpoints
Epic: Settings
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Expose endpoints to read and update settings.

## Implementation Steps
- [ ] Implement read and save handlers for settings and ensure the authenticated user owns the record.
- [ ] Validate preference payloads before saving and reject bad values clearly.
- [ ] Return the saved settings to the client after a successful update.

## Technical Notes
- The settings API should remain small and predictable so the UI can consume it directly.
- Keep the request/response payload shape explicit so the UI does not need to infer defaults.

## Tests
- [ ] Add API tests for fetch and update flows.
- [ ] Verify invalid preferences are rejected and default values are preserved correctly.

## Documentation
- [ ] Document the settings API request and response contract.

## Acceptance Criteria
- [ ] Settings can be fetched and updated.
- [ ] Validation rejects bad values clearly.
- [ ] The API returns the persisted state.

## Deliverables
- Settings API endpoints
- Validation rules
- Response model

---

# TASK-050 · Build Settings UI and Preference Controls
Epic: Settings
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Create the settings screen and connect it to the frontend state.

## Implementation Steps
- [ ] Build the settings screen layout and controls for toggles, selectors, and account-related options.
- [ ] Connect toggles and selectors to the settings API and show loading and save feedback.
- [ ] Ensure the UI reflects persisted values after refresh and after a save operation.

## Technical Notes
- The settings experience should feel lightweight and trustworthy rather than overloaded.
- Keep the screen consistent with the existing shared primitives so it feels native to the app.

## Tests
- [ ] Add a UI test for saving preference toggles.
- [ ] Verify the state persists after refresh.

## Documentation
- [ ] Document the settings screen flow and the persistence expectations.

## Acceptance Criteria
- [ ] Settings are visible and editable in the UI.
- [ ] User changes persist after refresh.
- [ ] The UI shows save/loading state clearly.

## Deliverables
- Settings screen
- Preference controls
- Frontend state integration

---

# TASK-051 · Add Settings Tests
Epic: Settings
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add regression coverage for settings persistence and UI updates.

## Implementation Steps
- [ ] Add API tests for update and fetch handlers.
- [ ] Add one UI test for saving preference toggles.
- [ ] Add a test for default settings behavior and the first-run state.

## Technical Notes
- Keep the settings tests focused on persistence and the visible UI behavior.
- Use them to protect the baseline preference experience before broader personalization work begins.

## Tests
- [ ] Ensure settings tests pass locally.
- [ ] Confirm the main settings flow is covered in CI.

## Documentation
- [ ] Add a short note documenting how to run the settings tests.

## Acceptance Criteria
- [ ] Settings tests pass locally.
- [ ] The main settings flow is covered.
- [ ] The tests run in CI.

## Deliverables
- Settings tests
- Regression coverage
- Test notes
