# Event Model

## Purpose

Define domain events that represent meaningful business facts and support analytics, automation, and AI services.

## Event Principles

1. Events represent facts that happened.
2. Event names use past tense.
3. Events are append-only and timestamped.
4. Derived views can be rebuilt from event history.

## Core Event Categories

### Identity Events

- UserRegistered
- UserProfileUpdated
- UserGoalUpdated

### Training Events

- RoutineCreated
- RoutineUpdated
- WorkoutSessionStarted
- WorkoutSessionPaused
- WorkoutSessionResumed
- WorkoutCompleted
- WorkoutCorrected

### Skill and Progress Events

- SkillStageUnlocked
- MilestoneReached
- PersonalRecordUpdated
- StreakUpdated

### Recovery Events

- RecoveryLogged
- RecoveryScoreCalculated

### Community Events

- CommunityPostPublished
- CommentAdded
- ChallengeJoined
- ChallengeCompleted

### AI Events

- RecommendationGenerated
- RecommendationAccepted
- RecommendationDismissed

## Event Envelope (Standard)

Every event includes:

- eventId
- eventType
- occurredAtUtc
- userId
- aggregateId
- payload
- correlationId
- causationId

## Processing Model

- Synchronous handling for critical transactional integrity where needed.
- Asynchronous handling for analytics, notifications, and AI pipelines.
- Idempotent consumers required.
