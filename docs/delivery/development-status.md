# Development Status

**Last updated:** 2026-08-08
**Current week:** Pre-implementation (planning complete)
**Current milestone:** M1 — Foundation

---

## Overall Progress

| Epic | Title | Status | Stories |
|------|-------|--------|---------|
| epic-01 | Foundation and Project Setup | Todo | STORY-001 to STORY-005C |
| epic-02 | Design System | Todo | STORY-006 to STORY-009 |
| epic-03 | Authentication | Todo | STORY-010 to STORY-014 |
| epic-04 | Profile and Onboarding | Todo | STORY-015 to STORY-018 |
| epic-05 | Exercise Library | Todo | STORY-019 to STORY-022 |
| epic-06 | Routine Builder | Todo | STORY-023 to STORY-026A |
| epic-07 | Workout Execution | Todo | STORY-027 to STORY-031 |
| epic-08 | History and Progress | Todo | STORY-032 to STORY-039 |
| epic-09 | Notifications | Todo | STORY-040 to STORY-043 |
| epic-10 | Search | Todo | STORY-044 to STORY-047 |
| epic-11 | Settings | Todo | STORY-048 to STORY-051 |
| epic-12 | Quality and Reliability | Todo | STORY-052 to STORY-055 |
| epic-13 | Release and Launch | Todo | STORY-056 to STORY-071 |

---

## Completed Stories

None yet. Planning phase complete as of 2026-08-08.

---

## In Progress

None. Ready to begin Week 01 (epic-01-foundation).

---

## Upcoming (Next 2 Weeks)

**Week 01** — Foundation and Project Setup
- STORY-001 · Create Repository Skeleton
- STORY-002 · Add Shared Environment Configuration
- STORY-003 · Configure Backend Solution Shell
- STORY-004 · Configure Frontend App Shell
- STORY-005A · Add CI Workflow for Main and Pull Requests
- STORY-005B · Add Baseline Smoke Test and Startup Validation
- STORY-005C · Set Up Database and Migration Tooling

**Week 02** — Design System
- STORY-006 · Add Design Tokens and Theme Provider
- STORY-007 · Create Shared UI Primitives
- STORY-008 · Add App Shell and Layout Containers
- STORY-009 · Add Route Skeletons and Navigation State

---

## Scope Decisions (Week 01)

| Decision | Rationale |
|----------|-----------|
| Staging deployment deferred | Priority is a working local environment. Hosting setup moves to the release phase (epic-13) once the core application is stable. Code is pushed to GitHub after each story. |
| Database setup included in Week 01 (STORY-005C) | EF Core naming conventions, PK strategy, and migrations must be correct from the first entity. Retrofitting is expensive. |
| Error response shape uses existing api-guidelines.md spec | Shape is already documented. Backend shell wires it as the global exception handler. |

---

## Open Questions and Risks

| # | Description | Severity | Owner |
|---|-------------|----------|-------|
| OQ-01 | FR-SKILL-001 and FR-SKILL-003 (skill tracking) are not fully covered by existing stories. See epic-08 open question. Story may need to be added. | Medium | TBD |
| OQ-02 | ~~.NET version not pinned.~~ **Resolved:** .NET 10 LTS. Documented in ARCHITECTURE.md and backend.md. | ~~High~~ Closed | — |
| OQ-03 | ~~CI platform unconfirmed.~~ **Resolved:** GitHub Actions. Documented in ARCHITECTURE.md. | ~~Low~~ Closed | — |
| OQ-04 | ~~Flutter router not chosen.~~ **Resolved:** go_router. Documented in ARCHITECTURE.md and frontend.md. | ~~Low~~ Closed | — |

---

## Blockers

None at this time.

---

## Milestones

| Milestone | Target Week | Description | Status |
|-----------|-------------|-------------|--------|
| M1 | Week 01 | Repo builds, CI green, backend health endpoint live locally, frontend shell renders, DB migrations apply | Todo |
| M2 | Week 06 | Core features (auth, profile, exercises, routines) complete | Todo |
| M3 | Week 10 | Full feature set complete (workout, history, progress, notifications) | Todo |
| M4 | Week 14 | Beta build live with smoke tests passing | Todo |
| M5 | Week 18 | Production release live and stable | Todo |
