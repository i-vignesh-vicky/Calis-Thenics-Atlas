# Database Design Guidelines

## Purpose

This document defines the database philosophy, modeling principles, conventions, and scalability strategy for Calis-Thenics-Atlas.

The database is not just persistent storage—it is the historical memory of every user's fitness journey. Every schema decision should preserve long-term analytical value and enable future AI capabilities.

**Core Belief:** Data is a competitive advantage. The database we build today enables the AI coach of tomorrow.

---

## Philosophy

### Data vs. Storage

Most applications store data. Calis-Thenics-Atlas **preserves fitness history**.

A workout logged today should still provide value ten years later. Every record should answer one of three questions:

1. **What happened?** (Facts)
2. **Why did it happen?** (Context)
3. **How can this help the user improve?** (Actionability)

If data cannot contribute to one of these goals, question whether it belongs in the system.

### Core Principles

1. **Data Integrity** — Correctness is non-negotiable
2. **Historical Preservation** — Never discard valuable history
3. **Extensibility** — Design for evolution
4. **Normalization** — Organize data logically (with intentional exceptions)
5. **Query Efficiency** — Support important access patterns
6. **Auditability** — Track important changes
7. **AI-Readiness** — Enable future insights and personalization

**Golden Rule:** Never sacrifice correctness for convenience.

---

## The Golden Rule: Prefer History Over Current State

**Rule:** Never store only current state when historical state has value.

### Bad Pattern
```
users.current_weight = 72kg
```

### Good Pattern
```
weight_entries (immutable history)
  72kg  -- today
  71kg  -- yesterday
  70kg  -- 2 days ago
  69kg  -- 3 days ago
```

Historical data enables:
- Progress tracking
- Trend analysis
- Pattern recognition
- AI recommendations
- User motivation and reflection

History is your competitive advantage.

---

## Core Data Categories

### 1. Identity & Profile

Relatively stable:
- `users` — Core user account
- `user_profiles` — Additional profile data
- `authentications` — Login methods (email, OAuth, etc.)
- `user_preferences` — Theme, notifications, language

### 2. Training Data

The core domain:
- `workouts` — Individual workout sessions
- `workout_exercises` — Exercises within a workout
- `workout_sets` — Sets within an exercise
- `workout_attempts` — Individual set attempts (reps, weight, duration)
- `exercises` — Exercise definitions and variations

### 3. Program & Routine Data

User's training structures:
- `programs` — Multi-week training programs
- `program_phases` — Phases within programs
- `routines` — Reusable workout templates
- `routine_exercises` — Exercises within routines

### 4. Progress & Achievement Data

Key for motivation and AI:
- `skills` — Abilities users can unlock (pull-ups, handstands, etc.)
- `skill_progress` — User's progression through skill levels
- `milestones` — Major achievement targets
- `milestone_achievements` — When user reaches milestones
- `consistency_streaks` — Consecutive days/weeks active
- `personal_records` — User's max weight, reps, time, etc.

### 5. Recovery & Health Data

Support for holistic coaching:
- `sleep_logs` — Daily sleep tracking
- `fatigue_ratings` — How tired user feels
- `soreness_logs` — Muscle soreness and location
- `readiness_scores` — Calculated readiness to train
- `injury_reports` — Injuries and their status

### 6. Community & Social Data

User interaction and motivation:
- `posts` — User-created content
- `comments` — Comments on posts
- `likes` — Reactions to content
- `follows` — User relationships
- `challenges` — Shared fitness challenges

### 7. Analytics & Insights

Derived, never manually edited:
- `weekly_stats` — Aggregated weekly data (volume, frequency, etc.)
- `monthly_stats` — Aggregated monthly data
- `progress_reports` — AI-generated progress summaries
- `ai_recommendations` — Personalized coaching suggestions

### 8. AI & Learning Data

Support for ML models:
- `ai_predictions` — Model predictions (recovery needs, etc.)
- `user_embeddings` — Vector representations (future)
- `training_insights` — Patterns discovered by AI
- `coaching_history` — What advice was given when

---

## Schema Design Principles

### 1. Normalize Business Entities

Business concepts should be properly normalized, not flattened into JSON.

**Bad:**
```json
{
  "workout": {
    "id": "123",
    "exercisesJson": "[{name, sets, reps}]"
  }
}
```

**Good:**
```
workouts
  ↓
workout_exercises
  ↓
workout_sets
  ↓
workout_attempts
```

Normalization preserves flexibility for future features and analysis.

### 2. Snapshot Historical Context (Intentional Duplication)

Some data should be intentionally duplicated for historical accuracy.

**Example:**

