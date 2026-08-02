# Week 09 - Progress Tracking Basics

## Goal
Show users meaningful growth signals from their completed workouts.

## Weekly Snapshot
- Outcome: Clear progress visibility for streaks, milestones, and records
- Focus: Calculation logic, API, and dashboard UI
- Status: Todo

## Implementation Backlog

# TASK-036 · Implement Streak and Milestone Calculations
Epic: Progress
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the domain logic for streaks, active days, and milestones.

## Implementation Steps
- [ ] Add deterministic functions for streak calculation from workout history.
- [ ] Add milestone thresholds and personal record detection logic using the saved workout metrics.
- [ ] Ensure the logic is testable and independent of the UI layer.

## Technical Notes
- The calculations should work off a clean domain model rather than ad hoc UI state.
- Keep the thresholds explicit so they can be adjusted later without rewriting the full calculation path.

## Tests
- [ ] Add unit tests for streak calculation over sample workout histories.
- [ ] Verify milestone thresholds and personal record detection return the expected values.

## Documentation
- [ ] Document the progress rules and the meaning of each metric.

## Acceptance Criteria
- [ ] Streak values are computed correctly for sample data.
- [ ] Milestone thresholds produce expected results.
- [ ] Personal record detection works for tracked metrics.

## Deliverables
- Progress calculation logic
- Milestone rules
- Testable domain functions

---

# TASK-037 · Expose Progress Summary API
Epic: Progress
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Expose the computed progress values to the frontend.

## Implementation Steps
- [ ] Add an API endpoint that returns calculated progress summaries for the authenticated user.
- [ ] Include streaks, active days, milestones, and personal records in the response.
- [ ] Handle empty or missing progress data safely and return a clear empty-state structure.

## Technical Notes
- The API contract should be deliberately simple so the dashboard UI can render it without extra transformation.
- Cache or memoize the output if the current stack benefits from it, but keep the first implementation simple.

## Tests
- [ ] Add API tests for populated and empty progress payloads.
- [ ] Verify the endpoint returns a stable response shape.

## Documentation
- [ ] Document the progress summary response fields and their meanings.

## Acceptance Criteria
- [ ] The progress API returns summarized values.
- [ ] The response format is stable for the UI.
- [ ] The endpoint handles empty or missing progress data safely.

## Deliverables
- Progress API endpoint
- Summary response model
- Empty-state handling

---

# TASK-038 · Build Progress Dashboard UI
Epic: Progress
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Create a dashboard screen that surfaces progress information.

## Implementation Steps
- [ ] Add progress cards or summary widgets to the UI and connect them to the progress API.
- [ ] Add loading and empty states for the dashboard and ensure the layout handles missing values gracefully.
- [ ] Make the dashboard reachable from the main navigation shell.

## Technical Notes
- The initial dashboard should prioritize the highest-value progress signals instead of trying to show every future metric.
- Use shared components where possible so the cards stay visually consistent.

## Tests
- [ ] Add a UI test for loading and empty states.
- [ ] Verify the dashboard renders the summary metrics correctly.

## Documentation
- [ ] Document the dashboard layout and the metrics it displays.

## Acceptance Criteria
- [ ] The dashboard renders progress summaries clearly.
- [ ] The UI loads data without breaking on empty states.
- [ ] The screen is accessible from the main navigation shell.

## Deliverables
- Progress dashboard UI
- API integration
- Loading/empty states

---

# TASK-039 · Add Progress Logic Tests
Epic: Progress
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add tests for the progress calculation rules.

## Implementation Steps
- [ ] Add unit tests for streak and milestone logic.
- [ ] Add tests for empty or partial progress inputs.
- [ ] Add a simple API test for the summary endpoint.

## Technical Notes
- Prioritize deterministic progress logic tests over broad UI tests for this week.
- Keep the test data small but representative so regressions are easy to understand.

## Tests
- [ ] Ensure progress tests pass locally.
- [ ] Confirm the core logic has clear regression coverage in CI.

## Documentation
- [ ] Document the progress test commands and the test data assumptions.

## Acceptance Criteria
- [ ] Progress tests pass locally.
- [ ] Core logic has clear regression coverage.
- [ ] The test suite is runnable in CI.

## Deliverables
- Progress tests
- Regression coverage
- CI readiness note
