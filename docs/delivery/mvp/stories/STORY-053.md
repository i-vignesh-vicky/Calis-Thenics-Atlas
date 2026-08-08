# STORY-053 · Add Empty and Loading States

Epic: [epic-12-quality](../epics/epic-12-quality.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Ensure all list and data screens have consistent empty and loading states.

## Implementation Steps

- [ ] Audit all screens that load data and identify those missing loading or empty states.
- [ ] Add a shared loading skeleton or spinner component and apply it consistently.
- [ ] Add empty state components with helpful copy for each screen where the list can legitimately be empty.

## Technical Notes

- Prefer skeleton loaders over spinners for screens with known layout to reduce layout shift.
- Empty state copy should guide the user to the next action rather than just saying "Nothing here."

## Tests

- [ ] Add UI tests that verify loading and empty states render for each audited screen.

## Documentation

- [ ] Document the shared loading and empty state components and their usage.

## Acceptance Criteria

- [ ] All data screens show a loading state while fetching.
- [ ] All list screens show an empty state when no items exist.
- [ ] States are consistent in appearance across the app.

## Deliverables

- Shared loading component
- Empty state components
- Consistent state coverage across all data screens
