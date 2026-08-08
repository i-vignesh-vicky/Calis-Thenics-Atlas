# STORY-050 · Build Settings UI and Preference Controls

Epic: [epic-11-settings](../epics/epic-11-settings.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Build the settings screen with controls for display, unit, and notification preferences.

## Implementation Steps

- [ ] Create the settings screen with controls for theme, units (metric/imperial), and any MVP preference toggles.
- [ ] Connect each control to the settings API and persist changes on selection.
- [ ] Show save feedback and handle errors gracefully so the user knows whether the change was applied.

## Technical Notes

- Keep the settings screen simple and direct; avoid deep nesting or multi-step flows for MVP preferences.
- Make the save interaction feel immediate so users do not wonder if the change was applied.

## Tests

- [ ] Add UI tests for changing a setting and verifying the control reflects the saved state.
- [ ] Verify the error state is shown when the API call fails.

## Documentation

- [ ] Document the preference controls and which settings are available.

## Acceptance Criteria

- [ ] Users can change and save app settings from the UI.
- [ ] The controls reflect the current saved state on load.
- [ ] Errors and save confirmations are visible.

## Deliverables

- Settings screen
- Preference controls
- Save feedback handling
