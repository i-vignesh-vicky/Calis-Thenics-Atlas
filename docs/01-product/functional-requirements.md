# Functional Requirements

This document will capture the functional requirements for the system.
I think we should **not** dump 200 requirements into one document. That becomes unreadable and difficult to maintain.

Instead, let's build it like a real Product Requirements Specification (PRS). This is how I'd expect it in a company building a product intended to last for years.

---

# `docs/01-product/functional-requirements.md`

```markdown
# Functional Requirements

**Document Version:** 1.0  
**Status:** Draft  
**Owner:** Product & Engineering  
**Last Updated:** TBD

---

# 1. Purpose

This document defines the functional requirements for the MVP of Project Atlas.

The goal of these requirements is to clearly specify **what the platform must do**, independent of implementation details.

These requirements serve as the source of truth for engineering, design, QA, and future AI-assisted development.

---

# 2. Scope

This document covers the Tier 1 MVP.

The MVP focuses on enabling users to:

- Follow structured workout programs
- Create fully customizable routines
- Log workouts efficiently
- Track skills and milestones
- Visualize progress
- Build consistency
- Participate in a lightweight community

Future AI capabilities, advanced analytics, wearable integrations, recovery intelligence, and adaptive coaching are intentionally excluded from this version unless explicitly stated.

---

# 3. Functional Areas

| ID | Module |
|------|---------------------------|
| FA-01 | Authentication & User Management |
| FA-02 | User Profile |
| FA-03 | Goals |
| FA-04 | Workout Library |
| FA-05 | Programs |
| FA-06 | Routine Builder |
| FA-07 | Workout Execution |
| FA-08 | Workout Logging |
| FA-09 | Skill Tracking |
| FA-10 | Milestones |
| FA-11 | Progress Tracking |
| FA-12 | Consistency Tracking |
| FA-13 | Community |
| FA-14 | Social Feed |
| FA-15 | Challenges |
| FA-16 | Search |
| FA-17 | Notifications |
| FA-18 | Settings |

---

# FA-01 Authentication & User Management

## Purpose

Provide secure access to the platform while keeping onboarding friction as low as possible.

---

### Requirements

### FR-AUTH-001

The system shall allow users to register using email.

---

### FR-AUTH-002

The system shall support secure login.

---

### FR-AUTH-003

The system shall support password reset.

---

### FR-AUTH-004

The system shall persist user sessions.

---

### FR-AUTH-005

The system shall support logout from active sessions.

---

### FR-AUTH-006

The system shall require email verification before enabling community features.

---

### FR-AUTH-007

The system shall prevent duplicate accounts using the same email.

---

### FR-AUTH-008

The system shall securely hash all passwords.

---

# FA-02 User Profile

Purpose

Represent the athlete rather than just an account.

---

### FR-PROFILE-001

Users shall have a public profile.

---

### FR-PROFILE-002

Users shall upload a profile picture.

---

### FR-PROFILE-003

Users shall update:

- Name
- Bio
- Gender
- Date of Birth
- Height
- Weight

---

### FR-PROFILE-004

Users shall configure training experience.

Examples:

- Beginner
- Intermediate
- Advanced

---

### FR-PROFILE-005

Users shall define primary fitness interests.

Examples:

- Calisthenics
- Gym
- Running
- Yoga

---

### FR-PROFILE-006

The system shall maintain profile history where applicable.

---

# FA-03 Goals

Purpose

Capture why the user is training.

---

### FR-GOAL-001

Users shall create one or more fitness goals.

Examples

- Learn Muscle Up

- Lose Fat

- Build Muscle

- Improve Mobility

---

### FR-GOAL-002

Users shall define target completion dates.

---

### FR-GOAL-003

Users shall archive completed goals.

---

### FR-GOAL-004

The system shall allow users to modify goals.

---

# FA-04 Workout Library

Purpose

Provide structured exercises.

---

### FR-LIB-001

The system shall provide categorized exercises.

---

### FR-LIB-002

Exercises shall contain:

- Instructions
- Muscles worked
- Equipment
- Difficulty

---

### FR-LIB-003

Exercises shall support videos.

---

### FR-LIB-004

Exercises shall support images.

---

### FR-LIB-005

Users shall search exercises.

---

### FR-LIB-006

Users shall filter exercises.

---

# FA-05 Programs

Purpose

Provide structured learning paths.

---

### FR-PROGRAM-001

Users shall browse available programs.

---

### FR-PROGRAM-002

Programs shall define:

- Duration
- Difficulty
- Goal
- Equipment

---

### FR-PROGRAM-003

Users shall enroll in a program.

---

### FR-PROGRAM-004

Users shall pause a program.

---

### FR-PROGRAM-005

Users shall resume programs.

---

### FR-PROGRAM-006

The system shall track program completion.

---

# FA-06 Routine Builder

Purpose

Allow unlimited workout customization.

---

### FR-ROUTINE-001

Users shall create custom routines.

---

### FR-ROUTINE-002

Users shall edit routines.

---

### FR-ROUTINE-003

Users shall duplicate routines.

---

### FR-ROUTINE-004

Users shall archive routines.

---

### FR-ROUTINE-005

Users shall reorder exercises.

---

### FR-ROUTINE-006

Users shall define

- Sets
- Reps
- Duration
- Rest
- Notes

per exercise.

---

### FR-ROUTINE-007

Users shall organize routines into folders.

---

# FA-07 Workout Execution

Purpose

Provide a distraction-free workout experience.

---

### FR-WORKOUT-001

Users shall start workouts.

---

### FR-WORKOUT-002

Users shall pause workouts.

---

### FR-WORKOUT-003

Users shall resume workouts.

---

### FR-WORKOUT-004

Users shall finish workouts.

---

### FR-WORKOUT-005

The system shall record workout duration.

---

### FR-WORKOUT-006

The system shall record exercise completion.

---

### FR-WORKOUT-007

Users shall modify performed reps.

---

### FR-WORKOUT-008

Users shall modify performed weight.

---

### FR-WORKOUT-009

Users shall modify rest duration.

---

### FR-WORKOUT-010

The system shall support workout notes.

---

### FR-WORKOUT-011

The system shall support perceived difficulty (RPE).

---

### FR-WORKOUT-012

The system shall automatically save workout progress.

---

# FA-08 Workout Logging

Purpose

Capture historical workout data.

Requirements include:

- Workout history
- Exercise history
- Set history
- PR detection
- Volume calculation
- Time calculation
- Calendar history
- Editing completed workouts

---

# FA-09 Skill Tracking

Purpose

Track bodyweight skill progression.

Requirements include:

- Skills
- Progressions
- Skill status
- Target skill
- Progress percentage
- Unlock history
- Practice frequency

---

# FA-10 Milestones

Purpose

Celebrate meaningful achievements.

Requirements include:

- First Pull-up
- First Muscle Up
- Handstand
- Front Lever
- Planche
- Workout milestones
- Consistency milestones

---

# FA-11 Progress Tracking

Purpose

Help users understand improvement.

Requirements include:

- Weight history
- Strength history
- Skill timeline
- PR timeline
- Workout history
- Charts
- Monthly summaries

---

# FA-12 Consistency Tracking

Purpose

Reward long-term discipline.

Requirements include:

- Workout streaks
- Weekly streaks
- Monthly streaks
- Active days
- Calendar
- Attendance rate

---

# FA-13 Community

Requirements include:

- Follow users
- Followers
- Following
- Public profiles
- User discovery

---

# FA-14 Social Feed

Requirements include:

- Posts
- Images
- Videos
- Workout sharing
- Comments
- Likes (MVP)
- Delete posts
- Report posts

---

# FA-15 Challenges

Requirements include:

- Official challenges
- Community challenges
- Progress tracking
- Leaderboards

---

# FA-16 Search

Requirements include:

- Search users
- Search exercises
- Search programs

---

# FA-17 Notifications

Requirements include:

- Workout reminders
- Comment notifications
- Follow notifications
- Challenge updates

---

# FA-18 Settings

Requirements include:

- Privacy
- Notification preferences
- Units
- Theme
- Account deletion

---

# 4. Out of Scope (MVP)

The following capabilities are intentionally excluded:

- AI Coach
- AI Programming
- Recovery Intelligence
- Wearable Integration
- Nutrition Tracking
- Sleep Tracking
- Injury Prediction
- Voice Coaching
- Camera Form Analysis
- Local Leaderboards
- Fitness Score
- AI Assistant

---

# 5. Future Functional Areas

The following modules are expected in future releases:

- Recovery Engine
- Nutrition Engine
- Sleep Intelligence
- AI Coach
- AI Workout Generator
- AI Form Analysis
- AI Recommendations
- Fitness Reputation System
- Mentor System
- Tournament Platform
- Marketplace
- Trainer Platform

---

# 6. Traceability

Every functional requirement in this document supports one or more of the following product goals:

- Build consistency
- Enable measurable progress
- Reduce training friction
- Encourage long-term discipline
- Foster meaningful community
- Prepare the foundation for future AI-driven coaching
```

---

## One important improvement I'd make

As your technical architect, I would **not** stop here.

This document should remain **high-level**. Each major functional area (e.g., Workout Logging, Routine Builder, Community) should have its own detailed specification later under something like:

```
docs/specifications/

routine-builder.md
workout-engine.md
community.md
skill-tracking.md
progress-tracking.md
```

Each of those would contain user stories, edge cases, validations, business rules, and acceptance criteria. That separation keeps the main functional requirements document readable while providing enough depth for implementation. I recommend we follow that approach as the project grows.
