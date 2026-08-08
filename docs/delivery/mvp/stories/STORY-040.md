# STORY-040 · Create Notification Preference Schema

Epic: [epic-09-notifications](../epics/epic-09-notifications.md)
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
