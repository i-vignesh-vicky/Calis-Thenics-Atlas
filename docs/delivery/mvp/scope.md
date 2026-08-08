# MVP Scope

## Objective

Ship a practical, maintainable MVP that improves user consistency, progress, and long-term health behavior for calisthenics athletes. The product is a long-term fitness companion, not a vanity engagement app.

## Delivery Constraints

- Solo builder, 10–15 hours per week
- 18 weeks total
- Ship one vertical slice per week; finish it before moving on

## In Scope

| Area | Functional Requirements |
|---|---|
| Identity and access | FR-AUTH-001 to FR-AUTH-005 |
| User profile and goals | FR-PROFILE-001 to FR-PROFILE-004 |
| Exercise library | FR-LIB-001 to FR-LIB-004 |
| Routine builder | FR-ROUTINE-001 to FR-ROUTINE-005 |
| Workout execution and logging | FR-WORKOUT-001 to FR-WORKOUT-005 |
| Skills and milestones | FR-SKILL-001 to FR-SKILL-003 |
| Progress and consistency | FR-PROGRESS-001 to FR-PROGRESS-004 |
| Basic notifications | FR-NOTIF-001 |
| Search and discoverability | FR-SEARCH-001 |
| Settings and account preferences | (no portfolio FR ID; see epic-11) |
| Quality, reliability, and hardening | (no portfolio FR ID; see epic-12) |
| Release and launch | (no portfolio FR ID; see epic-13) |

Detailed requirements for each area live in `docs/01-product/features/`.

## Out of Scope for MVP

These are deliberately deferred, not forgotten.

| Area | Reason |
|---|---|
| Programs (FA-04: enroll, pause/resume, goal-oriented program tracking) | Not enough capacity in 18 weeks; ships as Phase 2 |
| Community and challenges (FA-09) | Social infrastructure is premature at launch scale |
| AI and personalization (FA-11) | Requires post-launch data to be meaningful |
| Advanced AI coaching | Phase 3 |
| Wearable-native recovery intelligence | Phase 4 |
| Nutrition intelligence | Post-MVP |
| Trainer marketplace | Post-MVP |

> If any deferred feature is requested during MVP development, recommend the phased alternative instead of expanding scope silently.

## Domain Clarifications

**Routine** — a user-created or system-provided sequence of exercises forming a single workout plan. Users can create custom routines or follow provided ones.

**Program** — a goal-oriented collection of workouts targeting a specific end goal (Muscle-Ups, Planche, Upper Body, Leg Day, etc.). Programs are deferred to Phase 2.

## Delivery Order

1. Foundation — repo, environment, backend/frontend shells, CI
2. Design system — tokens, primitives, app shell, navigation
3. Authentication — sign-up, login, session, logout
4. User profile and onboarding — goals, experience, equipment
5. Exercise library — browse, filter, detail
6. Routine builder — create, edit, reorder, persist
7. Workout execution — start, log sets, pause, resume, complete, auto-save
8. Workout history — history list, detail, summary
9. Progress tracking — streaks, milestones, personal records, dashboard
10. Notifications — reminder preferences, delivery stub
11. Search — query service, API, results UI
12. Settings — account preferences, persistence
13. Quality and hardening — error handling, empty states, regression coverage
14. Beta and release — build config, staging, smoke tests, launch, monitoring

## Milestones

| Milestone | Completion Signal |
|---|---|
| M1 — Foundation | Repo stable, CI green, backend + frontend connect locally, design system usable |
| M2 — Authentication | Sign-up, login, password reset, logout work; session is reliable |
| M3 — Core training flow | Users can browse exercises, build routines, start workouts, log sessions, see history and progress |
| M4 — Beta ready | Core flows work end to end, critical paths tested, beta build deployable |
| M5 — MVP ready | All MVP requirements complete, release checklist done, product ready for launch |

## Beta Release Checklist

- [ ] Core auth, profile, and workout flows work
- [ ] Exercise library and routines are usable
- [ ] Basic notifications and search are tested
- [ ] Deployment is stable for beta users

## Launch Release Checklist

- [ ] Environment variables and secrets validated
- [ ] Monitoring, logs, and crash visibility active
- [ ] Critical user journeys tested end to end
- [ ] Rollback and support plan documented

## Working Rules

- Prefer a simple implementation over a complex one
- Ship working software before polishing
- Keep scope disciplined: if a feature does not improve the MVP experience, defer it
- If a feature feels too large for one week, split it into a smaller deliverable slice

## Source of Truth

| Question | Document |
|---|---|
| What the product is | `PRODUCT.md` |
| Architecture decisions | `ARCHITECTURE.md` |
| Coding conventions | `CONVENTIONS.md` |
| Detailed feature requirements | `docs/01-product/features/` |
| Domain model | `docs/02-domain/domain-model.md` |
| Engineering guides | `docs/03-engineering/` |
| Epics | `docs/07-delivery/mvp/epics/` |
| Stories | `docs/07-delivery/mvp/stories/` |
| Weekly execution | `docs/07-delivery/weekly-plan/` |
| Current status | `docs/07-delivery/development-status.md` |
| Post-MVP roadmap | `docs/07-delivery/roadmap/post-mvp.md` |
