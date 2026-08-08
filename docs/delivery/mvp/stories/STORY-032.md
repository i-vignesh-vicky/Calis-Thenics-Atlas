# STORY-032 · Add Workout History Queries

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
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
