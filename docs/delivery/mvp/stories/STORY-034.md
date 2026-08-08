# STORY-034 · Build Workout Detail and Summary UI

Epic: [epic-08-progress-and-history](../epics/epic-08-progress-and-history.md)
Estimate: 3 hrs
Priority: Medium
Status: Todo

## Objective

Show the details of a completed workout and its summary values.

## Implementation Steps

- [ ] Create the detail screen layout for the selected workout and display notes, sets, and summary values clearly.
- [ ] Add navigation back to the history list and a fallback state for missing session data.
- [ ] Connect the screen to the workout detail endpoint and render the returned summary values.

## Technical Notes

- The detail UI should remain readable even if some fields are missing or the workout is incomplete.
- Make the summary data easy to scan for the user rather than burying it in raw payloads.

## Tests

- [ ] Add a UI test for navigating to the detail screen and rendering the summary content.
- [ ] Verify the fallback state appears when data is missing.

## Documentation

- [ ] Document the detail screen structure and the summary data shown to the user.

## Acceptance Criteria

- [ ] The selected workout can be inspected in detail.
- [ ] Summary values are shown in a readable way.
- [ ] Navigation between history list and detail works.

## Deliverables

- Workout detail screen
- Summary display
- Navigation flow
