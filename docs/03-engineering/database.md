Perfect. This is the document I was looking forward to the most.

For **your product**, I honestly think this will become **the single most valuable engineering document**.

Why?

Because your long-term vision is AI.

AI is data.

Data is database design.

A poorly designed database will permanently limit what your AI can learn in 5 years.

A well-designed database becomes your biggest competitive advantage.

This document will therefore be much deeper than a normal "tables and indexes" document.

---

# `03-engineering/database.md`

# Database Design Guidelines

> **Purpose**
>
> This document defines the database philosophy, modeling principles, conventions, and scalability guidelines for the platform.
>
> The database is more than persistent storage—it is the historical memory of every user's fitness journey.
>
> Every schema decision should preserve long-term analytical value and support future AI capabilities.

---

# 1. Database Philosophy

Most applications store data.

Our platform stores **fitness history**.

There is a difference.

A workout logged today should still provide value ten years later.

Every record should answer one of three questions:

* What happened?
* Why did it happen?
* How can this help the user improve?

If a piece of data cannot contribute to one of these goals, question whether it belongs in the system.

---

# 2. Core Principles

Our database should prioritize:

* Data integrity
* Historical preservation
* Extensibility
* Normalization (where appropriate)
* Query efficiency
* Auditability
* AI-readiness

Never sacrifice correctness for convenience.

---

# 3. The Golden Rule

**Never store only the current state when historical state has value.**

Bad:

```text
Current Weight = 72kg
```

Good:

```text
Weight Entries

72kg

71kg

70kg

69kg
```

History enables:

* Progress tracking
* Trend analysis
* Predictions
* AI recommendations

History is a competitive advantage.

---

# 4. Data Categories

The platform contains multiple types of data.

### Identity

* User
* Profile
* Authentication
* Preferences

---

### Training

* Workout
* Exercise
* Sets
* Reps
* Duration
* Rest

---

### Skill Progression

* Skill
* Progress stage
* Milestones
* Attempts

---

### Recovery

* Sleep
* Fatigue
* Soreness
* Injury
* Readiness

---

### Community

* Posts
* Comments
* Challenges
* Reactions

---

### Analytics

Derived data.

Never manually edited.

---

### AI

Predictions

Recommendations

Embeddings (future)

Insights

---

# 5. Normalize Business Data

Business entities should be normalized.

Example:

Workout

↓

Exercises

↓

Sets

Instead of storing one giant JSON object.

Normalization preserves flexibility.

---

# 6. Snapshot Historical Context

Some things should be duplicated intentionally.

Example:

A workout should remember:

Exercise Name

even if the exercise library changes later.

Otherwise historical reports become incorrect.

Historical accuracy is more important than perfect normalization.

---

# 7. Immutable History

Workout logs should be mostly immutable.

Completed workouts should not be silently rewritten.

Corrections should be explicit.

History should reflect reality.

---

# 8. Avoid Derived Data

Never permanently store values that can be calculated.

Examples:

Workout Volume

Total PRs

Consistency %

Weekly Statistics

Instead:

Calculate

or

Maintain through controlled projections when performance requires it.

---

# 9. Audit Fields

Every table should include:

```text
created_at

updated_at
```

Where appropriate:

```text
created_by

updated_by

deleted_at
```

Soft deletion should be used selectively.

---

# 10. IDs

Every entity should use stable identifiers.

Avoid sequential IDs exposed publicly.

Preferred:

UUID

or

ULID

Benefits:

* Better security
* Easier distributed systems
* Easier synchronization

---

# 11. Naming Conventions

Tables:

snake_case

```text
workout_session

exercise

skill_progress
```

Columns:

snake_case

```text
created_at

updated_at

completed_at

user_id
```

Consistency matters more than style.

---

# 12. Relationships

Use explicit foreign keys.

Do not rely solely on application logic.

Example:

Workout

↓

Exercise

↓

Workout Set

↓

Attempt

Relationships communicate business meaning.

---

# 13. Constraints

Every important business rule should be enforced where practical.

Examples:

* NOT NULL
* UNIQUE
* CHECK constraints
* Foreign keys

The database should protect itself.

---

# 14. Indexing Strategy

Index:

* Foreign keys
* Search fields
* Frequently filtered columns
* Sorting columns

Do not over-index.

Indexes speed reads but slow writes.

