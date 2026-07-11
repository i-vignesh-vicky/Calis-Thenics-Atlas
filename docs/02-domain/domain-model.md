# Domain Model

## Purpose

Define the core business model that drives product behavior, data ownership, and future extensibility.

## Domain Center

Atlas models long-term human improvement, not isolated workouts.

## Intent Guardrail

Workout data is evidence, not the product itself. The product is the user's long-term progression across capability, consistency, recovery, and confidence.

## Aggregate Roots

### User

Owns identity, profile, goals, preferences, and personal fitness history.

### Workout

Represents one completed training event with immutable historical value.

### Routine

Represents reusable planned structure for workouts.

### Program

Represents sequenced training intent across time.

### Skill

Represents capability progression with stages and milestone events.

### Challenge

Represents time-bound participation with measurable completion criteria.

## Key Supporting Entities

- Exercise
- WorkoutExercise
- WorkoutSet
- ProgressRecord
- MilestoneAchievement
- RecoveryRecord
- BodyMeasurement
- CommunityPost
- Comment
- Notification

## Value Objects

- Duration
- Weight
- RepetitionCount
- RPE
- RecoveryScore
- DateRange

Value objects should be immutable.

## Core Relationships

- User owns workouts, routines, programs, skills, and progress records.
- Workout contains workout exercises and sets.
- Routine references ordered exercises.
- Program references routine schedule and progression sequence.
- Skill references progression stages and milestone evidence.

## Invariants

- Workout must belong to exactly one user.
- Completed workout cannot have zero exercises.
- Workout set cannot exist without parent workout exercise.
- Routine cannot exist without at least one exercise.
- Milestone award requires evidence from historical records.

## Historical Integrity Principle

Historical workout records are the source of truth. Derived views, scores, and analytics are replaceable and must be reproducible from history.

## Bounded Contexts

- Identity
- Training
- Progress
- Recovery
- Community
- Challenges
- Notifications
- AI Coaching
