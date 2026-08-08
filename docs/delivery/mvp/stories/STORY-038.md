# STORY-038 · Build Progress Dashboard UI

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Create a dashboard screen that surfaces progress information.

## Implementation Steps

- [ ] Add progress cards or summary widgets to the UI and connect them to the progress API.
- [ ] Add loading and empty states for the dashboard and ensure the layout handles missing values gracefully.
- [ ] Make the dashboard reachable from the main navigation shell.

## Technical Notes

- The initial dashboard should prioritize the highest-value progress signals instead of trying to show every future metric.
- Use shared components where possible so the cards stay visually consistent.

## Tests

- [ ] Add a UI test for loading and empty states.
- [ ] Verify the dashboard renders the summary metrics correctly.

## Documentation

- [ ] Document the dashboard layout and the metrics it displays.

## Acceptance Criteria

- [ ] The dashboard renders progress summaries clearly.
- [ ] The UI loads data without breaking on empty states.
- [ ] The screen is accessible from the main navigation shell.

## Deliverables

- Progress dashboard UI
- API integration
- Loading/empty states
