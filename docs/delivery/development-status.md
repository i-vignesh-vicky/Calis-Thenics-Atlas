# Development Status

**Last updated:** 2026-09-13
**Current week:** Week 02 complete — transitioning to Week 03
**Current milestone:** M2 — Core Features (in progress)

---

## Overall Progress

| Epic | Title | Status | Stories |
|------|-------|--------|---------|
| epic-01 | Foundation and Project Setup | Done | STORY-001 to STORY-005C |
| epic-02 | Design System | Done | STORY-006 to STORY-009 |
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

**Week 02 — epic-02-design-system** (completed 2026-09-13)

| Story | Title | Notes |
|-------|-------|-------|
| STORY-006 | Add Design Tokens and Theme Provider | AppColors (full Material 3 dark ColorScheme, amber accent), AppSpacing/Radius/Durations tokens, full AppTheme replacing placeholder, 7 tests |
| STORY-007 | Create Shared UI Primitives | AtlasButton (3 variants, loading), AtlasCard, AtlasInput, AtlasEmptyState, 17 tests |
| STORY-008 | Add App Shell and Layout Containers | AtlasPageLayout standard Scaffold wrapper, 6 layout tests |
| STORY-009 | Add Route Skeletons and Navigation State | Full MVP route map (home, workouts/:id, progress, profile, settings, /auth/*), 404 fallback, 5 nav tests |

---

## In Progress

None.

---

## Upcoming (Week 03)

**Week 03** — Authentication (epic-03)
- STORY-010 · Add JWT authentication to backend
- STORY-011 · Add user registration endpoint
- STORY-012 · Add login and token refresh endpoint
- STORY-013 · Add auth guard middleware
- STORY-014 · Build login and signup screens (Flutter)

---

## Scope Decisions

**Week 02**

| Decision | Rationale |
|----------|-----------|
| Dark-first theme; light() delegates to dark() | Atlas MVP is dark-first. Light variant deferred to post-MVP when user preference data exists. |
| Visual identity: Dark/Focused (near-black + warm amber) | Chosen from 3 options. Disciplined, athletic aesthetic suited to serious training tool. |
| 5th nav tab is Settings (not Community) | Matches STORY-004 spec. Community tab surfaces in epic-09 if the tab is rearranged. |
| Material 3 surface containers for elevation, not shadows | Flatter look consistent with the dark/focused identity. Fewer box shadow calculations. |
| `abstract final class` for all token classes | Prevents instantiation; communicates intent as namespace-only utility. |

**Week 01**

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
| TD-001 | No isolated unit test for AppSettings startup validation with a missing key. The failure path is exercised only implicitly via the integration smoke test. | Low | Week 01 (STORY-002) |
| ~~TD-002~~ | ~~CI badge placeholder.~~ **Resolved (2026-08-09)** | ~~Low~~ Closed | — |
| ~~TD-003~~ | ~~Flutter platform dirs not committed.~~ **Resolved (2026-08-09)** | ~~Low~~ Closed | — |
| TD-004 | flutter analyze and flutter test cannot run in the office laptop shell session (flutter not on PATH in hook-restricted environment). CI verifies instead. | Low | Week 02 (STORY-006) |

---

## Open Questions and Risks

| # | Description | Severity | Owner |
|---|-------------|----------|-------|
| OQ-01 | FR-SKILL-001 and FR-SKILL-003 (skill tracking) are not fully covered by existing stories. See epic-08 open question. | Medium | TBD |
| ~~OQ-02~~ | .NET version resolved: .NET 10 LTS. | ~~High~~ Closed | — |
| ~~OQ-03~~ | CI platform resolved: GitHub Actions. | ~~Low~~ Closed | — |
| ~~OQ-04~~ | Flutter router resolved: go_router. | ~~Low~~ Closed | — |
| OQ-05 | Custom typeface for stronger identity post-MVP (candidates: Inter, DM Sans). | Low | TBD |
| OQ-06 | Light theme variant deferred — revisit post-MVP when user preference data informs the decision. | Low | TBD |

---

## Blockers

None.

---

## Milestones

| Milestone | Target Week | Description | Status |
|-----------|-------------|-------------|--------|
| M1 | Week 01 | Repo builds, CI green, backend health endpoint live locally, frontend shell renders, DB migrations apply | Done |
| M2 | Week 06 | Core features (auth, profile, exercises, routines) complete | In Progress |
| M3 | Week 10 | Full feature set complete (workout, history, progress, notifications) | Todo |
| M4 | Week 14 | Beta build live with smoke tests passing | Todo |
| M5 | Week 18 | Production release live and stable | Todo |
