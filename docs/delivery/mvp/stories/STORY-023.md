# STORY-023 · Create Routine Schema and Migration

Epic: [epic-06-routines](../epics/epic-06-routines.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the schema for routines, routine items, and program membership.

## Implementation Steps

- [ ] Add routine and routine-item tables with an explicit ordering field.
- [ ] Add a migration for the new schema and verify it runs cleanly.
- [ ] Add indexes and constraints for routine ownership, item ordering, and deletion safety.

## Technical Notes

- The routine schema should support the future addition of duplicates, archives, and program membership without major migration churn.
- Keep the relationship between routines, routine items, and users explicit.

## Tests

- [ ] Add schema validation or migration smoke tests.
- [ ] Verify a routine with multiple items can be saved and fetched correctly.

## Documentation

- [ ] Document the routine data model and the meaning of each ordering field.

## Acceptance Criteria

- [ ] The migration runs successfully.
- [ ] Routines can be saved with their items.
- [ ] The schema supports future ordering and duplication without rework.

## Deliverables

- Routine schema migration
- Database model notes
- Initial routine structure
