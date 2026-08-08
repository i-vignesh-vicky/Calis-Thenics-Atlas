# STORY-025 · Build Routine List and Create UI

Epic: [epic-06-routines](../epics/epic-06-routines.md)
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
