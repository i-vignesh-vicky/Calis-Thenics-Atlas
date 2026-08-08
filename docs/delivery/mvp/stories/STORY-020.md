# STORY-020 · Add Exercise List and Detail API

Epic: [epic-05-exercise-library](../epics/epic-05-exercise-library.md)
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
