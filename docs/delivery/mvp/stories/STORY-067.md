# STORY-067 · Run Final QA on Critical Flows

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Run a manual QA pass on the critical user flows against the production-equivalent build.

## Implementation Steps

- [ ] Define the QA test matrix: sign-up, onboarding, first workout, routine creation, progress view, settings, search.
- [ ] Execute each test scenario manually on the staging build and record the result.
- [ ] Log any blocking issues and verify they are resolved before the release is cut.

## Technical Notes

- Use a fresh test account to catch first-run experience issues that existing accounts would miss.
- Test on at least two device sizes or screen resolutions to catch layout regressions.

## Tests

- [ ] Complete QA test matrix with pass/fail results recorded.
- [ ] All blocking issues resolved before the release build is cut.

## Documentation

- [ ] Store the QA test matrix and results in the repository.

## Acceptance Criteria

- [ ] All critical flows pass the QA matrix.
- [ ] No blocking issues are open at the end of this story.
- [ ] QA results are documented.

## Deliverables

- QA test matrix
- Pass/fail results
- Issue resolution record
