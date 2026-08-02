# Week 08 - Workout History and Logging Improvements

## Goal
Make completed workouts understandable and reviewable through history and summary views.

## Weekly Snapshot
- Outcome: A reviewable workout history experience
- Focus: History APIs, summary formatting, and UI
- Status: Todo

## Implementation Backlog

# TASK-032 · Add Workout History Queries
Epic: Progress and History
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Expose APIs for recent workout sessions and details.

## Implementation Steps
- [ ] Implement query endpoints for workout history and detail with a default limit.
- [ ] Add pagination or result limits for the history list so the UI remains responsive.
- [ ] Return summary fields such as duration, completion time, routine name, and workout status.

## Technical Notes
- The history contract should be explicit so the list and detail views do not need to reassemble data from multiple sources.
- Keep the response shape predictable for the UI and future analytics work.

## Tests
- [ ] Add API tests for the history list and detail endpoints.
- [ ] Verify pagination and empty results behave correctly.

## Documentation
- [ ] Document the history API contract and expected summary fields.

## Acceptance Criteria
- [ ] Recent workouts can be fetched by the client.
- [ ] Detail responses include the relevant session data.
- [ ] The history response is stable for UI rendering.

## Deliverables
- Workout history API
- History query endpoints
- Summary field contract

---

# TASK-033 · Build Workout History List UI
Epic: Progress and History
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the history list experience for completed workouts.

## Implementation Steps
- [ ] Build the history list screen with session cards or rows that summarize the workout.
- [ ] Add loading, error, and empty states for the list.
- [ ] Connect the UI to the history API and render the returned summary fields.

## Technical Notes
- The history list should make the next action obvious, such as opening a detail screen or returning to the workout flow.
- Keep the visual treatment simple but consistent with the rest of the app shell.

## Tests
- [ ] Add a UI test for the history list and the empty state.
- [ ] Verify the list renders correctly when the API returns a populated or empty history set.

## Documentation
- [ ] Document the expected history list behavior and fallback states.

## Acceptance Criteria
- [ ] Completed workouts appear in the history list.
- [ ] Empty state is shown when no history exists.
- [ ] The list renders without crashes.

## Deliverables
- History list screen
- API integration
- Loading/empty states

---

# TASK-034 · Build Workout Detail and Summary UI
Epic: Progress and History
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Show the details of a completed workout and its summary values.

## Implementation Steps
- [ ] Create the detail screen layout for the selected workout and display notes, sets, and summary values clearly.
- [ ] Add navigation back to the history list and a fallback state for missing session data.
- [ ] Connect the screen to the workout detail endpoint and render the returned summary values.

## Technical Notes
- The detail UI should remain readable even if some fields are missing or the workout is incomplete.
- Make the summary data easy to scan for the user rather than burying it in raw payloads.

## Tests
- [ ] Add a UI test for navigating to the detail screen and rendering the summary content.
- [ ] Verify the fallback state appears when data is missing.

## Documentation
- [ ] Document the detail screen structure and the summary data shown to the user.

## Acceptance Criteria
- [ ] The selected workout can be inspected in detail.
- [ ] Summary values are shown in a readable way.
- [ ] Navigation between history list and detail works.

## Deliverables
- Workout detail screen
- Summary display
- Navigation flow

---

# TASK-035 · Add History Tests and Notes
Epic: Progress and History
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add basic regression coverage for history and summary rendering.

## Implementation Steps
- [ ] Add API tests for history and detail responses.
- [ ] Add a UI test for history rendering and the empty state.
- [ ] Add short documentation notes that describe the user-facing history flow.

## Technical Notes
- Keep the history tests focused on the user-visible contract rather than every possible internal implementation detail.
- Use the tests to protect regressions in the summary rendering and navigation behavior.

## Tests
- [ ] Ensure history tests pass locally.
- [ ] Confirm the list and detail experience are covered in CI.

## Documentation
- [ ] Add notes for the history flow and expected UI behavior.

## Acceptance Criteria
- [ ] History tests pass locally.
- [ ] The list and detail experience are covered.
- [ ] The test commands are documented.

## Deliverables
- History tests
- Documentation notes
- Regression coverage