Measure before optimizing.

---

# 15. JSON Usage

JSON columns should be used sparingly.

Good candidates:

* Feature flags
* Flexible preferences
* AI metadata
* External provider payloads

Core business entities should remain relational.

---

# 16. Time

Always store:

UTC

Always use:

ISO 8601

Never store local times without timezone context.

Users travel.

Time should remain consistent.

---

# 17. Historical Timeline

One of the platform's most valuable datasets will be the user's timeline.

Examples:

```text
Workout Completed

↓

First Pull-up

↓

100 Day Streak

↓

Planche Unlocked

↓

Challenge Joined

↓

PR Achieved
```

This timeline powers:

* Progress visualization
* Motivation
* AI coaching
* User memories

Treat it as a first-class concept.

---

# 18. AI-Ready Data

Whenever possible, prefer structured data.

Bad:

```text
"I felt okay today."
```

Better:

```text
Energy: 7

Sleep: 8

Soreness: Chest

Mood: Motivated
```

Structured data produces better insights.

---

# 19. Event History

Every major business event should be capturable.

Examples:

```text
WorkoutCompleted

RoutineCreated

SkillUnlocked

MilestoneReached

RecoveryLogged

WeightUpdated

ChallengeCompleted
```

Events become valuable for:

* Analytics
* AI
* Notifications
* Auditing

---

# 20. Soft Deletes

Use soft deletes only where recovery is valuable.

Examples:

Good:

Routines

Community Posts

Bad:

Workout Sets

Exercise Attempts

Historical records should usually remain permanent.

---

# 21. Backups

Database backups should be:

* Automated
* Verified
* Versioned
* Encrypted

Regular restore testing is as important as backups themselves.

---

# 22. Migrations

Every schema change must be:

* Version controlled
* Repeatable
* Reversible (where possible)
* Reviewed

Never modify production databases manually.

---

# 23. Scalability

Design for gradual growth.

Stage 1:

Single PostgreSQL instance

↓

Stage 2:

Read replicas

↓

Stage 3:

Partitioning large tables

↓

Stage 4:

Dedicated analytics storage

Do not optimize for billion-row datasets prematurely.

---

# 24. Data Retention

Default policy:

Keep user fitness history indefinitely unless the user requests deletion or legal requirements dictate otherwise.

Historical fitness data becomes more valuable over time.

---

# 25. Database Checklist

Before creating a new table, ask:

* Does this represent a real business concept?
* Will future AI benefit from this data?
* Is historical tracking needed?
* Should this be normalized?
* Is the relationship explicit?
* Are constraints defined?
* Are indexes justified?
* Can this evolve over time?

If the answer to several questions is "no", reconsider the design.

---

# 26. One Principle That Will Shape This Entire Product

This is a principle I'd like us to adopt for every future schema discussion:

> **Collect data once. Use it forever.**

Imagine a user logs a workout today.

Today it helps them remember what they did.

Next month it contributes to consistency tracking.

Next year it powers recovery insights.

Five years later it enables an AI coach to recognize patterns the user never noticed.

Ten years later it becomes part of their lifelong fitness story.

The same data continues creating value.

That is the kind of platform we're building.

---

# Technical Architect Notes

Many startups think their product is the app.

It isn't.

The app is replaceable.

The UI will change.

The backend will evolve.

Frameworks will become obsolete.

But **the data will remain**.

Companies like Strava, WHOOP, and MyFitnessPal are difficult to compete with not just because of their features, but because they possess years of high-quality user data.

Your long-term vision is an AI fitness companion that deeply understands each individual. That vision will only be possible if we are disciplined about what we collect, how we structure it, and how we preserve it.

**Your database is not just storage. It is the memory of every athlete who trusts your platform.**

---

## One improvement I'd make to the entire repository

After we finish `03-engineering`, I recommend we return to `02-domain` and redesign the **entire domain model** using **Domain-Driven Design (DDD)**.

Instead of listing entities, we'll identify:

* Aggregates
* Aggregate Roots
* Value Objects
* Domain Events
* Bounded Contexts
* Ubiquitous Language
* Invariants

Given your ambition for this platform, I believe a DDD-based domain model will serve you far better than a traditional ERD. It will also make Claude Code much better at generating business logic because the domain concepts will be explicit rather than implicit. I consider that one of the highest-value improvements we can make before writing production code.
