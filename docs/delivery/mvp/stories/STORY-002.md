# STORY-002 · Add Shared Environment Configuration

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add a shared environment configuration pattern for local development.

## Implementation Steps

- [ ] Create a sample environment file with required keys, comments, and placeholders for secrets.
- [ ] Document which values are required locally versus optional for development.
- [ ] Add a lightweight config loader or validation helper that fails fast on missing variables.

## Technical Notes

- Keep the config contract consistent across frontend and backend so environment drift is minimized.
- Prefer a single source of truth for required public and private values.

## Tests

- [ ] Validate that missing required variables are caught by the config helper.
- [ ] Confirm the sample environment file is readable and the documented keys match the actual code.

## Documentation

- [ ] Add bootstrap instructions for creating local environment files and secret overrides.

## Acceptance Criteria

- [ ] A sample env file exists for local setup.
- [ ] Required variables are documented clearly.
- [ ] The config pattern is consistent across services and fails clearly on missing values.

## Deliverables

- Sample environment file
- Setup documentation
- Config validation helper
