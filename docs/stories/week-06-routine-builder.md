# Week 06 - Routine Builder

## Goal
Introduce structured training plans so users can create and manage routines around exercises.

## Weekly Snapshot
- Outcome: A basic routine builder for organizing exercises into plans
- Focus: Routine schema, API, UI, and ordering logic
- Status: Todo

## Implementation Backlog

# TASK-023 · Create Routine Schema and Migration
Epic: Routines
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Create the schema for routines, routine items, and program membership.

## Implementation Steps
- [ ] Add routine and routine-item tables with an explicit ordering field.
- [ ] Add a migration for the new schema and verify it runs cleanly.
- [ ] Add indexes and constraints for routine ownership, item ordering, and deletion safety.

## Technical Notes
- The routine schema should support the future addition of duplicates, archives, and program membership without major migration churn.
- Keep the relationship between routines, routine items, and users explicit.

## Tests
- [ ] Add schema validation or migration smoke tests.
- [ ] Verify a routine with multiple items can be saved and fetched correctly.

## Documentation
- [ ] Document the routine data model and the meaning of each ordering field.

## Acceptance Criteria
- [ ] The migration runs successfully.
- [ ] Routines can be saved with their items.
- [ ] The schema supports future ordering and duplication without rework.

## Deliverables
- Routine schema migration
- Database model notes
- Initial routine structure

---

# TASK-024 · Add Routine CRUD API
Epic: Routines
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Expose create, update, and fetch endpoints for routines.

## Implementation Steps
- [ ] Implement create, update, and fetch handlers for routines and routine items.
- [ ] Validate routine payloads before saving and prevent invalid item references.
- [ ] Return the created or updated routine from the API with a stable response contract.

## Technical Notes
- The API should enforce that each routine item references a valid exercise and belongs to the correct owner.
- Use a consistent response shape so the editor UI can rely on it.

## Tests
- [ ] Add API tests for create, update, and invalid payload cases.
- [ ] Verify ownership rules prevent cross-user edits.

## Documentation
- [ ] Document the routine API endpoints, payload fields, and expected response shape.

## Acceptance Criteria
- [ ] Routines can be created and fetched.
- [ ] Updates persist changes correctly.
- [ ] Invalid payloads are rejected with clear errors.

## Deliverables
- Routine API endpoints
- Validation rules
- Response contracts

---

# TASK-025 · Build Routine List and Create UI
Epic: Routines
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Create the routine list view and create flow.

## Implementation Steps
- [ ] Build the list view for existing routines with empty, loading, and success states.
- [ ] Add a create routine action and a form that captures the basic routine name and description.
- [ ] Connect the UI to the routine API and surface loading and error feedback.

## Technical Notes
- The create flow should be intentionally lightweight so it can ship quickly and be expanded later.
- The list view should make it obvious when the user has no routines yet.

## Tests
- [ ] Add a UI test for creating a routine and a test for the empty state.
- [ ] Verify the form behaves correctly with validation errors.

## Documentation
- [ ] Document the routine list behavior and the create flow.

## Acceptance Criteria
- [ ] Users can see existing routines.
- [ ] Users can create a new routine from the UI.
- [ ] The create flow shows errors and loading feedback.

## Deliverables
- Routine list UI
- Create routine screen
- Routine API integration

---

# TASK-026 · Build Routine Editor Screen
Epic: Routines
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective
Create the editor screen for editing routine details and contents.

## Implementation Steps
- [ ] Build the routine editor screen for adding and removing exercises from a routine.
- [ ] Add the ability to switch between the routine details view and the exercise list view.
- [ ] Persist the saved changes through the routine API and show a save state.

## Technical Notes
- The editor should keep the user’s current edits in a local state until the save action succeeds.
- Make the screen robust to partial data so it can support future editing features.

## Tests
- [ ] Add a UI test covering the editor save path.
- [ ] Verify the editor shows validation errors for incomplete input.

## Documentation
- [ ] Document the editor workflow and the expected save behavior.

## Acceptance Criteria
- [ ] Exercises can be added and removed from a routine.
- [ ] Changes are reflected in the editor UI before and after saving.
- [ ] The saved routine state is available after the UI reloads.

## Deliverables
- Routine editor screen
- Edit/save workflow
- Persisted routine state

---

# TASK-026A · Implement Reorder and Persist Flow
Epic: Routines
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective
Add simple exercise reordering and persist the updated order to the backend.

## Implementation Steps
- [ ] Add a reorder interaction for routine items using drag or move controls.
- [ ] Update the local routine item ordering before sending the save request.
- [ ] Persist the new order through the routine API and reflect the saved state in the UI.

## Technical Notes
- The ordering logic should use an explicit position field rather than relying on array index assumptions.
- Make the interaction accessible and understandable for the first version of the routine builder.

## Tests
- [ ] Add tests for the reorder logic and the save request payload.
- [ ] Verify the updated order is preserved after a refresh.

## Documentation
- [ ] Document the reorder behavior and the expected persistence contract.

## Acceptance Criteria
- [ ] Routine items can be reordered.
- [ ] The updated order is saved successfully.
- [ ] The reordering state is visible after reload and in the saved routine response.

## Deliverables
- Reorder interaction
- Persisted routine order
- Reorder save logic
