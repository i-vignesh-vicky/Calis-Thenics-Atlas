# STORY-046 · Build Search UI and Results List

Epic: [epic-10-search](../epics/epic-10-search.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Build the search bar and results list that users interact with to find exercises and routines.

## Implementation Steps

- [ ] Add a search bar with debounced input to the relevant screen or modal.
- [ ] Wire the input to the search API and display the results list below.
- [ ] Add loading, empty, and error states to the results list.

## Technical Notes

- Debounce the query to avoid firing a request on every keystroke.
- Show a clear empty state with a message when no results match.

## Tests

- [ ] Add a UI test for searching and receiving results.
- [ ] Verify the empty state renders when the query matches nothing.

## Documentation

- [ ] Document where the search UI lives and how users reach it.

## Acceptance Criteria

- [ ] Users can type a query and see matching results.
- [ ] Empty and loading states are visible.
- [ ] The search result navigates to the correct detail screen.

## Deliverables

- Search bar component
- Results list
- Empty and loading states
