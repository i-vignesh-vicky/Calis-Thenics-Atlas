I completely agree with moving to this next.

In fact, I would argue this is **the single most important document** in Project Atlas.

Every successful long-term product has an excellent domain model.

* Strava's domain is Activities.
* MyFitnessPal's domain is Nutrition.
* WHOOP's domain is Recovery.
* GitHub's domain is Git.

For Atlas, our domain is **Human Fitness Progression**.

This document should not describe databases. It should describe **how we think about fitness**.

---

# `02-domain/domain-model.md`

````markdown
# Domain Model

> "Software should model reality as closely as possible."
>
> Atlas is not a workout tracker.
> Atlas models a person's lifelong fitness journey.

---

# Purpose

This document defines the core business domain of Atlas.

It identifies the primary business entities, their relationships, responsibilities, invariants, and lifecycle.

The domain model serves as the foundation for:

- Business logic
- Database design
- API design
- AI capabilities
- Analytics
- Future product evolution

Every engineering decision should align with this model.

---

# Domain Philosophy

Atlas models **people**, not workouts.

A workout is simply one event in a person's lifelong journey.

Everything ultimately exists to answer one question:

> "How is this person improving over time?"

That principle guides every domain decision.

---

# Core Aggregate Roots

The following aggregates own business consistency within the system.

## User

Represents a person using Atlas.

Responsibilities

- Identity
- Authentication
- Preferences
- Fitness profile
- Privacy settings
- Connected devices

Owns

- Workout History
- Programs
- Routines
- Skills
- Progress
- Social Identity

---

## Workout

Represents one completed training session.

Contains

- Exercises
- Sets
- Repetitions
- Duration
- Notes
- RPE
- Fatigue
- Completion Time

Business Rules

- Immutable after completion (except minor corrections)
- Cannot exist without an owner

---

## Routine

A reusable collection of exercises.

Purpose

Allows users to quickly repeat workouts.

Examples

Push Day

Leg Day

Pull Day

Upper Body

Custom Routine

---

## Program

A structured training plan.

Examples

Beginner Pull-Up

Front Lever

Muscle-Up

Handstand

Gym Strength

Fat Loss

Programs define long-term progression.

---

## Skill

Represents an athletic ability.

Examples

Push-up

Pull-up

Muscle-up

Planche

Front Lever

90° Press

Human Flag

Each skill has:

- Levels
- Progressions
- Prerequisites
- Milestones

---

## Challenge

Time-bound goals shared with others.

Examples

30 Push-Ups Daily

30-Day Handstand

10,000 Steps

Summer Challenge

---

## Social Profile

Represents a user's public fitness identity.

Contains

- Followers
- Following
- Posts
- Achievements
- Reputation
- Community statistics

---

# Supporting Entities

These exist within aggregate boundaries.

Exercise

Exercise Set

Exercise Category

Equipment

Muscle Group

Workout Exercise

Workout Set

Progress Record

Milestone

Body Measurement

Notification

Reminder

Achievement

Comment

Reaction

Media

Device Connection

Sleep Record

Recovery Record

Nutrition Record

Future AI Insight

---

# Value Objects

These have no identity.

Examples

Weight

Height

Body Fat %

Heart Rate

Duration

Calories

RPE

Sleep Score

Recovery Score

Nutrition Summary

Muscle Distribution

Goal Progress

These should be immutable.

---

# Domain Relationships

```text
User

├── Workouts

│      ├── Exercises

│      │      └── Sets

│      └── Notes

│

├── Programs

│      └── Routines

│              └── Exercises

│

├── Skills

│      ├── Progress

│      └── Milestones

│

├── Progress Timeline

│

├── Challenges

│

├── Social Profile

│      ├── Posts

│      ├── Comments

│      └── Followers

│

└── AI Profile
````

---

# Core Business Concepts

## Consistency

One of Atlas's most important concepts.

Not merely:

Workout count

Instead:

Consistency measures sustainable adherence over time.

Examples

Training Frequency

Habit Formation

Recovery Compliance

Missed Sessions

Weekly Rhythm

---

## Progress

Progress is multidimensional.

Atlas recognizes:

Strength

Skills

Endurance

Mobility

Recovery

Body Composition

Discipline

Knowledge

Future AI should evaluate progress holistically rather than relying on a single metric.

---

## Fatigue

Fatigue represents accumulated training stress.

Initially user-reported.

Future versions may infer fatigue using:

* Recent workload
* Sleep
* Recovery
* Heart rate
* Wearables
* AI predictions

---

## Recovery

Recovery is first-class.

Not an afterthought.

Includes

Sleep

Rest Days

Injury

Mobility

Deload Weeks

Recovery Quality

---

## Reputation

Atlas rewards positive community behavior.

Reputation comes from:

Helping others

Consistency

Mentoring

Constructive participation

Knowledge sharing

Not popularity alone.

---

# Domain Events

Examples

WorkoutCompleted

WorkoutSkipped

RoutineCreated

SkillUnlocked

MilestoneReached

ChallengeJoined

ChallengeCompleted

WorkoutShared

CommentAdded

RecoveryUpdated

SleepLogged

BodyMeasurementRecorded

AIInsightGenerated

Future systems may react to these events asynchronously.

---

# Business Invariants

A Workout must belong to exactly one User.

A Set cannot exist without an Exercise.

A Routine contains at least one Exercise.

Programs define ordered progression.

Skills may require prerequisite skills.

Achievements cannot be manually awarded.

Historical workout records should not be deleted silently.

Business rules belong in the domain—not controllers or UI.

---

# Bounded Contexts

Atlas naturally separates into bounded contexts.

Authentication

User Profile

Workout Tracking

Exercise Library

Programs

Skills

Progress

Community

Challenges

Notifications

Analytics

AI Coaching

Administration

These contexts should remain loosely coupled.

---

# Future Domain Expansion

The domain is intentionally extensible.

Future additions include:

Nutrition

Recovery Intelligence

Wearable Integration

Coach Marketplace

Local Competitions

Fitness Reputation

Fitness Score

Biomechanics

Movement Analysis

AI Coaching

Injury Prediction

Exercise Recognition

Video Analysis

Personal Knowledge Graph

---

# Guiding Principle

Atlas does not model workouts.

Atlas models **human improvement**.

Every entity, relationship, business rule, and future feature should ultimately contribute toward understanding how a person becomes healthier, stronger, more capable, and more consistent throughout their lifetime.

```

---

# Why I intentionally modeled it this way

Notice something important.

Most fitness apps center their domain around:

```

Workout

↓

Exercise

↓

Set

```

That's it.

Atlas is different.

Our center is:

```

```
             User

               │

  ┌────────────┼────────────┐

  │            │            │
```

Progress      Consistency   Recovery

```
  │            │            │

  └────────────┼────────────┘

               │

           Workouts

               │

           Exercises

               │

              Sets
```

```

The workout is **evidence** of progress—not the product itself.

That aligns directly with your vision:

> "I don't want to build a workout app. I want to build the companion that helps people become better versions of themselves."

This domain model will make future features like AI coaching, adaptive programming, habit formation, mentorship, and holistic fitness scoring feel like natural extensions instead of disconnected additions. It gives Atlas a foundation that can support your long-term vision without requiring a fundamental redesign later.
```
