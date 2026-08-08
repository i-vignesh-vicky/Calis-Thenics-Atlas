# STORY-060 · Add Feedback Capture Path

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add a lightweight in-app path for beta testers to submit feedback.

## Implementation Steps

- [ ] Add a feedback entry point in the app such as a menu item or floating button accessible from key screens.
- [ ] Implement a simple feedback form with a category field and free-text message.
- [ ] Route submissions to a triage channel or store (email, spreadsheet, or lightweight backend endpoint).

## Technical Notes

- Keep the feedback form minimal: category and message are enough for MVP beta.
- Attach the current screen or context automatically if possible to help with triage.

## Tests

- [ ] Add a test for the feedback submission flow.
- [ ] Verify submissions reach the triage destination.

## Documentation

- [ ] Document the feedback entry point and where submissions go.

## Acceptance Criteria

- [ ] Beta testers can submit feedback from inside the app.
- [ ] Submissions are routed to the triage channel.
- [ ] The form is minimal and low friction.

## Deliverables

- Feedback form UI
- Submission routing
- Triage destination configuration
