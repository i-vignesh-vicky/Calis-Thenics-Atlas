# STORY-015 · Create Profile Schema and Migration

Epic: [epic-04-user-profile](../epics/epic-04-user-profile.md)
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
