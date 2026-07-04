Excellent. We now begin what I consider the **single most important document in the entire repository**.

Everything else—database, APIs, backend, frontend, AI, analytics—will derive from this.

---

# `02-domain/ubiquitous-language.md`

This document defines the language of the product.

> **Rule:** Every developer, designer, QA engineer, product manager, AI agent, and founder must use these definitions consistently. If two people use the same word, they must mean the same thing.

---

# Ubiquitous Language

## Purpose

The product aims to become a long-term fitness ecosystem spanning training, progression, recovery, coaching, community, and AI. To avoid ambiguity as the platform grows, this document establishes a shared vocabulary used across product discussions, engineering, documentation, APIs, analytics, and AI models.

Whenever a term in this document conflicts with an implementation detail, **the business definition takes precedence**.

---

# Core User Concepts

## User

A person who uses the platform to improve their fitness.

A user is the central entity of the system.

A user may:

* Create routines
* Follow programs
* Complete workouts
* Track skills
* Participate in challenges
* Publish community posts
* Build streaks
* Earn milestones
* Receive AI coaching
* Help other users

A user is **not** defined by their fitness level. Beginners, intermediates, and elite athletes are treated equally.

---

## Athlete

A user actively pursuing measurable fitness improvement.

The application may internally treat all active users as athletes because the platform values progress over labels.

"Athlete" represents a mindset rather than competitive status.

---

## Coach

A qualified individual who creates programs or guides other users.

Coaches may eventually:

* Publish training programs
* Earn revenue
* Review technique
* Build communities
* Mentor users

This role is part of the future vision and is not required for the MVP.

---

# Training Concepts

## Exercise

The smallest unit of training.

Examples:

* Pull-up
* Push-up
* Squat
* Deadlift
* Handstand Hold
* Planche Lean

An exercise describes **what movement is performed**, not the user's performance.

Exercises contain metadata such as:

* Primary muscles
* Secondary muscles
* Equipment
* Difficulty
* Exercise type
* Movement pattern

Exercises are reusable across routines, workouts, and programs.

---

## Exercise Set

A single performance of an exercise.

Examples:

* 10 Pull-ups
* 20 Push-ups
* 60-second plank
* 5 reps @ 80 kg squat

A set contains performance data rather than exercise metadata.

Possible attributes include:

* Repetitions
* Weight
* Duration
* Distance
* Assistance level
* RPE
* Rest time
* Notes

---

## Workout

A single completed training session.

A workout consists of one or more exercise sets performed within a period of time.

A workout represents an actual event that occurred.

Example:

Monday Evening Push Workout

Exercises:

* Dips
* Push-ups
* Pike Push-ups

Once completed, a workout becomes immutable historical data, except for limited editing within a defined correction window.

---

## Workout Session

The active state while a workout is being performed.

Lifecycle:

Draft

↓

Started

↓

Paused

↓

Resumed

↓

Completed

↓

Archived

This distinction allows features such as autosave, timers, interruptions, and crash recovery.

---

## Routine

A reusable workout template created by a user.

Unlike a workout, a routine contains planned exercises rather than completed performance.

Example:

Push Day Routine

Exercises:

* Dips
* Incline Push-ups
* Pike Push-ups

A routine can be reused indefinitely.

---

## Program

A structured collection of workouts organized toward a specific goal over time.

Examples:

* Beginner Calisthenics
* Muscle-Up Program
* 12-Week Hypertrophy
* Fat Loss Program

A program defines progression rather than a single workout.

Programs may include:

* Weeks
* Phases
* Deloads
* Rest days
* Progression rules

---

# Skill Concepts

## Skill

A measurable physical ability requiring progressive mastery.

Examples:

* Pull-up
* Handstand
* Muscle-up
* Front Lever
* Planche
* Human Flag

Skills represent capabilities rather than exercises.

A skill usually has multiple progression stages.

---

## Skill Progression

The ordered sequence of steps leading toward mastery of a skill.

Example:

Muscle-Up

↓

Explosive Pull-up

↓

Chest-to-Bar

↓

Band Muscle-Up

↓

Negative Muscle-Up

↓

Strict Muscle-Up

↓

Weighted Muscle-Up

Progression enables adaptive recommendations.

---

## Skill Level

Represents the user's current capability for a specific skill.

Example:

Handstand

Current Level:

Wall Handstand Hold

Future Goal:

Freestanding Handstand

Skill levels evolve over time.

---

