# Project Execution Plan

## Purpose

This document is the working execution plan for shipping the Calis-Thenics-Atlas MVP in 18 weeks. It is written for a solo builder with 10–15 hours per week and is meant to stay practical, focused, and easy to follow.

## How to Use This Plan

1. Treat each week as one vertical slice.
2. Finish the current slice before moving to the next.
3. Keep the scope limited to the MVP.
4. Use the product, domain, and engineering docs in this repository as the source of truth.

## Source of Truth

- [README.md](../../README.md)
- [docs/01-product/product-roadmap.md](../01-product/product-roadmap.md)
- [docs/01-product/functional-requirements.md](../01-product/functional-requirements.md)
- [docs/03-engineering/architecture.md](../03-engineering/architecture.md)
- [docs/03-engineering/backend.md](../03-engineering/backend.md)
- [docs/03-engineering/frontend.md](../03-engineering/frontend.md)
- [docs/03-engineering/testing.md](../03-engineering/testing.md)

## MVP Scope

Included in the MVP:
- Identity and access
- User profile and onboarding
- Exercise library
- Programs and routine builder
- Workout execution and logging
- Skills, milestones, and progress tracking
- Basic notifications and search
- Foundational personalization

Deferred beyond MVP:
- Advanced AI coaching
- Nutrition intelligence
- Trainer marketplace
- Full social expansion
- Wearable-native recovery intelligence

## Delivery Order

1. Foundation
2. Design system and navigation
3. Authentication and onboarding
4. Exercise library and routine builder
5. Workout execution and history
6. Progress, notifications, search, and settings
7. Hardening, beta, and launch

## Milestones

- Milestone 1: Foundation complete
  - Repo baseline is stable
  - CI/CD runs on main
  - Backend and frontend connect locally
  - Design system is usable

- Milestone 2: Authentication complete
  - Sign up, login, reset password, and logout work
  - Session handling is reliable

- Milestone 3: Core training flow complete
  - Users can browse exercises, build routines, start workouts, and log sessions
  - History and progress basics are available

- Milestone 4: Beta ready
  - Core flows work end to end
  - Critical paths are tested
  - Beta build is deployable

- Milestone 5: MVP ready
  - All MVP requirements are complete
  - Release checklist is finished
  - Product is ready for launch

## Weekly Roadmap

Week 1 — Project setup and baseline
- Establish repo structure, tooling, environment, backlog, and branch strategy.

Week 2 — Design system and navigation
- Build the app shell, shared components, visual system, and route structure.

Week 3 — Authentication foundation
- Implement sign up, login, password reset, session persistence, and logout.

Week 4 — Profile and onboarding
- Add profile creation, goals, experience level, and equipment preferences.

Week 5 — Exercise library basics
- Build browse, search, filter, and exercise detail flows.

Week 6 — Program and routine model
- Implement programs, routines, duplication, ordering, and basic management.

Week 7 — Workout execution MVP
- Deliver start, pause, resume, complete, and auto-save workout sessions.

Week 8 — Workout history and logging improvements
- Add history views, notes, summaries, and revisitable workout details.

Week 9 — Progress tracking basics
- Introduce streaks, milestones, personal records, and visible progress signals.

Week 10 — Notifications and reminders
- Add reminder scheduling, notification settings, and basic delivery plumbing.

Week 11 — Search and discoverability
- Make exercises, routines, and programs easier to find.

Week 12 — Settings and account experience
- Add preferences, notification toggles, and account-related controls.

Week 13 — Hardening and reliability pass
- Improve empty states, validation, loading feedback, and error handling.

Week 14 — Beta build preparation
- Prepare deployment, staging environment, release configuration, and smoke tests.

Week 15 — Beta feedback collection
- Resolve the highest-value issues discovered by early testers.

Week 16 — Production readiness pass
- Improve observability, release safety, monitoring, and final polish.

Week 17 — Launch preparation
- Finalize store materials, launch checklist, support content, and QA.

Week 18 — MVP launch and stabilization
- Go live, monitor health, triage defects, and stabilize the first release wave.

## Working Rules

- Prefer a simple implementation over a complex one.
- Ship working software before polishing too far ahead.
- Keep scope disciplined: if a feature does not improve the MVP experience, defer it.
- If a feature feels too large, split it into a smaller slice that can be delivered in one week.

## Release Checklist

### Beta
- Core auth, profile, and workout flows work
- Exercise library and routines are usable
- Basic notifications and search are tested
- Deployment is stable enough for beta users

### Launch
- Environment variables and secrets are validated
- Monitoring, logs, and crash visibility are active
- Critical user journeys are tested end to end
- Rollback and support plan are documented

## Progress Tracker

- Current week:
- Date range:
- Completed modules:
- In progress:
- Remaining work:
- Risks or blockers:

## Expected Outcome

If this plan is followed consistently, the project should reach a realistic MVP with a sustainable pace, clear release milestones, and a strong foundation for future growth.
