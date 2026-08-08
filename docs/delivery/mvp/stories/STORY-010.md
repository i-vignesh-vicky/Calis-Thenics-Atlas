# STORY-010 · Create Auth Database Schema

Epic: [epic-03-authentication](../epics/epic-03-authentication.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the database objects required for user accounts and auth state.

## Implementation Steps

- [ ] Add the user table with the fields required for email, password hash, created time, and last login.
- [ ] Create the migration and rollback files and verify they run cleanly in a fresh local database.
- [ ] Add an index or uniqueness constraint for email so duplicate accounts are prevented.

## Technical Notes

- Keep the initial schema focused on the minimum fields needed for signup and login.
- The password field should never be stored in plain text; only hashed values should be persisted.

## Tests

- [ ] Add a migration smoke test or schema verification step.
- [ ] Verify inserts and reads for a user record work in the local test database.

## Documentation

- [ ] Document the auth schema and the data contract the API depends on.

## Acceptance Criteria

- [ ] The migration runs successfully.
- [ ] User records can be inserted and retrieved.
- [ ] The schema supports future auth and profile work without major changes.

## Deliverables

- Auth schema migration
- Database table definition
- Migration notes
