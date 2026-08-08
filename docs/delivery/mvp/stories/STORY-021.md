# STORY-021 · Build Exercise List and Filters UI

Epic: [epic-05-exercise-library](../epics/epic-05-exercise-library.md)
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
