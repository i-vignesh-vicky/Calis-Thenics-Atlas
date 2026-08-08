# STORY-065 · Add Deployment Safety Checklist

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Document and test the checklist required before every production deployment.

## Implementation Steps

- [ ] List every step required for a safe production deployment: config validation, database migration, smoke test, monitoring check.
- [ ] Format the checklist so it can be followed step-by-step with checkboxes.
- [ ] Dry-run the checklist against the staging environment to verify it is complete and accurate.

## Technical Notes

- The checklist should be self-contained and runnable by someone unfamiliar with the system.
- Include rollback steps in the checklist so they are not forgotten under pressure.

## Tests

- [ ] Complete a full checklist dry-run against staging and note any gaps.

## Documentation

- [ ] Deployment safety checklist stored in the repository.

## Acceptance Criteria

- [ ] The checklist covers all required deployment steps.
- [ ] The checklist includes rollback steps.
- [ ] A dry-run has been completed against staging.

## Deliverables

- Deployment safety checklist
- Dry-run record
