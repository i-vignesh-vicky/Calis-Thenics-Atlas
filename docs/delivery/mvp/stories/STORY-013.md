# STORY-013 · Build Auth Screens and Form Validation

Epic: [epic-03-authentication](../epics/epic-03-authentication.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Create the sign-up and login UI with validation and state handling.

## Implementation Steps

- [ ] Build the login and signup screen layouts with clear form fields and error states.
- [ ] Add form validation for required fields, email format, and password rules.
- [ ] Connect the UI to the auth API and handle loading, success, and error states.

## Technical Notes

- The UI should avoid hidden state and keep the submission flow predictable for the first-time user.
- Authentication errors should be surfaced in a way a user can act on immediately.

## Tests

- [ ] Add a UI test for the login form and a test for the signup form.
- [ ] Verify invalid input displays the expected client-side feedback.

## Documentation

- [ ] Document the auth screen flow and the expected API error mapping.

## Acceptance Criteria

- [ ] The screens render correctly and submit valid data.
- [ ] Invalid input is blocked with clear feedback.
- [ ] Successful auth updates the client state and exposes the authenticated route correctly.

## Deliverables

- Auth screens
- Form validation
- Frontend auth integration
