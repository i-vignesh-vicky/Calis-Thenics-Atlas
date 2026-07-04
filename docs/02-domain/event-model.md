Excellent. This document is where many startups fail without realizing it.

Most teams document **features**.

Very few document the **rules** that govern those features.

Those rules are the real business.

---

# `02-domain/business-rules.md`

> **Purpose**
>
> Define the immutable business rules that govern how the platform behaves.
>
> These rules are independent of UI, database design, programming language, or implementation details.
>
> They represent the business contract that every system component must respect.

---

# Philosophy

Business rules answer one question:

> **"What must always be true?"**

Unlike features, business rules rarely change.

For example:

Feature:

> Workout Logging

Business Rule:

> A completed workout must always belong to exactly one user.

Features evolve.

Business rules remain stable.

---

# Rule Categories

Business rules are grouped into:

1. User Rules
2. Routine Rules
3. Workout Rules
4. Program Rules
5. Skill Rules
6. Progress Rules
7. Recovery Rules
8. Community Rules
9. Challenge Rules
10. AI Rules (Future)

---

# 1. User Rules

### BR-001

Every user must have exactly one profile.

---

### BR-002

A user owns all personal fitness data.

Including:

* Workout history
* Progress
* Goals
* Recovery
* Preferences

No other user can modify these records.

---

### BR-003

Deleting a user must never silently remove historical business data without following the platform's data retention policy.

---

### BR-004

Every workout, routine, milestone, and achievement must be attributable to a single user.

---

# 2. Routine Rules

### BR-101

A routine may exist without ever being executed.

---

### BR-102

A routine must contain at least one exercise.

---

### BR-103

Exercises inside a routine have an explicit order.

The order must be preserved.

---

### BR-104

Editing a routine must never modify historical workouts created from it.

Historical records represent what actually happened.

---

### BR-105

Duplicating a routine creates a new independent routine.

Future edits must not affect the original.

---

# 3. Workout Rules

These are among the most important rules in the system.

---

### BR-201

A workout belongs to exactly one user.

---

### BR-202

A workout must contain at least one exercise.

---

### BR-203

An exercise must contain at least one recorded set.

---

### BR-204

Only completed workouts affect:

* Progress
* Statistics
* Recovery
* Streaks
* Personal Records
* AI recommendations

Draft workouts have no analytical value.

---

### BR-205

Completed workouts become historical records.

Editing should be limited to a short correction window or require explicit user intent.

---

### BR-206

Deleting a workout must trigger recalculation of all dependent metrics (e.g., progress trends, recovery estimates, personal records) or be prevented if consistency cannot be maintained.

---

### BR-207

Workout duration cannot be negative.

---

### BR-208

Workout timestamps must represent real chronological order.

A workout cannot finish before it starts.

---

# 4. Program Rules

### BR-301

A program contains one or more scheduled workouts.

---

### BR-302

Programs are versioned.

Updating a published program creates a new version rather than modifying existing user experiences.

---

### BR-303

Users retain their progress even if a program is later deprecated.

---

### BR-304

A user may stop following a program without losing completed workout history.

---

# 5. Skill Rules

### BR-401

A skill has one or more progression stages.

---

### BR-402

A user can only unlock a progression stage after satisfying its defined requirements.

(How those requirements are evaluated may evolve over time.)

---

### BR-403

Skill progress is independent of programs.

Users may train skills however they choose.

---

### BR-404

Unlocking a skill milestone is permanent.

---

# 6. Progress Rules

### BR-501

Progress is always evaluated relative to the user's historical performance.

The platform discourages unhealthy comparison with others.

---

### BR-502

Personal Records only update when performance exceeds the previous best.

Equal performance does not create a new PR.

---

### BR-503

Milestones are awarded once.

---

### BR-504

Statistics should be reproducible from historical workout data whenever possible.

Derived data must never become the single source of truth.

---

# 7. Recovery Rules

These rules become increasingly valuable as AI evolves.

---

### BR-601

Recovery is an estimate, not an absolute measurement.

The platform must communicate uncertainty where appropriate.

---

### BR-602

Recovery values remain within valid bounds (e.g., 0–100%).

---

### BR-603

Recovery calculations may evolve over time, but historical workout data must remain unchanged.

---

### BR-604

Future wearable integrations supplement recovery estimates; they do not overwrite workout history.

---

### BR-605

Muscle recovery is calculated independently for each muscle group.

---

# 8. Community Rules

### BR-701

Users own the content they create.

---

### BR-702

Deleting a post does not remove associated fitness achievements.

Achievements belong to the fitness journey, not the social feed.

---

### BR-703

Community interactions should promote encouragement rather than vanity.

Platform mechanics should favor meaningful engagement over popularity.

---

### BR-704

Community moderation must protect users from harassment, spam, and abuse.

---

# 9. Challenge Rules

### BR-801

A challenge has a defined start and end date.

---

### BR-802

Challenge progress is calculated using objective activity data rather than manual claims whenever possible.

---

### BR-803

Completed challenges become part of a user's long-term history.

---

### BR-804

Users may leave an active challenge, but completed achievements remain recorded.

---

# 10. AI Rules (Future)

These rules protect user trust.

---

### BR-901

AI provides recommendations, not commands.

The user remains in control of all decisions.

---

### BR-902

AI recommendations should explain their reasoning whenever practical.

Transparency builds trust.

---

### BR-903

AI must use the user's long-term context rather than isolated workouts.

---

### BR-904

The platform should never fabricate fitness data or conclusions.

If confidence is low, uncertainty should be communicated.

---

### BR-905

AI recommendations should prioritize long-term health over short-term performance.

---

# Cross-Domain Rules

These rules apply across the platform.

---

### BR-1001

Historical fitness data is never silently altered.

History is sacred.

---

### BR-1002

Derived analytics can always be recalculated from historical events.

---

### BR-1003

Every measurable achievement should be traceable to underlying evidence.

No "magic numbers."

---

### BR-1004

Every important user action should be timestamped.

---

### BR-1005

Every recommendation should be explainable.

---

### BR-1006

The platform rewards consistency more than intensity.

---

### BR-1007

Helping others is a recognized form of progress.

---

### BR-1008

The platform measures improvement before comparison.

---

### BR-1009

No user should feel punished for taking appropriate recovery or rest days.

Healthy behavior is rewarded.

---

### BR-1010

The platform exists to improve long-term health and performance, not maximize screen time.

Engagement is a means to healthier habits, not the primary objective.

---

# Rules That Should Never Be Broken

These are foundational principles.

* User data belongs to the user.
* Historical workouts are immutable records.
* Progress is measured against your past self.
* Recovery should always encourage sustainable training.
* AI supports rather than controls.
* Consistency is valued over perfection.
* Community exists to uplift rather than compare.
* Every recommendation must be grounded in evidence.
* Long-term health always takes priority over short-term performance.

---

# Technical Architect Review

This document does more than define behavior—it establishes the **ethical and product contract** of your platform.

A few rules stand out as strategic differentiators:

* **History is sacred.** Treat workouts as immutable facts. This enables trustworthy analytics and AI.
* **Derived data is disposable.** Progress charts, recovery scores, and summaries can always be recalculated from raw history, making the system resilient to future algorithm changes.
* **AI explains itself.** If users understand *why* a recommendation was made, they'll trust it more.
* **Consistency over intensity.** This aligns every feature—from streaks to leaderboards—with your vision of building healthier habits rather than addictive engagement.

With this document complete, the business behavior of the platform is well-defined. The next step, **`event-model.md`**, will describe how these business rules manifest as events flowing through the system. That document will be the bridge between the business domain and the eventual software architecture.