When a user completes a workout, store:
- The exercise ID (for relational queries)
- The exercise name **as it was that day** (for historical accuracy)

If the exercise library is renamed later, historical reports remain accurate.

**Principle:** Historical accuracy > Perfect normalization

### 3. Immutable History

Completed workouts should be mostly immutable.

- Users cannot silently edit past workouts
- Corrections are explicit (marked as corrections)
- History reflects reality, not revised reality

If a user logged 10 reps by mistake and meant 8:
```
workout_attempt
  recorded_reps: 10 (original)
  corrected_reps: 8 (correction marked with timestamp)
```

### 4. Avoid Storing Derived Data

Never permanently store values that can be reliably calculated.

**Bad:** Store `weekly_volume`, `total_prs`, `consistency_percentage` as columns

**Good:** Calculate on-demand OR materialize through controlled processes

Exception: Cache frequently-needed calculations in dedicated tables if performance demands it, but mark them as cached.

### 5. Audit Fields

Every table requires:

```sql
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
```

Where appropriate:

```sql
created_by UUID REFERENCES users(id)
updated_by UUID REFERENCES users(id)
deleted_at TIMESTAMP WITH TIME ZONE -- for soft deletes
```

### 6. Stable Identifiers (IDs)

Every entity uses stable, non-sequential identifiers.

**Preferred:** UUID v7 or ULID

**Why not sequential IDs:**
- Security exposure (predictable, can enumerate users)
- Difficult in distributed systems
- Difficult for data synchronization

### 7. Consistent Naming Conventions

**Tables:** `snake_case`, plural form
```
workout_sessions
exercise_categories
user_preferences
```

**Columns:** `snake_case`
```
created_at
user_id
workout_session_id
is_completed
```

**Foreign Keys:** `{entity}_id`
```
user_id (references users)
workout_id (references workouts)
```

Consistency matters more than aesthetic preferences.

### 8. Explicit Relationships

Use explicit foreign key constraints. Do not rely solely on application logic.

**Good:**
```sql
ALTER TABLE workout_exercises
ADD CONSTRAINT fk_workout_exercises_workout_id
FOREIGN KEY (workout_id) REFERENCES workouts(id);
```

Relationships communicate business meaning and provide database-level protection.

### 9. Enforce Business Rules at Database Level

Protect invariants with constraints where practical.

**Examples:**

```sql
-- Ensure workout has exercises
ALTER TABLE workouts
ADD CONSTRAINT check_workout_has_data
CHECK (exercise_count > 0);

-- Ensure progressive weight
ALTER TABLE workout_attempts
ADD CONSTRAINT check_valid_weight
CHECK (weight_kg >= 0);

-- Ensure valid attempts
ALTER TABLE workout_attempts
ADD CONSTRAINT check_valid_reps
CHECK (reps > 0 OR duration_seconds > 0);

-- User email is unique
ALTER TABLE users
ADD CONSTRAINT unique_email_per_user
UNIQUE(email);
```

The database should protect itself from invalid states.

### 10. Indexing Strategy

**Index these:**
- Foreign key columns
- Columns used in WHERE clauses
- Columns used in JOIN conditions
- Columns used for sorting (ORDER BY)
- Columns used for searching (LIKE, ILIKE)

**Don't over-index:**
- Indexes speed reads but slow writes
- Every index consumes disk space
- Profile before optimizing

**Example:**
```sql
-- Common queries for user's workouts
CREATE INDEX idx_workouts_user_id_created_at
ON workouts(user_id, created_at DESC);

-- Search by exercise type
CREATE INDEX idx_exercises_category
ON exercises(category);
```

### 11. JSON Usage (Use Sparingly)

JSON columns should be used selectively for:
- **Good candidates:**
  - Feature flags per user
  - Flexible preferences
  - AI metadata
  - External provider payloads
  - Complex preference hierarchies

- **Poor candidates:**
  - Core business entities
  - Data that needs frequent querying
  - Data that needs indexing
  - Data that should be audited column-by-column

**Principle:** Core entities stay relational. Edge cases can use JSON.

### 12. Time Handling

**All timestamps:**
- Stored in UTC
- Include timezone (TIMESTAMP WITH TIME ZONE)
- Formatted as ISO 8601

**Never:**
- Store local times without timezone
- Mix timezones
- Use integer timestamps

```sql
-- Correct
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()

-- Incorrect
created_at TIMESTAMP WITHOUT TIME ZONE
created_at BIGINT -- Unix timestamp
```

Users travel. Time must remain consistent and unambiguous.

---

## Important Concepts

### Historical Timeline

One of the platform's most valuable datasets is the user's timeline of events:

