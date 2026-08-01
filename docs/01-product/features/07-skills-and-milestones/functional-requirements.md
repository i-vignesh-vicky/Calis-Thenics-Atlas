# Skills and Milestones - Functional Requirements

## Feature Overview

Skills and Milestones transforms individual workout data into achievement recognition. Users progress through skill stages, unlock new abilities, and celebrate concrete milestones in their fitness journey.

### Value Proposition

- Makes progress visible and concrete
- Provides achievable, sequential goals
- Celebrates transformation and growth
- Builds identity as a person who can do hard things

---

## User Flows

### Browse Skills

1. User navigates to Skills section
2. User sees all trackable skills (pull-ups, push-ups, handstand, etc.)
3. For each skill, user sees:
   - Current stage (Stage 1-5 or Mastered)
   - Progress to next stage
   - Visual representation of progression

### View Skill Details

1. User taps specific skill
2. User sees skill stages with descriptions
3. User can see requirements for each stage
4. User can view their personal record
5. User can view progression timeline

### View Milestones Dashboard

1. User sees major milestones achieved
2. User sees upcoming milestones with progress
3. User can view milestones by category:
   - Consistency (100 workouts, 1 year streak)
   - Volume (total reps/weight)
   - Skill (first pull-up, muscle-up progression)
   - Community (mentor status)

### Unlock Achievement

1. User meets skill stage requirement during workout
2. System automatically detects achievement
3. Achievement popup shown with celebration
4. User can share achievement (optional)

### View Achievement History

1. User navigates to Achievements
2. User sees chronological list of unlocks
3. User can see date and context of achievement
4. User can share past achievement

---

## Acceptance Criteria

### Skill Tracking

- All exercises have defined skill progression stages
- System detects when user meets stage requirement
- Stage progression is linear and irreversible
- User's skill level visible at all times
- Skill history preserved for reference

### Milestones

- Milestones trigger automatically on achievement
- Milestone date and context recorded
- Multiple milestones possible in one day
- Milestone categories clear and organized
- Milestone sharing available

### Progression

- Clear criteria for each skill stage
- Progress toward next stage visible
- Visual representation of progress (progress bar)
- Estimated time to next stage calculated
- Historical progression available

---

## Data Requirements

### Skill Entity

```
id (UUID)
name (string, unique)
category (enum: bodyweight, equipment, mobility, endurance, strength)
description (string)
exercise_id (UUID, foreign key)
stage_definitions (array of skill_stage_config)
related_exercises (array of exercise_ids)
```

### Skill Stage Config

```
id (UUID)
skill_id (UUID, foreign key)
stage_number (integer, 1-5+)
name (string, e.g., "Stage 1: Assisted")
description (string)
requirements (object)
  - min_reps: integer
  - min_sets: integer
  - min_frequency: string (e.g., "1x per week for 4 weeks")
  - prerequisite_stage: integer
unlock_reward_points (integer)
```

### User Skill Progress

```
id (UUID)
user_id (UUID, foreign key)
skill_id (UUID, foreign key)
current_stage (integer)
stage_unlocked_at (timestamp)
personal_record (object)
  - exercise_id: UUID
  - reps: integer
  - weight: decimal
  - achieved_at: timestamp
progression_history (array of stage_unlock_records)
```

### Milestone Entity

```
id (UUID)
name (string)
description (string)
category (enum: consistency, volume, skill, community)
trigger_type (enum: skill_unlock, workout_count, volume_total, streak_days)
trigger_config (object, varies by trigger_type)
reward_points (integer)
```

### User Milestone Unlock

```
id (UUID)
user_id (UUID, foreign key)
milestone_id (UUID, foreign key)
unlocked_at (timestamp)
shared (boolean, default false)
shared_at (timestamp, nullable)
```

---

## Edge Cases

- User achieves multiple skill stages in one workout - all unlock simultaneously, multiple celebrations
- User regresses in skill (fewer reps) - stage doesn't regress, only progression tracked
- User achieves milestone, logs out, logs back in - achievement still shown
- User manually corrects workout data then achieves skill - skill achievement updates if requirement now met
- User achieves same milestone twice (impossible with current design) - prevented by design

---

## MVP Scope (v1.0)

### Included

- 15-20 core skills with 5 stages each
- Automatic skill progression detection
- Skill detail views with stage requirements
- 30+ major milestones across categories
- Achievement celebrations with notifications
- Achievement history view
- Reward points system (for future use)
- Share achievements capability

### Not Included (v2.0+)

- Badges/visual representation beyond text
- Leaderboards by skill
- Skill decay (losing skill over time)
- Comparative skill stats
- Coach-defined custom milestones
- Seasonal challenges
- Achievement trading/gifting

---

## Future Enhancements

### v2.0 - Rich Achievements

- Badge/trophy visual system
- Leaderboards (anonymous, friend, regional)
- Social sharing optimized (Open Graph)
- Achievement unlocking parties (multiplayer)
- Custom milestone creation by users

### v3.0 - Deeper Recognition

- Mastery certificates
- Skill decay and retest system
- Historical comparative achievements
- Mentorship recognition
- Founder recognition for outliers

---

## Implementation Considerations

### Detection Logic

- Check skill requirements after each workout completion
- Batch process to avoid redundant checks
- Log all stage transitions for debugging
- Handle edge cases (duplicate checks, retroactive logic)

### Data Integrity

- Stage progression immutable once unlocked
- Milestone unlocks immutable
- Historical data preserved even if requirements change

### Personalization

- Skill recommendations based on current level
- Suggested next milestones based on trajectory
- Motivational messages for near-completion milestones

### Performance

- Skill calculations should not impact workout completion
- Run achievement detection asynchronously
- Cache skill requirements in app

---

## Skill Stage Examples

### Pull-Up Progression

- Stage 1: Dead hang (hold 5+ seconds)
- Stage 2: Negative pull-up (5+ reps controlled)
- Stage 3: Assisted pull-up (5+ reps with bands)
- Stage 4: Full pull-up (1+ rep unassisted)
- Stage 5: Multiple pull-ups (10+ reps unassisted)

### Push-Up Progression

- Stage 1: Wall push-up (20+ reps)
- Stage 2: Incline push-up (10+ reps)
- Stage 3: Knee push-up (10+ reps)
- Stage 4: Full push-up (5+ reps)
- Stage 5: Advanced push-up (10+ reps)

---

## Milestone Examples

- **Consistency**: 10 workouts, 50 workouts, 100 workouts, 1-year streak
- **Volume**: 10,000 total reps, 100,000 lbs lifted
- **Skills**: First pull-up, muscle-up unlock, 10 skills at Stage 4+
- **Community**: First mentor assist, 10 comments helping others
