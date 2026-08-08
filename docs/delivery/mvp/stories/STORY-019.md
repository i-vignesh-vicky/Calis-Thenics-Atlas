# STORY-019 · Create Exercise Schema and Seed Data

Epic: [epic-05-exercise-library](../epics/epic-05-exercise-library.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the exercise data model and seed the first content set.

## Implementation Steps

- [ ] Add the exercise table and metadata columns for name, category, difficulty, description, and instructions.
- [ ] Create a seed file with a small initial dataset and a setup script for local environments.
- [ ] Add a migration or seed runner that can be executed reliably on a fresh database.

## Technical Notes

- Keep the seed data small but realistic enough to demonstrate filters and detail rendering.
- Make the schema flexible enough to support future exercise metadata without redesign.

## Tests

- [ ] Verify the seed script inserts exercise rows successfully.
- [ ] Confirm the schema supports the fields required by the browsing and detail screens.

## Documentation

- [ ] Document the seed data source and the expected exercise metadata fields.

## Acceptance Criteria

- [ ] Exercise rows can be created and fetched.
- [ ] Seed data is available in the local environment.
- [ ] The schema supports categories and metadata fields required by the UI.

## Deliverables

- Exercise schema migration
- Seed data file
- Seed setup script
