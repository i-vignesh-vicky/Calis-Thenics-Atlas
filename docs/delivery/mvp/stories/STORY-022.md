# STORY-022 · Build Exercise Detail View

Epic: [epic-05-exercise-library](../epics/epic-05-exercise-library.md)
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
