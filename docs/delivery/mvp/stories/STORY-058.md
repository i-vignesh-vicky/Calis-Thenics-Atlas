# STORY-058 · Add Beta Smoke Test Script

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create a smoke test script that verifies the beta build is functional before giving it to testers.

## Implementation Steps

- [ ] Write a smoke test script that covers the critical journeys: sign-in, start workout, save workout, view history.
- [ ] Configure the script to run against the staging environment after each deployment.
- [ ] Fail the deployment pipeline if any smoke test fails.

## Technical Notes

- Smoke tests should be fast (under 5 minutes) and catch build-breaking regressions rather than exhaustive coverage.
- Use the same test account credentials in staging for consistent results.

## Tests

- [ ] Smoke test coverage for at least four critical journeys.
- [ ] Script exits with a non-zero code on any failure.

## Documentation

- [ ] Document the smoke test script, how to run it manually, and how it integrates with CI.

## Acceptance Criteria

- [ ] The smoke test runs against staging after each deployment.
- [ ] A failure blocks the release workflow.
- [ ] The script is documented.

## Deliverables

- Smoke test script
- CI integration
- Documentation
