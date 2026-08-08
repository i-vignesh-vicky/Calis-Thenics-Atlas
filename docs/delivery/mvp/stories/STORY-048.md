# STORY-048 · Create Settings Schema

Epic: [epic-11-settings](../epics/epic-11-settings.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the database schema for user app settings.

## Implementation Steps

- [ ] Design a settings table or embedded document linked to the user that holds display, theme, and unit preferences.
- [ ] Create the migration and rollback files and define sensible defaults.
- [ ] Ensure the schema can accommodate the MVP preference set without over-engineering for future settings.

## Technical Notes

- Keep the schema flexible enough to add new settings without a table restructure.
- Defaults should match the most common preference so new users see a sensible initial state.

## Tests

- [ ] Add a schema test for saving and reading settings.
- [ ] Verify defaults are applied when no settings exist for a user.

## Documentation

- [ ] Document the settings schema and the default values applied.

## Acceptance Criteria

- [ ] Settings can be stored and retrieved per user.
- [ ] Defaults are applied for new users.
- [ ] The schema migration runs without error.

## Deliverables

- Settings schema
- Migration files
- Default values constants
