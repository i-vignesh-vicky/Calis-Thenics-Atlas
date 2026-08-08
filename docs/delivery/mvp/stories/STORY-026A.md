# STORY-026A · Implement Reorder and Persist Flow

Epic: [epic-06-routines](../epics/epic-06-routines.md)
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