# Performance Concepts

## Personal Record (PR)

The user's best historical performance for a measurable activity.

Examples:

Most Pull-ups

Longest Handstand

Heaviest Squat

Fastest 5 km

Highest Box Jump

A PR represents improvement, not comparison.

---

## Milestone

A meaningful achievement reached by the user.

Examples:

First Pull-up

100 Workouts

365-Day Streak

First Muscle-Up

10 km Run

Milestones celebrate progress rather than competition.

---

## Progress

Any measurable improvement over time.

Progress may include:

* Increased strength
* Improved endurance
* Better mobility
* Weight change
* Skill advancement
* Consistency
* Recovery quality

Progress is always evaluated relative to the user's past self.

---

# Recovery Concepts

## Recovery

An estimation of the body's readiness for future training.

Recovery is influenced by:

* Recent workouts
* Muscle fatigue
* Sleep
* Training volume
* Nutrition
* Rest days

Initially, recovery may be estimated from workout history alone.

Future versions may incorporate wearable devices and AI.

---

## Muscle Recovery

Recovery estimated for individual muscle groups.

Example:

Chest: 90%

Back: 35%

Shoulders: 50%

This enables intelligent workout recommendations.

---

## Fatigue

The accumulated physiological and muscular stress resulting from training.

Fatigue is temporary.

Fatigue influences recovery but is not identical to it.

---

## Readiness

An estimation of how prepared a user is to perform a workout today.

Future AI recommendations may use readiness to adapt training intensity.

---

# Consistency Concepts

## Streak

A continuous sequence of successful behavior.

Examples:

Workout streak

Sleep streak

Protein streak

Recovery streak

The platform values healthy consistency over perfection.

---

## Habit

A repeated behavior performed consistently over time.

Examples:

Morning stretching

Drinking water

Sleeping before 11 PM

Daily walking

Habits extend beyond workouts and reinforce the platform's philosophy that fitness is a lifestyle.

---

# Community Concepts

## Community Post

Content shared by users.

Posts may include:

* Workout summaries
* Progress updates
* Skill achievements
* Questions
* Educational content
* Transformation stories

The platform emphasizes meaningful contributions over vanity metrics.

---

## Challenge

A time-bound objective completed individually or with others.

Examples:

30 Push-ups Daily

7-Day Mobility Challenge

100 km Running Challenge

Challenges encourage consistency and accountability.

---

## Leaderboard

A ranking based on defined criteria.

Leaderboards may exist for:

* Local communities
* Friends
* Challenges
* Skill achievements

Future leaderboards should prioritize improvement and participation over raw ability to avoid discouraging beginners.

---

## Mentor

An experienced user recognized for helping others.

Mentorship is earned through positive contribution rather than popularity.

Future AI systems may recommend mentors to newer users.

---

# AI Concepts

## AI Coach

An intelligent assistant that understands the user's fitness journey and provides personalized guidance.

Unlike traditional fitness apps, the AI Coach does not simply generate workouts. It uses long-term context—including training history, recovery, goals, consistency, and progress—to support better decisions.

---

## Fitness Profile

The complete, evolving representation of a user's fitness.

It may include:

* Training history
* Skills
* Strength
* Mobility
* Endurance
* Recovery
* Injuries
* Goals
* Preferences
* Consistency
* Community participation

This profile forms the foundation for future personalization.

---

## Fit Score *(Future)*

A holistic representation of a user's overall fitness.

Unlike simplistic scores, the Fit Score considers:

* Age
* Goals
* Training consistency
* Strength
* Endurance
* Mobility
* Recovery
* Progress over time

The score is designed to reflect personal growth rather than absolute performance.

---

# Guiding Principle

Every feature, API, database table, analytics event, and AI model should use the terminology defined in this document. If new concepts are introduced, they should be added here first before being implemented elsewhere. Maintaining a consistent language across the organization reduces ambiguity, improves communication, and ensures that the software continues to model the real-world fitness domain accurately as the platform evolves.

---

## Technical Architect Review

This document is intentionally **business-focused**, not technical. You'll notice there is **no mention of tables, entities, DTOs, APIs, or classes**. That's deliberate.

When we move to **`domain-model.md`**, we'll take these concepts and identify:

* Aggregate Roots
* Value Objects
* Relationships
* Ownership
* Lifecycle
* Domain boundaries

That document will become the blueprint for your backend architecture and database design. In my opinion, it's the most important technical document we'll create for the MVP.
