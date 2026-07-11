# Product Feature Catalog

## Overview

This document provides a high-level index of all Atlas product features. For detailed functional requirements, architecture, and implementation guidance for each feature, see the [features folder](features/).

## Quick Navigation

**[→ Go to detailed features documentation](features/)**

---

## Core Features at a Glance

### Training Foundation

| Feature | Purpose | MVP Status |
|---------|---------|-----------|
| [Identity and Access](features/01-identity-and-access/functional-requirements.md) | User authentication and session management | ✓ MVP |
| [User Profile and Goals](features/02-user-profile-and-goals/functional-requirements.md) | User data and personalization context | ✓ MVP |
| [Exercise Library](features/03-exercise-library/functional-requirements.md) | Searchable movement catalog with instruction | ✓ MVP |
| [Programs](features/04-programs/functional-requirements.md) | Pre-built structured training plans | ✓ MVP |
| [Routine Builder](features/05-routine-builder/functional-requirements.md) | Custom workout creation and management | ✓ MVP |

### Execution and Tracking

| Feature | Purpose | MVP Status |
|---------|---------|-----------|
| [Workout Execution](features/06-workout-execution/functional-requirements.md) | Active session management and logging | ✓ MVP |
| [Skills and Milestones](features/07-skills-and-milestones/functional-requirements.md) | Achievement tracking and progression | ✓ MVP |
| [Progress and Consistency](features/08-progress-and-consistency/functional-requirements.md) | Performance analytics and streaks | ✓ MVP |

### Community and Engagement

| Feature | Purpose | MVP Status |
|---------|---------|-----------|
| [Community and Challenges](features/09-community-and-challenges/functional-requirements.md) | Social interaction and group challenges | ✓ MVP |
| [Notifications and Search](features/10-notifications-and-search/functional-requirements.md) | Discovery and engagement | ✓ MVP |

### Intelligence

| Feature | Purpose | MVP Status |
|---------|---------|-----------|
| [AI and Personalization](features/11-ai-personalization/functional-requirements.md) | Intelligent recommendations and guidance | ✓ MVP (v1) |

---

## Feature Categories

### By Domain

**Training Core**
- Exercise Library
- Programs
- Routine Builder
- Workout Execution

**Progress**
- Skills and Milestones
- Progress and Consistency
- AI and Personalization

**Community**
- Community and Challenges
- Notifications and Search

**Platform**
- Identity and Access
- User Profile and Goals

### By User Journey

**Onboarding**
- Identity and Access
- User Profile and Goals

**Daily Usage**
- Workout Execution
- Programs
- Routine Builder
- Exercise Library

**Reflection**
- Progress and Consistency
- Skills and Milestones
- Community and Challenges

**Discovery**
- Notifications and Search
- AI and Personalization

---

## Feature Dependencies

```
Identity and Access (required for all)
    ↓
User Profile and Goals
    ↓
Exercise Library ← Programs, Routine Builder, Workout Execution
    ↓
Workout Execution
    ↓
Skills and Milestones, Progress and Consistency
    ↓
AI and Personalization (consumes all data)
    ↓
Community and Challenges
    ↓
Notifications and Search
```

---

## MVP Release Scope

All 11 features are included in Atlas v1.0 MVP.

**Feature Completeness:**
- 01: Identity and Access - 100%
- 02: User Profile and Goals - 100%
- 03: Exercise Library - 100%
- 04: Programs - 100%
- 05: Routine Builder - 100%
- 06: Workout Execution - 100%
- 07: Skills and Milestones - 100%
- 08: Progress and Consistency - 100%
- 09: Community and Challenges - 100%
- 10: Notifications and Search - 100%
- 11: AI and Personalization - 60% (basic recommendations only)

---

## Post-MVP Roadmap (v2.0+)

### v2.0 Enhancements

**AI and Personalization**
- Form analysis using video
- Injury risk prediction
- Advanced recovery recommendations

**Community**
- Direct messaging
- Private groups
- User-created challenges

**Advanced Features**
- Coach tools and custom programs
- Wearable integration
- Social leaderboards

### v3.0+ Vision

- Adaptive training programs
- Real-time coaching
- Comparative benchmarking
- Mentorship platform
- Certification programs

---

## Cross-Feature Integration Points

| Integration | Features Involved |
|-------------|-------------------|
| Data for personalization | All features → AI and Personalization |
| Skill tracking | Workout Execution → Skills and Milestones |
| Progress analytics | Workout Execution → Progress and Consistency |
| Achievement notifications | Skills/Challenges → Notifications |
| Social sharing | All features → Community |
| Search discovery | Community → Notifications and Search |
| Challenge participation | Community → Workout Execution data |

---

## For Developers and Designers

Start here to understand Atlas features:

1. **Overview**: Read this file (you are here)
2. **Deep Dive**: Select feature from table above
3. **Functional Requirements**: Read `functional-requirements.md` in feature folder
4. **Implementation**: See architecture and domain docs for technical details
5. **Design**: See product design docs for UI/UX guidance

---

## Questions or Updates?

Feature documentation is living. As product decisions evolve:

- Update the specific feature's functional-requirements.md
- Maintain this index for navigation
- Cross-reference related features
- Keep MVP scope clear vs. future enhancements

