# Progress and Consistency - Functional Requirements

## Feature Overview

Progress and Consistency transforms workout history into actionable insights. Users see their performance trends, consistency streaks, personal records, and progress visualization over time.

### Value Proposition

- Makes long-term progress visible
- Celebrates consistency
- Identifies trends and patterns
- Motivates continued commitment

---

## User Flows

### View Progress Dashboard

1. User navigates to Progress section
2. User sees dashboard with:
   - Current consistency streak
   - Weekly workout count
   - Monthly statistics
   - Recent PRs achieved

### View Workout History Timeline

1. User navigates to History
2. User sees chronological list of workouts (newest first)
3. User can filter by:
   - Date range
   - Exercise
   - Routine
   - Program
4. User taps workout to see full details

### View Exercise PRs

1. User navigates to Personal Records
2. User sees exercise with best performance recorded:
   - Most reps at weight
   - Heaviest weight achieved
   - Best RPE performance (e.g., heaviest at lower effort)
3. User taps exercise to see PR history

### View Progress Charts

1. User navigates to Analytics
2. User can view charts:
   - Volume over time (trending up/down)
   - Consistency (workouts per week)
   - Exercise frequency
   - Performance by exercise
3. User can select time period (4 weeks, 3 months, 6 months, all-time)
4. User can compare exercises or metrics

### Check Consistency Streak

1. User opens dashboard
2. User sees current streak days prominently displayed
3. User can see streak history (longest streak, current)
4. User can see streak on calendar

---

## Acceptance Criteria

### Consistency Tracking

- Streak calculated accurately (continuous workout days)
- Streak shows current and best streaks
- Calendar view shows workout days
- Missed day breaks streak but preserves history

### Personal Records

- System tracks all PRs per exercise
- PR history preserved and sortable
- PRs by weight, reps, or RPE
- Date of PR recorded
- Can view PR achieved date and workout context

### Progress Visualization

- Charts render accurately and smoothly
- Time period filters work correctly
- Data presented in understandable format
- Trends visible and interpretable

### Timeline

- Workout history complete and accurate
- Filters work independently
- Results sortable by date, exercise, program
- Can expand workout to see all sets/reps

---

## Data Requirements

### Consistency Streak

```
id (UUID)
user_id (UUID, foreign key)
current_streak_days (integer)
current_streak_started_at (timestamp)
longest_streak_days (integer)
longest_streak_started_at (timestamp)
last_workout_date (date)
```

### Personal Record

```
id (UUID)
user_id (UUID, foreign key)
exercise_id (UUID, foreign key)
record_type (enum: max_reps, max_weight, best_rpe_ratio)
value (decimal)
achieved_at (timestamp)
workout_session_id (UUID, foreign key, can reference historical data)
context (JSON, containing set details)
```

### Performance Metrics (Aggregated Daily)

```
id (UUID)
user_id (UUID, foreign key)
date (date, indexed)
total_workouts (integer)
total_volume (decimal, sum of reps × weight)
total_sets (integer)
total_reps (integer)
exercises_completed (array of exercise_ids)
average_rpe (decimal)
```

### Exercise Performance History

```
id (UUID)
user_id (UUID, foreign key)
exercise_id (UUID, foreign key)
date (date)
best_reps (integer)
best_weight (decimal)
total_sets (integer)
frequency (integer, times performed that day)
average_rpe (decimal)
```

---

## Edge Cases

- User logs out for 2 weeks then returns - streak broken but visible in history
- User edits past workout (changes date) - streak and PRs recalculated
- User deletes workout - streak potentially adjusted, history updated
- User logs impossible numbers (1000 reps) - still tracked, included in calculations
- User competes exercise at many different weights - PR system captures max weight
- User achieves same PR weight multiple times - timestamp of most recent shown

---

## MVP Scope (v1.0)

### Included

- Workout history with full filtering and search
- Consistency streak tracking (current and best)
- Personal records per exercise
- Basic stats dashboard (workouts this week/month)
- Volume calculations (total reps × weight)
- Timeline calendar showing workout days
- Exercise frequency tracking
- Performance charts (volume, consistency, exercise progression)
- Date range filtering for analytics

### Not Included (v2.0+)

- Advanced statistics (variance, trends)
- Predictive analytics (estimated next PR)
- Comparative stats (vs similar users)
- Advanced filtering (exercise combinations)
- Detailed failure rate analysis
- Body metrics correlation (weight, measurements)

---

## Future Enhancements

### v2.0 - Advanced Analytics

- Trend analysis (linear regression on volume)
- Predictive next PR estimation
- Performance correlations (which exercises correlate with improvements)
- Comparative leaderboards (anonymous, friend group)
- Export data functionality

### v3.0 - Coaching Integration

- AI coaching recommendations based on trends
- Automated program adjustments based on progress
- Predictive burnout warnings
- Recovery recommendations
- Training age comparison and advice

---

## Implementation Considerations

### Performance

- Streak calculation should be <100ms
- Chart rendering should be <500ms
- History list pagination for large datasets
- Cache analytics data nightly

### Data Integrity

- PRs recalculated if historical data modified
- Streaks recalculated if workout dates change
- Metrics aggregated nightly for consistency

### User Experience

- Celebrate milestones prominently
- Show trend direction (up/down arrows)
- Compare current to previous period
- Motivational messaging for positive trends

### Privacy

- All progress data user's own (no sharing defaults)
- User controls comparative stats visibility
- Historical data preserved for long-term view

---

## Analytics Data Points

For future AI personalization:
- Exercise progression rates
- Volume trends
- Consistency patterns
- Time of day preferences
- Rest day patterns
- Difficulty rating trends
- RPE correlation with volume
- Recovery patterns
