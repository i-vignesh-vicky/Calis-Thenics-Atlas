# Programs - Functional Requirements

## Feature Overview

Programs provides pre-built, structured training plans created by coaches and the Atlas team. Users can browse, enroll in, and track progress through programs that match their goals and experience level.

### Value Proposition

- Structured guidance removes decision paralysis
- Programs created by experienced coaches
- Clear progression path from beginner to advanced
- Accountability and measurable progress

---

## User Flows

### Browse Programs

1. User navigates to Programs section
2. User sees featured programs and personalized recommendations
3. User filters by goal, duration, difficulty, or equipment
4. User taps program to view details

### View Program Details

1. User sees program overview, duration, difficulty
2. User reads description and learning outcomes
3. User sees program structure (weeks, workouts per week)
4. User can preview sample workout from program
5. User can read reviews/ratings

### Enroll in Program

1. User taps "Start Program"
2. User confirms choice
3. Program added to user's active programs
4. First workout made available
5. User receives welcome notification

### Track Program Progress

1. User views Program Dashboard
2. User sees progress through program (Week 3 of 12)
3. User checks off completed workouts
4. User can view next workouts scheduled
5. User can pause or exit program

### Complete Program

1. User completes final workout
2. System shows completion celebration
3. Completion tracked and recorded
4. User can restart or try new program
5. System suggests next program

---

## Acceptance Criteria

### Program Catalog

- Minimum 20 programs available at MVP
- Programs tagged by goal, difficulty, duration
- Program descriptions accurate and compelling
- Difficulty ratings consistent
- Each program has clear learning outcomes

### Enrollment

- User can enroll in multiple programs simultaneously
- Enrollment immediate with no pending state
- User can cancel enrollment anytime (no penalty)
- Cancellation preserves progress if user re-enrolls
- Cannot enroll in same program twice simultaneously

### Progress Tracking

- Current week and workout count visible
- Completed workouts checked off in list
- Next scheduled workout highlighted
- Progress persisted accurately
- Completion date recorded when program finishes

### Program Structure

- Programs consist of weeks (typically 4-12 weeks)
- Each week has defined workout schedule (e.g., 4 workouts/week)
- Workouts within program consistent with Workout Execution feature
- Program can be paused and resumed
- Workout order in program cannot be skipped

---

## Data Requirements

### Program Entity

```
id (UUID)
name (string, indexed)
description (string)
author_id (UUID, foreign key to User)
category (enum: strength, endurance, skill, flexibility)
primary_goal (enum)
difficulty_level (integer, 1-5)
duration_weeks (integer)
workouts_per_week (integer)
equipment_required (array of strings)
prerequisites (array of program_ids, nullable)
description_detailed (string)
created_at (timestamp)
updated_at (timestamp)
```

### Program Week Entity

```
id (UUID)
program_id (UUID, foreign key)
week_number (integer)
focus (string, e.g., "Push Strength")
description (string)
workouts (array of workout_templates)
```

### User Program Enrollment

```
id (UUID)
user_id (UUID, foreign key)
program_id (UUID, foreign key)
enrolled_at (timestamp)
started_at (timestamp, nullable)
completed_at (timestamp, nullable)
paused_at (timestamp, nullable)
current_week (integer)
status (enum: active, paused, completed, abandoned)
unique constraint on (user_id, program_id, status)
```

### Workout in Program

```
id (UUID)
program_week_id (UUID, foreign key)
day_number (integer)
name (string)
description (string)
planned_exercises (array of exercises)
focus_area (string)
estimated_duration (integer, minutes)
difficulty_in_program (integer, 1-5)
```

---

## Edge Cases

- User enrolls in program then immediately abandons - enrollment recorded for analytics
- User pauses program at week 6 - can resume from week 6, not week 1
- User tries program with missing prerequisite - show warning, allow anyway with guidance
- Program is updated while user is enrolled - enrolled user continues with original version
- User completes workouts out of order - system enforces order, requires sequential completion
- Program has 3 workouts/week but user wants 4 - system allows flexibility, user customizes

---

## MVP Scope (v1.0)

### Included

- 20+ pre-built programs across difficulty levels
- Browse and search programs
- Enroll and track progress
- Week-by-week progression
- Pause and resume functionality
- Completion tracking and celebration
- Program recommendations based on goals
- Basic reviews/ratings system

### Not Included (v2.0+)

- Coach-created custom programs per user
- Advanced scheduling (rest day rules, auto-scaling)
- Community programs (user-created)
- Program variant recommendations
- AI coaching during programs
- Live coach support

---

## Future Enhancements

### v2.0 - Personalized Programs

- Dynamic program adaptation based on user performance
- Coach creation tools for custom programs
- Community program sharing (curated)
- Advanced progress analytics within program
- Program recommendations based on recent performance

### v3.0 - Adaptive Training

- AI-powered program recommendations
- Real-time program adjustment based on user performance
- Predictive difficulty scaling
- Personalized rest day recommendations
- Integration with wearable metrics

---

## Implementation Considerations

### Athlete Data

- Track performance within each program
- Record completion metrics (time, difficulty felt, notes)
- Calculate average difficulty per user
- Use for future recommendations

### Versioning

- Programs versioned to handle updates
- Existing enrollments continue on enrolled version
- New enrollments use latest version

### Performance

- Program list cached and updated daily
- User's enrolled programs cached on device
- Progress updates submitted asynchronously

### Personalization

- Programs recommended based on:
  - User profile goals
  - Current experience level
  - Previous program completions
  - Time since last program
  - Trending goals in community

---

## Content Strategy

- Programs authored by Atlas coaches initially
- Each program field-tested before release
- Difficulty ratings calibrated through user feedback
- New programs added monthly based on demand
