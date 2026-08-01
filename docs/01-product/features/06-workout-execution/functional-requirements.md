# Workout Execution - Functional Requirements

## Feature Overview

Workout Execution is the core of Atlas. It manages the real-time workout session - from starting a session, logging exercises and sets, recording performance data, to completing the workout. This is where all training happens.

### Value Proposition

- Intuitive, in-the-moment workout tracking
- Comprehensive performance data capture
- Immediate feedback and guidance
- Foundation for progress tracking and personalization

---

## User Flows

### Create Workout Session

1. User taps "Start Workout"
2. User can select:
   - Use saved routine
   - Use program workout
   - Create custom (manually select exercises)
3. Workout session created with timestamp

### Log Exercise Set

1. User sees first exercise in workout
2. For each set:
   - Input reps completed
   - Input weight (if applicable)
   - Optional: input RPE (rate of perceived exertion)
   - Optional: input notes
   - Tap "Set Complete" or swipe to next
3. After completing exercise, move to next

### Session Controls

1. User can pause workout (timer stops)
2. User can resume workout
3. User can skip exercise (recorded)
4. User can remove exercise from session
5. User can add exercise mid-session

### Complete Workout

1. User completes final exercise
2. User taps "Finish Workout"
3. Optional: add overall notes/reflections
4. Optional: rate workout difficulty (1-10)
5. Workout saved and logged
6. Completion celebration/stats shown

### View Session History

1. User navigates to History/Past Workouts
2. User sees list of recent workouts with date, duration, exercises
3. User taps workout to view full details
4. User can view all sets, reps, weights logged

---

## Acceptance Criteria

### Session Creation

- Workout can be created in <5 seconds
- Workout linked to routine or program if used
- Start time recorded accurately
- Session state persists if app crashes/closes

### Set Logging

- Reps input accepts 0-999 range
- Weight input supports decimals (0.0-999.9)
- RPE accepts 1-10 scale
- Notes support up to 500 characters
- Each set logged with timestamp

### Session Tracking

- Elapsed time accurate (accounting for pause)
- Exercise count correct
- Total volume calculated (reps × weight × sets)

### Completion

- Workout duration calculated correctly
- All logged data saved
- Completion date/time recorded
- User can immediately view just-completed workout

### Recovery Data

- Rest time between exercises tracked
- Fatigue indicators captured
- Recovery notes preserved

---

## Data Requirements

### Workout Session Entity

```
id (UUID)
user_id (UUID, foreign key)
started_at (timestamp)
completed_at (timestamp, nullable)
duration_seconds (integer)
routine_id (UUID, foreign key, nullable)
program_workout_id (UUID, foreign key, nullable)
status (enum: in_progress, paused, completed, abandoned)
overall_notes (string, nullable)
difficulty_felt (integer, 1-10, nullable)
created_at (timestamp)
updated_at (timestamp)
```

### Exercise Set Data

```
id (UUID)
workout_session_id (UUID, foreign key)
exercise_id (UUID, foreign key)
position (integer)
set_number (integer)
reps_completed (integer)
weight_used (decimal, nullable)
rpe_perceived (integer, 1-10, nullable)
duration_seconds (integer, nullable)
notes (string, nullable)
logged_at (timestamp)
```

### Workout Pause Record

```
id (UUID)
workout_session_id (UUID, foreign key)
paused_at (timestamp)
resumed_at (timestamp, nullable)
pause_reason (string, nullable)
```

---

## Edge Cases

- User loses connection mid-workout - session recoverable, shows "offline mode"
- User starts workout with 1 exercise, adds 5 more mid-session - all 6 exercises logged correctly
- User logs 100 reps for a set - unusual but accepted
- User completes set with 0 reps (couldn't do it) - logged as failure, recorded
- User skips 3 exercises in workout - still counted as "attempted", marked skipped
- User pauses for 30 minutes - rest time captured, counted in session duration
- User deletes app during workout then reinstalls - workout data recoverable from cloud
- User tries to log negative reps - rejected with clear error message

---

## MVP Scope (v1.0)

### Included

- Create workout from scratch or use routine/program
- Exercise selection and ordering
- Set-by-set logging (reps, weight, RPE)
- Optional notes per set
- Pause/resume capability
- Skip exercise option
- Workout duration tracking
- Rest time between exercises
- Overall workout notes and difficulty rating
- Instant workout completion
- View completed workouts in history
- Delete workouts (with confirmation)

### Not Included (v2.0+)

- Video recording of sets
- Form checking AI
- Real-time coaching during workout
- Social sharing mid-workout
- Live workout tracking by coach
- Advanced analytics dashboard
- Form correction feedback

---

## Future Enhancements

### v2.0 - Enhanced Tracking

- Voice logging ("20 reps, 8 pounds")
- Photo/video capture of sets
- Automatic rest timer
- Suggested next set weight based on RPE
- Form assessment integration

### v3.0 - AI Coaching

- Real-time AI coaching during session
- Form correction recommendations
- Adaptive rep/weight suggestions
- Fatigue detection and session modification
- Recovery recommendations

---

## Implementation Considerations

### Performance

- Logging a set must be <200ms
- No lag when transitioning between exercises
- Session data syncs asynchronously (doesn't block UI)
- Can complete full workout with zero network (offline support)

### Data Integrity

- Every set logged immutably (never deleted, only marked)
- Workout duration calculated from timestamps, not user input
- Sync conflicts resolved with "last write wins"

### User Experience

- Large, easy-to-tap buttons during workout
- Minimal distractions (hide chat, notifications)
- Dark mode for gym environment
- Countdown rest timer between sets
- "What's next?" preview of next exercise

### Offline Capability

- Full workout capability without internet
- Data syncs when connection restored
- Indicator shows offline status
- Can resume interrupted sync

### Data Quality

- Validate reps are reasonable (0-1000)
- Validate weight is positive
- Validate RPE is 1-10
- Timestamp all data for audit trail

---

## UI/UX Considerations

- Large, glove-friendly buttons
- Text size readable from arm's length
- Dark mode to reduce glare
- Haptic feedback for set completion
- Audio cues for rest intervals
- Simple, clutter-free interface during active set

---

## Performance Tracking

Data captured enables:
- Volume calculations (sets × reps × weight)
- Progressive overload tracking
- Consistency metrics
- Personal records detection
- Exercise frequency analysis
