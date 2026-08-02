# Week 03 - Authentication Foundation

## Goal
Deliver the first end-to-end vertical slice by enabling users to create accounts, log in, and stay authenticated.

## Weekly Snapshot
- Outcome: A working sign-up and sign-in experience
- Focus: Auth schema, API, UI, and tests
- Status: Todo

## Implementation Backlog

# TASK-010 · Create Auth Database Schema
Epic: Authentication
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

---

# TASK-011 · Implement Auth API Endpoints
Epic: Authentication
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Add the backend endpoints for signup, login, and logout.

## Implementation Steps
- [ ] Implement signup, login, and logout handlers with clear request validation.
- [ ] Add password hashing and verification logic using the project’s chosen crypto library.
- [ ] Return structured validation errors for invalid input, missing fields, and duplicate emails.

## Technical Notes
- The API should separate the validation layer from the persistence layer so the handlers remain readable.
- Make the response shape predictable for the frontend so auth state handling is simple.

## Tests
- [ ] Add unit tests for signup validation and password hashing.
- [ ] Add integration tests for successful and failed login flows.

## Documentation
- [ ] Document the request and response payloads for each auth endpoint.

## Acceptance Criteria
- [ ] Signup creates a new user record.
- [ ] Login authenticates valid credentials.
- [ ] Logout invalidates the current session cleanly and returns a clear status.

## Deliverables
- Auth API handlers
- Password hashing flow
- Error response model

---

# TASK-012 · Add Session Persistence and Token Handling
Epic: Authentication
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Persist auth state across requests and provide a safe session mechanism.

## Implementation Steps
- [ ] Create a token or session creation flow that is tied to a user identity.
- [ ] Add middleware or helper logic to read the session from requests and attach the user context.
- [ ] Reject invalid, expired, or tampered sessions with clear error handling.

## Technical Notes
- Session handling should be centralized so it is easy to apply across future protected routes.
- Keep the implementation compatible with the chosen backend stack and deployment assumptions.

## Tests
- [ ] Add tests for valid sessions, invalid tokens, and expired sessions.
- [ ] Verify protected routes reject unauthenticated requests.

## Documentation
- [ ] Document the auth flow and how the frontend should store and refresh session data.

## Acceptance Criteria
- [ ] Authenticated requests can be recognized.
- [ ] The session is attached consistently to the request context.
- [ ] Invalid sessions are rejected clearly without leaking sensitive details.

## Deliverables
- Session handling logic
- Auth middleware
- Session validation rules

---

# TASK-013 · Build Auth Screens and Form Validation
Epic: Authentication
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

---

# TASK-014 · Add Auth Regression Tests
Epic: Authentication
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add unit or integration coverage for the main auth flow.

## Implementation Steps
- [ ] Add tests for signup validation and success path.
- [ ] Add tests for login failure and success cases.
- [ ] Add one end-to-end test for the login screen flow and the route change after authentication.

## Technical Notes
- Keep the regression suite scoped to the core auth flow rather than broad end-to-end coverage.
- Use the tests to protect the main happy path and the most likely failure cases.

## Tests
- [ ] Ensure the auth tests pass in the local test suite.
- [ ] Confirm the tests are runnable in CI.

## Documentation
- [ ] Document the test commands required to run the auth suite locally.

## Acceptance Criteria
- [ ] Auth tests pass in the local test suite.
- [ ] Regression coverage exists for the core flow.
- [ ] The test commands are documented.

## Deliverables
- Auth tests
- Test docs
- Regression coverage
