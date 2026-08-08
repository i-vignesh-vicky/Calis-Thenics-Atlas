# STORY-006 · Add Design Tokens and Theme Provider

Epic: [epic-02-design-system](../epics/epic-02-design-system.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Create the shared design tokens and theme provider used across the app.

## Implementation Steps

- [ ] Add design tokens for color, typography, spacing, radius, and elevation.
- [ ] Create a theme provider or wrapper for the frontend shell and mount it at the app root.
- [ ] Expose the tokens through a shared styling layer so feature screens can consume them directly.

## Technical Notes

- The theme should support light and dark modes only if the product direction requires it; otherwise keep the initial system simple.
- Ensure the tokens are centralized so component changes do not require touching multiple files.

## Tests

- [ ] Add a component-level test that renders a sample screen with the theme applied.
- [ ] Verify the theme provider does not break the existing app shell.

## Documentation

- [ ] Document the token naming convention and where new values should be added.

## Acceptance Criteria

- [ ] Tokens are available in one central place.
- [ ] The theme provider is mounted in the app shell.
- [ ] The visual system is consistent in a sample view and is reusable by feature screens.

## Deliverables

- Design tokens
- Theme provider
- Shared styling foundation
