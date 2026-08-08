# STORY-037 · Expose Progress Summary API

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
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
