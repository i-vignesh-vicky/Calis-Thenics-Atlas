# STORY-026 · Build Routine Editor Screen

Epic: [epic-06-routines](../epics/epic-06-routines.md)
Estimate: 4 hrs
Priority: High
Status: Todo

## Objective

Create the editor screen for editing routine details and contents.

## Implementation Steps

- [ ] Build the routine editor screen for adding and removing exercises from a routine.
- [ ] Add the ability to switch between the routine details view and the exercise list view.
- [ ] Persist the saved changes through the routine API and show a save state.

## Technical Notes

- The editor should keep the user's current edits in a local state until the save action succeeds.
- Make the screen robust to partial data so it can support future editing features.

## Tests

- [ ] Add a UI test covering the editor save path.
- [ ] Verify the editor shows validation errors for incomplete input.

## Documentation

- [ ] Document the editor workflow and the expected save behavior.

## Acceptance Criteria

- [ ] Exercises can be added and removed from a routine.
- [ ] Changes are reflected in the editor UI before and after saving.
- [ ] The saved routine state is available after the UI reloads.

## Deliverables

- Routine editor screen
- Edit/save workflow
- Persisted routine state
