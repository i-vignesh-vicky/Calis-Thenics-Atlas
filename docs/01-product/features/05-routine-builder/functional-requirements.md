# Routine Builder - Functional Requirements

## Feature Overview

Routine Builder empowers users to create, customize, and manage their own workout routines. Users can compose exercises, organize them, and save reusable templates that fit their needs and schedule.

### Value Proposition

- Complete autonomy in workout design
- Quick access to frequently used routines
- Support for varied training styles and preferences
- Building block for personal training philosophy

---

## User Flows

### Create New Routine

1. User taps "Create Routine"
2. User names routine (e.g., "Upper Body A")
3. User adds exercises one by one
4. For each exercise: select exercise, set targets (reps/sets/weight)
5. User can reorder exercises by dragging
6. User saves routine

### Browse User Routines

1. User navigates to Routines section
2. User sees list of saved routines with thumbnails
3. User can see routine details (# exercises, last used)
4. User taps routine to view or edit

### Use Routine in Workout

1. During workout creation, user can select "Use Routine"
2. System loads all exercises from routine
3. User can adjust or skip exercises for this session
4. Workout logged as normal

### Edit Routine

1. User opens routine
2. User can:
   - Add new exercise to routine
   - Remove exercise from routine
   - Reorder exercises
   - Change target sets/reps
   - Rename routine
3. Changes saved automatically
4. All future uses of routine reflect changes

### Duplicate Routine

1. User selects routine
2. User taps "Duplicate"
3. New copy created with "(Copy)" suffix
4. User can rename and modify copy
5. Original routine unchanged

### Archive Routine

1. User taps "Archive" on routine
2. Routine moved to archive section
3. Archived routines not shown in active list
4. Can be unarchived if needed

---

## Acceptance Criteria

### Routine Creation

- User must provide routine name
- Routine can have 1-50 exercises
- Exercises in routine appear in saved order
- Routine saved successfully with all details
- Saved routines persist across sessions

### Routine Management

- User can edit any routine at any time
- Edits apply to routine, not to past workouts using routine
- User can duplicate routines
- User can archive/unarchive routines
- User can delete routines (with confirmation)

### Routine Usage

- Routine can be selected when creating workout
- All exercises and targets load from routine
- User can modify exercise selection per workout
- Routine used is recorded in workout data

---

## Data Requirements

### Routine Entity

```
id (UUID)
user_id (UUID, foreign key)
name (string, indexed)
description (string, nullable)
exercises (array of routine_exercise_configs)
created_at (timestamp)
updated_at (timestamp)
last_used_at (timestamp, nullable)
usage_count (integer, default 0)
is_archived (boolean, default false)
```

### Routine Exercise Config

```
id (UUID)
routine_id (UUID, foreign key)
exercise_id (UUID, foreign key)
position (integer, for ordering)
planned_sets (integer, nullable)
planned_reps (string, e.g., "8-12", "max reps")
planned_weight (decimal, nullable)
planned_rpe (integer, 1-10, nullable)
notes (string, nullable)
```

---

## Edge Cases

- User creates routine with same name twice - allow duplicates, show in list
- User edits routine then starts workout before loading changes - workout shows old config, user can manually update
- User creates routine with 50 exercises - allow but warn about session duration
- User deletes routine - confirm deletion, cannot undo
- User duplicates routine 10 times - all copies saved, no limit on copies
- Routine used in 100 workouts then deleted - workouts still reference exercise data, not affected
- User creates routine then immediately archives - routine not shown in active list

---

## MVP Scope (v1.0)

### Included

- Create custom routines
- Name and describe routines
- Add exercises to routines
- Set targets (sets, reps, weight, RPE)
- Edit routines (add, remove, reorder exercises)
- Duplicate routines
- Archive/unarchive routines
- Use routines when creating workouts
- View routine usage history
- Delete routines

### Not Included (v2.0+)

- Routine sharing with other users
- Routine templates from coaches
- Routine analytics and optimization
- AI routine recommendations
- Automatic difficulty scaling
- Community routine gallery

---

## Future Enhancements

### v2.0 - Sharing and Discovery

- Share routines with specific users
- Public routine gallery (opt-in)
- Routine templates from coaches
- Copy community routines
- Routine ratings and reviews

### v3.0 - Intelligence

- AI-powered routine suggestions based on goals
- Automatic routine difficulty adjustment
- Routine optimization based on performance
- Routine recommendations based on recent completions
- Multi-week routine plans

---

## Implementation Considerations

### Performance

- Routine list should load in <200ms
- Routine with 50 exercises should render smoothly
- Updating routine should be instant (optimistic UI update)

### Data Integrity

- Ensure routine exercise positions remain ordered
- Prevent orphaned routine_exercise_config records
- Archive flag prevents accidental list clutter

### User Experience

- Make routine creation simple (5 exercise setup in <2 min)
- Show routine usage frequency to encourage reuse
- Provide template suggestions for first-time builders

### Sync

- Routine edits sync across devices
- If edited on multiple devices simultaneously, last write wins
- Conflicts resolved automatically

---

## Routine Templates (Future Consideration)

Consider pre-made routine templates for MVP:

- "Upper Body A" - classic upper body
- "Lower Body" - leg focused
- "Full Body" - total body sessions
- "Core and Mobility" - recovery focused
- "Skill Practice" - focused skill work
