# Development Status

**Last updated:** 2026-10-04
**Current week:** Week 05 in progress
**Current milestone:** M2 — Core Features (in progress)

---

## Overall Progress

| Epic | Title | Status | Stories |
|------|-------|--------|---------|
| epic-01 | Foundation and Project Setup | Done | STORY-001 to STORY-005C |
| epic-02 | Design System | Done | STORY-006 to STORY-009 |
| epic-03 | Authentication | Done | STORY-010 to STORY-014 |
| epic-04 | Profile and Onboarding | In Progress | STORY-015 to STORY-018 |
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

**Week 03 — epic-03-authentication** (completed 2026-09-13)

| Story | Title | Notes |
|-------|-------|-------|
| STORY-010 | Auth database schema | User + RefreshToken entities, UUID v7 PKs, EF Core migration AddAuthSchema, entity configs with snake_case naming |
| STORY-011 | Auth API endpoints | POST /api/v1/auth/register, /login, /refresh, /logout — minimal API, GlobalExceptionHandler for ProblemDetails |
| STORY-012 | JWT auth middleware | 15-min access token (JWT), 7-day rotating refresh token (64-byte random, stored in DB); lazy IConfigureOptions<JwtBearerOptions> pattern for test compatibility |
| STORY-013 | Flutter auth screens | AuthService (http), TokenStorage (flutter_secure_storage), AuthNotifier (ChangeNotifier), LoginScreen, SignupScreen, go_router redirect guard |
| STORY-014 | Auth regression tests | 14 integration tests (RegisterTests×3, LoginTests×4, RefreshTests×3, LogoutTests×3) using WebApplicationFactory + InMemory; all pass |

**Week 04 — epic-04-onboarding** (completed 2026-10-03)

| Story | Title | Notes |
|-------|-------|-------|
| STORY-015 | User profile entity and API | **Done.** `POST /api/v1/profile/onboarding`, `GET /api/v1/profile`, and `PATCH /api/v1/profile` all implemented. Trailing-slash route bug fixed (`""` instead of `"/"` in Minimal API group). |
| STORY-016 | Onboarding flow (Flutter) | **Done.** 8-step flow: name → sex/body metrics → experience → goals → location/equipment → schedule/session length → baseline assessment → plan reveal; `OnboardingNotifier` (ChangeNotifier), `OnboardingService` (http.Client injectable), full multi-select chips, animated plan reveal with milestones. |
| STORY-017 | Profile screen (Flutter) | **Done.** `ProfileService` + `ProfileNotifier` wired; real name and email rendered from API. Error banner with retry shown on load failure. Google sign-in deferred (TD-006). Stats row (workouts/streak/days/skills) still mocked. |
| STORY-018 | Profile integration tests | **Partial.** 34 Flutter unit tests written for `OnboardingNotifier` + `OnboardingService`; all pass. Backend integration tests for profile endpoints (WebApplicationFactory-style, like STORY-014) not yet written. |

**Also shipped in Week 04 (cleanup + hardening):**
- Deleted 7 unused step/widget files (dead code from earlier iteration)
- Removed orphaned `AssessmentResult` fields (`lSitSeconds`, `handstand`, `skipped`) from model and service
- Fixed `StepBaseline.initState()` to restore metric and injury state on back-navigation
- Added `Google.Apis.Auth` NuGet package and `POST /api/v1/auth/google` backend endpoint (validates Google ID token, finds-or-creates user, returns Atlas JWT pair)
- Added `GoogleId` field to `User` domain entity; `UserProfile` entity added to domain and EF config
- EF migrations `AddGoogleAuth` and `AddUserProfile` committed (closes TD-007)
- Fixed 21 Flutter lint warnings (`prefer_const_constructors`, `prefer_single_quotes`, `sort_pub_dependencies`)
- Fixed 3 failing router tests (`find.byType(NavigationDestination)` → text-based finders matching custom `_AtlasNavBar`); CI fully green

---

## In Progress

None.

---

## Upcoming (Week 05)

**Week 05** — Finish epic-04 remainder + start Exercise Library (epic-05)

**epic-04 carry-over:**
- STORY-018 · Backend integration tests for profile endpoints (WebApplicationFactory-style)

**epic-05:**
- STORY-019 · Exercise entity, seeding, and `GET /api/v1/exercises` (list + filter)
- STORY-020 · Exercise detail API (`GET /api/v1/exercises/{id}`)
- STORY-021 · Exercise library screen (Flutter) — browse, filter by muscle/equipment/difficulty
- STORY-022 · Exercise detail screen (Flutter)

---

## Scope Decisions

**Week 04**

| Decision | Rationale |
|----------|-----------|
| Inject `http.Client` into `OnboardingService` (not use top-level `http.post`) | Enables pure unit tests without a live server. `MockClient` from `package:http/testing.dart` replaces the network layer in tests; no mockito needed. |
| `_FakeTokenStorage` subclasses `TokenStorage` instead of using an interface | `TokenStorage` has no interface. Subclassing + overriding `getAccessToken()` avoids touching platform channels (flutter_secure_storage constructor is safe; only read/write ops invoke the channel). |
| Google sign-in frontend OAuth credentials deferred | Requires GCP project setup, platform config files, and SHA-1 fingerprint — user action, not code. Backend endpoint is complete; frontend will wire up when credentials are ready. EF migration for `GoogleId`/`UserProfile` excluded from this MR (auto-generated, separate concern). |
| Commit type `fix`, not `feat` | Week 04 MR is cleanup + bug fix + tests, not new user-visible functionality. Conventional commits: `fix` for correctness/cleanup, `feat` only for net-new features. |

**Week 03**

| Decision | Rationale |
|----------|-----------|
| Short-lived access token (15 min) + 7-day rotating refresh token | Balances security (short access window) with UX (no frequent re-login). Refresh tokens rotate on each use to limit replay attack window. |
| Lazy IConfigureOptions<JwtBearerOptions> for JWT bearer config | Reading JWT config via IOptions after Build() ensures WebApplicationFactory ConfigureAppConfiguration callbacks are applied before values are read. |
| Removed Serilog bootstrap logger (Log.Logger = CreateBootstrapLogger) | The global static bootstrap logger is unsafe when multiple WebApplicationFactory instances build in parallel during tests (ReloadableLogger.Freeze() throws on second call). Non-bootstrap UseSerilog is equivalent for MVP. |
| flutter_secure_storage for token storage | Keychain/Keystore-backed; appropriate for JWT tokens on mobile. flutter_secure_storage v9 used. |

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
| TD-005 | appsettings.Development.json does not contain App:JwtSecret/JwtIssuer/JwtAudience; local `dotnet run` requires manual env vars or user-secrets setup. Add a note to README. | Low | Week 03 (STORY-012) |
| TD-006 | Google sign-in frontend is a stub (SnackBar "coming soon"). Backend `/auth/google` endpoint is complete. Blocked on: GCP OAuth credentials, `GoogleService-Info.plist`, `google-services.json`, SHA-1 fingerprint registration, `Info.plist` URL scheme, `google_sign_in` Flutter package. | Medium | Week 04 (STORY-017) |
| ~~TD-007~~ | ~~EF migrations for `GoogleId` on `User` and `UserProfile` entity are not committed.~~ **Resolved (2026-10-04)** — `AddGoogleAuth` and `AddUserProfile` migrations committed. | ~~Medium~~ Closed | — |

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
