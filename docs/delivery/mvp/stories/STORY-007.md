# STORY-007 · Create Shared UI Primitives

Epic: [epic-02-design-system](../epics/epic-02-design-system.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add reusable UI primitives for buttons, cards, and form controls.

## Implementation Steps

- [ ] Create simple button, card, input, and empty-state primitives.
- [ ] Add basic variants for primary, secondary, and disabled states.
- [ ] Document the expected usage pattern for each primitive so feature work can reuse them consistently.

## Technical Notes

- Keep the primitives minimal and composable rather than building overly generic components.
- Make them work with the shared tokens so they remain visually consistent.

## Tests

- [ ] Add render tests for each primitive to catch style or prop regressions.
- [ ] Verify variants render without layout errors.

## Documentation

- [ ] Add a short component note describing the primitives and when to use each one.

## Acceptance Criteria

- [ ] Shared primitives render without layout errors.
- [ ] Components can be reused by feature screens.
- [ ] The primitives are documented in a minimal way that is useful for future implementation.

## Deliverables

- Shared button/card/input components
- Basic component docs
- Reusable styling primitives
