# STORY-042 · Build Reminder Settings UI

Epic: [epic-09-notifications](../epics/epic-09-notifications.md)
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
