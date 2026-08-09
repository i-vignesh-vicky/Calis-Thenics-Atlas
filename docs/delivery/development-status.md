# Development Status

**Last updated:** 2026-08-09
**Current week:** Week 01 complete — transitioning to Week 02
**Current milestone:** M1 — Foundation (complete)

---

## Overall Progress

| Epic | Title | Status | Stories |
|------|-------|--------|---------|
| epic-01 | Foundation and Project Setup | Done | STORY-001 to STORY-005C |
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

**Week 01 — epic-01-foundation** (completed 2026-08-09)

| Story | Title | Notes |
|-------|-------|-------|
| STORY-001 | Create Repository Skeleton | All deliverables present: folder structure, global.json, .gitignore, .editorconfig, Makefile, README |
| STORY-002 | Add Shared Environment Configuration | .env.example, AppSettings with ValidateOnStart, frontend env.dart, README local-setup section |
| STORY-003 | Configure Backend Solution Shell | 6 src projects + 3 test projects, health endpoint, IClock, GlobalExceptionHandler, Serilog, arch tests |
| STORY-004 | Configure Frontend App Shell | Flutter app with go_router, 5-tab shell, HomeScreen placeholder, flutter_dotenv-free env accessor, smoke test |
| STORY-005A | Add CI Workflow | .github/workflows/ci.yml — backend and frontend jobs, JWT secrets passed via env, CI badge in README |
| STORY-005B | Add Baseline Smoke Test | Backend HealthEndpointTests (WebApplicationFactory), Flutter app_smoke_test, make smoke target |
| STORY-005C | Set Up Database and Migration Tooling | docker-compose.yml, AtlasDbContext, UuidV7ValueGenerator, dotnet-tools.json, InitialCreate migration |

---

## In Progress

None.

---

## Upcoming (Next 2 Weeks)

**Week 02** — Design System
- STORY-006 · Add Design Tokens and Theme Provider
- STORY-007 · Create Shared UI Primitives
- STORY-008 · Add App Shell and Layout Containers
- STORY-009 · Add Route Skeletons and Navigation State

---

## Scope Decisions (Week 01)

| Decision | Rationale |
|----------|-----------|
| Staging deployment deferred | Priority is a working local environment. Hosting setup moves to the release phase (epic-13) once the core application is stable. |
| Database setup included in Week 01 (STORY-005C) | EF Core naming conventions, PK strategy, and migrations must be correct from the first entity. Retrofitting is expensive. |
| Error response shape uses existing api-guidelines.md spec | Shape is already documented. Backend shell wires it as the global exception handler. |
| AppSettings in Atlas.Api, not Atlas.Shared | AppSettings references ASP.NET IOptions which would introduce a framework dependency into Atlas.Shared, violating clean architecture. Placed in Atlas.Api.Configuration instead. |
| Frontend env via --dart-define, not flutter_dotenv | Compile-time flags avoid shipping a .env file with the release binary. Simpler than a runtime loader for MVP. |
| UUIDNext 4.0.0 (not 3.x) | Version 3.1.0 does not exist; NuGet resolved to 4.0.0. Pin updated. Enum value is `Database.PostgreSql` (not `PostgreSQL` as shown in NuGet docs). |

---

## Technical Debt

| ID | Description | Severity | Introduced |
|----|-------------|----------|------------|
| TD-001 | No isolated unit test for AppSettings startup validation with a missing key. The failure path is exercised only implicitly via the integration smoke test. A discrete unit test would make the contract explicit. | Low | Week 01 (STORY-002) |
| TD-002 | CI badge in README uses `YOUR_ORG` placeholder. Must be replaced with the actual GitHub org/username once the repo is pushed and the badge URL is confirmed. | Low | Week 01 (STORY-005A) |
| ~~TD-003~~ | ~~Flutter platform directories (android/, ios/) are not committed.~~ **Resolved (2026-08-09):** Generated via `flutter create --org com.calisthenicsatlas --project-name atlas --platforms android,ios .` and committed. Platform build artifacts remain gitignored by `android/.gitignore` and `ios/.gitignore`. | ~~Low~~ Closed | Week 01 (STORY-004) |

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

None.

---

## Milestones

| Milestone | Target Week | Description | Status |
|-----------|-------------|-------------|--------|
| M1 | Week 01 | Repo builds, CI green, backend health endpoint live locally, frontend shell renders, DB migrations apply | Done |
| M2 | Week 06 | Core features (auth, profile, exercises, routines) complete | Todo |
| M3 | Week 10 | Full feature set complete (workout, history, progress, notifications) | Todo |
| M4 | Week 14 | Beta build live with smoke tests passing | Todo |
| M5 | Week 18 | Production release live and stable | Todo |