```
Workout Completed (2025-01-15)
  ↓
First Pull-up Unlocked (2025-02-03)
  ↓
100-Day Consistency Streak Reached (2025-04-15)
  ↓
Planche Skill Unlocked (2025-06-10)
  ↓
Personal Record: 405lb Deadlift (2025-07-22)
  ↓
Challenge Joined (2025-08-01)
```

This timeline serves:
- Progress visualization
- User motivation and pride
- AI pattern recognition
- Personal fitness narrative

Treat timeline events as first-class, queryable concepts.

### AI-Ready Data

Structured data produces better AI insights than free-form data.

**Bad:**
```
notes: "I felt okay today"
```

**Good:**
```
energy_level: 7 (1-10 scale)
sleep_hours: 8
soreness_location: chest
mood: motivated
```

Always prefer structured, categorical data over free-form text for AI features.

### Event-Based Thinking

Major business events should be capturable and queryable:

```
WorkoutCompleted
RoutineCreated
SkillUnlocked
MilestoneReached
RecoveryLogged
WeightUpdated
StreakContinued
ChallengeJoined
```

Events are valuable for:
- Analytics and dashboards
- AI coaching
- Notifications
- User engagement
- Auditing

---

## Implementation Decisions

### Soft Deletes

Use soft deletes only when recovery is valuable. Mark with `deleted_at`.

**Good candidates for soft delete:**
- User routines (user might restore)
- Community posts (user might undelete)
- Programs (user might return)

**Poor candidates for soft delete:**
- Workout sets (keep complete history)
- Exercise attempts (keep complete history)
- Milestones (immutable achievements)

**Principle:** Historical records usually stay permanent. Soft deletes for user-controlled content.

### Migrations

Every schema change must be:
- Version controlled (in code)
- Repeatable (runnable multiple times)
- Reversible (can rollback)
- Reviewed (peer review before prod)

**Never modify production databases manually.**

Use migration tools (EF Core migrations, Flyway, etc.) to track all changes.

### Backups

Database backups must be:
- ✓ Automated (daily minimum)
- ✓ Verified (restore tested regularly)
- ✓ Versioned (keep multiple versions)
- ✓ Encrypted (in transit and at rest)

Regular restore testing is as important as backups themselves.

---

## Scalability & Evolution

Design for gradual growth, not anticipatory overengineering.

### Phase 1: MVP
- Single PostgreSQL instance
- Standard indexes
- No sharding

### Phase 2: Growth (1M+ workouts)
- Read replicas for analytics
- Connection pooling
- Optimized indexes based on actual queries

### Phase 3: Scale (10M+ workouts)
- Partitioning large tables by user or time
- Time-series table for high-volume events
- Dedicated analytics database (data warehouse)

### Phase 4: Global Scale (100M+ users)
- Multi-region deployment
- Geographically distributed replicas
- Archive cold data to separate storage

**Principle:** Only introduce complexity when real, measured needs demand it.

---

## Data Retention Policy

**Default:** Keep user fitness history indefinitely unless:
- User explicitly requests deletion
- Legal requirements mandate deletion (GDPR, etc.)
- User account is permanently closed

**Rationale:** Historical fitness data becomes more valuable over time. A user's 10-year fitness journey tells a story that recent data alone cannot.

---

## Design Checklist

Before creating a new table, answer:

- ✓ Does this represent a real business concept?
- ✓ Will future AI benefit from this data?
- ✓ Is historical tracking needed?
- ✓ Should this be normalized or denormalized?
- ✓ Are relationships explicit?
- ✓ Are business constraints defined?
- ✓ Are necessary indexes identified?
- ✓ Can this schema evolve with the product?
- ✓ What queries will access this data?

If several answers are "no", reconsider the design before implementation.

---

## Guiding Principle

> **Collect data once. Use it forever.**

Imagine a user logs a workout today.

- **Today:** Helps them remember what they did
- **Next month:** Contributes to consistency tracking
- **Next year:** Powers recovery insights
- **Five years later:** AI recognizes patterns the user never noticed
- **Ten years later:** Becomes part of their lifelong fitness story

The same data continues creating value across decades.

That is the kind of platform we're building.

---

## The Bigger Picture

Many startups think their product is the app. It isn't.

The app is replaceable:
- UI will change
- Backend frameworks will evolve
- Platforms will emerge and decline

But **the data will remain**.

Companies like Strava, WHOOP, and MyFitnessPal are defensible competitors not just because of features, but because they possess years of high-quality user data.

Your long-term vision is an AI fitness companion that deeply understands each individual. That vision is only possible through disciplined database design that captures meaningful data and preserves it perfectly.

**Your database is not just storage. It is the memory of every athlete who trusts your platform.**
