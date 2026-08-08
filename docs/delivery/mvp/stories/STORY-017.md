# STORY-017 · Build Onboarding Form UI

Epic: [epic-04-user-profile](../epics/epic-04-user-profile.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Create the onboarding form and connect it to the profile API.

## Implementation Steps

- [ ] Build the onboarding screens for goals, experience level, and equipment with a clear step flow.
- [ ] Add local form state and submission handling, including loading and error feedback.
- [ ] Connect the form submission to the profile API and redirect or complete the flow on success.

## Technical Notes

- The UI should treat onboarding as a first-run experience, not a generic settings screen.
- Keep the submission path simple so the user can complete the flow without confusion.

## Tests

- [ ] Add a UI test for the happy path and a test for validation failure.
- [ ] Verify network or API errors surface in the form state.

## Documentation

- [ ] Document the onboarding flow and the expected API interaction.

## Acceptance Criteria

- [ ] The onboarding flow can be completed end to end.
- [ ] The form saves profile data correctly.
- [ ] User feedback is shown for errors and loading states.

## Deliverables

- Onboarding UI
- Form submission flow
- Frontend profile integration
