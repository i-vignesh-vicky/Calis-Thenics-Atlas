# Week 10 - Notifications and Reminders

## Goal
Add lightweight accountability through reminders and basic notification plumbing.

## Weekly Snapshot
- Outcome: A basic notification and reminder experience
- Focus: Preferences, reminder UI, and notification delivery
- Status: Todo

## Implementation Backlog

# TASK-040 · Create Notification Preference Schema
Epic: Notifications
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the database schema for user notification preferences.

## Implementation Steps
- [ ] Add a notification preferences table or configuration entry with reminder window and delivery flags.
- [ ] Create the migration and rollback files and define the default values.
- [ ] Add defaults for reminder timing, preferred channels, and opt-in toggles.

## Technical Notes
- Keep the settings model narrow enough to support the MVP without a full notification framework.
- Make the preferences explicit so the reminder flow can read them reliably.

## Tests
- [ ] Add a schema or storage test for the default preference values.
- [ ] Verify preferences can be saved and fetched for a user.

## Documentation
- [ ] Document the preference schema and the default reminder settings.

## Acceptance Criteria
- [ ] Preferences can be stored and fetched.
- [ ] Defaults are applied when the user has no saved settings.
- [ ] The schema supports reminder preferences.

## Deliverables
- Preferences schema
- Migration files
- Default settings constants

---

# TASK-041 · Add Notification Preference API
Epic: Notifications
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

---

# TASK-042 · Build Reminder Settings UI
Epic: Notifications
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Create the settings screen that controls reminders and notification choices.

## Implementation Steps
- [ ] Build the reminder settings form in the settings UI with toggle and schedule controls.
- [ ] Add loading, save, and error feedback to the form.
- [ ] Connect the form to the preference API and show the current saved state.

## Technical Notes
- Keep the settings UI small and focused on the MVP reminder experience.
- Make the save flow obvious so users know when their preferences have been applied.

## Tests
- [ ] Add a UI test for saving reminder settings.
- [ ] Verify the form reflects the persisted state after save.

## Documentation
- [ ] Document how reminder choices are surfaced in the settings experience.

## Acceptance Criteria
- [ ] Reminder settings can be changed from the UI.
- [ ] The UI reflects the stored preference state.
- [ ] Errors and save states are handled gracefully.

## Deliverables
- Reminder settings UI
- Preference integration
- Save feedback handling

---

# TASK-043 · Add Notification Delivery Stub
Epic: Notifications
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add a minimal delivery pipeline for reminder events.

## Implementation Steps
- [ ] Create a small notification job or background hook that can process reminder events.
- [ ] Deliver a test message for a reminder event and write the result to a visible log or stub output.
- [ ] Log the delivery outcome and make the hook ready for future provider integration.

## Technical Notes
- The first implementation should be a stub rather than a full provider integration.
- Keep the hook isolated so it can later be swapped for a real mail or push provider.

## Tests
- [ ] Add a test for the reminder event processing path.
- [ ] Verify the stub logs or writes the expected output.

## Documentation
- [ ] Document the reminder delivery stub and how it will be extended later.

## Acceptance Criteria
- [ ] A reminder event can be processed in a test environment.
- [ ] The delivery result is visible in logs or a stub output.
- [ ] The flow is ready for provider integration later.

## Deliverables
- Notification delivery stub
- Logging for deliveries
- Future integration hook
