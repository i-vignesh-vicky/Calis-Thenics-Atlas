# Week 05 - Exercise Library

## Goal
Create the first reusable content system by enabling users to browse and inspect exercises.

## Weekly Snapshot
- Outcome: An initial exercise library that users can browse and inspect
- Focus: Exercise data, API, UI, and seeded content
- Status: Todo

## Implementation Backlog

# TASK-019 · Create Exercise Schema and Seed Data
Epic: Exercises
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

---

# TASK-020 · Add Exercise List and Detail API
Epic: Exercises
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Expose list and detail endpoints for exercises.

## Implementation Steps
- [ ] Implement list and detail handlers for exercises with a stable response shape.
- [ ] Add filtering support for category and difficulty and handle empty filter combinations.
- [ ] Return the selected exercise metadata in a consistent shape for the frontend.

## Technical Notes
- The API contract should be simple and stable so the list view and detail view can use the same response format.
- Add field normalization if the backend and frontend use different naming conventions.

## Tests
- [ ] Add API tests for list, detail, and filtered responses.
- [ ] Verify the detail endpoint returns the correct exercise for the requested ID.

## Documentation
- [ ] Document the exercise API contract and filter parameters.

## Acceptance Criteria
- [ ] The API returns a list of exercises.
- [ ] The detail endpoint returns the correct exercise by ID.
- [ ] Filters can be applied without breaking the response shape.

## Deliverables
- Exercise API endpoints
- Filter support
- API response shape notes

---

# TASK-021 · Build Exercise List and Filters UI
Epic: Exercises
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Create the exercise browsing UI and filter controls.

## Implementation Steps
- [ ] Build the list view with cards or rows for exercise items.
- [ ] Add filter controls for category and difficulty and support resetting the filters.
- [ ] Connect the UI to the exercise API and show loading, error, and empty states.

## Technical Notes
- The UI should be built around the same exercise metadata returned by the API so the list and detail views remain coherent.
- Keep the filter UI simple; the focus is a usable browse experience rather than a full search experience.

## Tests
- [ ] Add a render test for the list view and a test for filter interaction.
- [ ] Verify loading and empty states are shown correctly.

## Documentation
- [ ] Document the expected exercise list behavior and filter interactions.

## Acceptance Criteria
- [ ] The list view renders exercise cards or rows.
- [ ] Filters can be applied and reset.
- [ ] Loading and empty states are visible and understandable.

## Deliverables
- Exercise browsing UI
- Filter controls
- API integration

---

# TASK-022 · Build Exercise Detail View
Epic: Exercises
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective
Add the detail view for an exercise so users can inspect metadata.

## Implementation Steps
- [ ] Create the detail screen layout with title, instructions, and metadata.
- [ ] Connect the screen to the detail API endpoint and load the selected exercise data.
- [ ] Add a back navigation and an empty-state guard for missing data.

## Technical Notes
- The detail view should be readable even when the content is sparse, so the UI must tolerate missing metadata gracefully.
- Use the same shared components used elsewhere in the app to keep the experience consistent.

## Tests
- [ ] Add a UI test for navigation from the list to the detail view.
- [ ] Verify the empty-state and loading states behave correctly.

## Documentation
- [ ] Document the expected exercise detail layout and any required fallback content.

## Acceptance Criteria
- [ ] Selecting an exercise opens the detail view.
- [ ] The detail content matches the selected exercise record.
- [ ] The view handles missing data safely.

## Deliverables
- Exercise detail screen
- Detail API integration
- Empty-state handling
