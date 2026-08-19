# Calis-Thenics-Atlas

[![CI](https://github.com/i-vignesh-vicky/Calis-Thenics-Atlas/actions/workflows/ci.yml/badge.svg)](https://github.com/i-vignesh-vicky/Calis-Thenics-Atlas/actions/workflows/ci.yml)

An intelligent calisthenics fitness platform that helps users train consistently, improve over time,
and stay motivated through personalized guidance.

---

## Repository structure

```
.
├── backend/          — ASP.NET Core solution (Clean Architecture, modular monolith)
├── frontend/         — Flutter mobile application
├── shared/           — Cross-platform shared assets and contracts (future use)
├── docs/             — Product, domain, and engineering documentation
│   ├── 01-product/   — Requirements and roadmap
│   ├── 02-domain/    — Domain model and business rules
│   ├── 03-engineering/ — Architecture, API, testing, and coding standards
│   └── delivery/     — Epics, stories, weekly plan, and development status
├── .github/
│   └── workflows/    — GitHub Actions CI pipeline
├── .editorconfig     — Editor indentation and encoding rules
├── .gitignore        — Ignored build artifacts and local config
├── global.json       — .NET SDK version pin
├── Makefile          — Developer lifecycle commands
├── ARCHITECTURE.md   — Resolved architecture decisions
├── CLAUDE.md         — AI operating instructions and guardrails
├── CONVENTIONS.md    — Naming and coding conventions
└── PRODUCT.md        — Product vision and goals
```

---

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| .NET SDK | 10 LTS | https://dotnet.microsoft.com/download |
| Flutter | stable channel | https://docs.flutter.dev/get-started/install |
| Docker Desktop | latest | https://www.docker.com/products/docker-desktop |
| `make` | any | **Windows:** `choco install make` (Chocolatey) or use Git Bash / WSL |

`global.json` at the repo root enforces the correct .NET SDK version automatically.

---

## Local setup

```bash
# 1. Clone
git clone <repo-url>
cd Calis-Thenics-Atlas

# 2. Copy the environment file and fill in local values
cp .env.example .env
# Edit .env — all keys marked Required must be set before the app starts.
# The defaults in .env.example work for local development as-is.

# 3. Install dependencies
make install

# 4. Start local database
make db-up

# 5. Run the backend
cd backend && dotnet run --project src/Atlas.Api

# 6. Run the frontend
cd frontend && flutter run
```

### Environment keys

| Key | Required | Description |
|-----|----------|-------------|
| `DATABASE_URL` | Yes | PostgreSQL connection string |
| `JWT_SECRET` | Yes | Token signing secret — any string locally |
| `JWT_ISSUER` | Yes | Token issuer identifier |
| `JWT_AUDIENCE` | Yes | Token audience identifier |
| `ASPNETCORE_ENVIRONMENT` | Yes | Must be `Development` locally |
| `ASPNETCORE_URLS` | Yes | Backend listen URL (`http://localhost:5000`) |
| `API_BASE_URL` | Yes | Frontend API base (`http://localhost:5000/api/v1`) |
| `FIREBASE_SERVER_KEY` | No | Push notifications — required from Week 09 |
| `APNS_KEY_ID` | No | Push notifications — required from Week 09 |
| `APNS_TEAM_ID` | No | Push notifications — required from Week 09 |

The app throws a clear startup error if any required key is absent. Optional keys enable future features; the app starts without them.

---

## Backend project structure

```
backend/
├── src/
│   ├── Atlas.Api           — REST endpoints, middleware, host configuration
│   ├── Atlas.Application   — Commands, queries, handlers (CQRS)
│   ├── Atlas.Domain        — Entities, value objects, domain logic (no framework refs)
│   ├── Atlas.Infrastructure — Data access, external integrations
│   ├── Atlas.Contracts     — DTOs, request/response models, error types
│   └── Atlas.Shared        — Utilities, IClock, extensions (shared by all layers)
└── tests/
    ├── Atlas.UnitTests         — Fast unit tests for domain and application logic
    ├── Atlas.IntegrationTests  — API and data layer integration tests
    └── Atlas.ArchitectureTests — Layer dependency enforcement via NetArchTest
```

**Dependency graph** (arrows = "depends on"):

```
Atlas.Api → Atlas.Application → Atlas.Domain
Atlas.Api → Atlas.Infrastructure → Atlas.Domain
Atlas.Api → Atlas.Contracts
All layers → Atlas.Shared
Atlas.Domain → (nothing — zero outbound references)
```

---

## Frontend project structure

```
frontend/
└── lib/
    ├── main.dart              — app entry point
    ├── app/
    │   ├── app.dart           — root App widget (MaterialApp.router)
    │   ├── router.dart        — central go_router configuration
    │   └── shell.dart         — MainShell with bottom navigation bar
    ├── core/
    │   ├── theme/             — placeholder ThemeData (Week 02 replaces this)
    │   ├── constants/         — app-level constants
    │   ├── styles/            — shared style tokens (placeholder)
    │   └── env/               — compile-time env accessor (--dart-define)
    ├── features/
    │   └── home/screens/      — HomeScreen (landing placeholder)
    ├── shared/
    │   ├── components/        — reusable widgets
    │   ├── services/          — shared service abstractions
    │   └── utilities/         — helpers, extensions
    └── design-system/         — placeholder; Week 02 populates this
```

**Routing:** all routes are declared centrally in `lib/app/router.dart` using `go_router`.
Do not use Navigator 1.0 push/pop for feature navigation.

**Five bottom-nav destinations:** Home, Workouts, Progress, Profile, Settings.
Each destination is a placeholder scaffold until its feature epic is implemented.

**Theme:** `App` accepts an optional `ThemeData` parameter so Week 02 can swap in
the design system without structural changes.

**Supported platforms:** Android, iOS (primary targets for MVP).

### Running the frontend

```bash
# One-time: install dependencies
cd frontend && flutter pub get

# Run on connected device or emulator
cd frontend && flutter run

# Pass the backend URL at run time (optional — defaults to localhost:5000)
cd frontend && flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000/api/v1

# Run tests
cd frontend && flutter test
```

> **Note:** Platform directories (android/, ios/) are generated by `flutter create` and are not
> committed. Run `flutter create --org com.calisthenicsatlas --project-name atlas .` inside
> `frontend/` to regenerate them, then `flutter pub get`.

---

## Makefile targets

| Target | Description |
|--------|-------------|
| `make install` | Restore backend (`dotnet restore`) and frontend (`flutter pub get`) dependencies |
| `make build` | Build backend (Release) and frontend (debug APK) |
| `make test` | Run all backend and frontend tests |
| `make smoke` | Run only the startup smoke tests (health endpoint + Flutter widget test) |
| `make lint` | Run `dotnet format --verify-no-changes` and `dart analyze && dart format` |
| `make db-up` | Start local PostgreSQL via Docker Compose |
| `make db-migrate` | Apply pending EF Core migrations to the local database |
| `make db-reset` | Tear down and recreate the local database, then re-apply all migrations |

---

## Contributing

### Smoke tests

Before merging any feature code, run both smoke tests locally:

```bash
make smoke
```

This runs:
1. **Backend smoke test** — boots the API in-process and asserts `GET /api/v1/health` returns `200 OK`
2. **Flutter smoke test** — pumps the root `App` widget and confirms it renders without errors

Both tests must pass. The same commands run in CI on every pull request and push to `main`. A failing smoke test blocks merges.

### Database (local)

```bash
# Start PostgreSQL
make db-up

# Apply pending migrations
make db-migrate

# Full reset (drops and recreates the database, then re-applies all migrations)
make db-reset
```

Migrations live in `backend/src/Atlas.Infrastructure/Migrations/`. To create a new migration after changing the domain model:

```bash
cd backend && dotnet ef migrations add <MigrationName> \
  --project src/Atlas.Infrastructure \
  --startup-project src/Atlas.Api
```

The `dotnet-ef` tool is a local tool declared in `backend/.config/dotnet-tools.json`. Run `dotnet tool restore` inside `backend/` if the command is not found.

---

## Key documentation

- [ARCHITECTURE.md](ARCHITECTURE.md) — Tech stack decisions and architectural constraints
- [CLAUDE.md](CLAUDE.md) — AI operating rules and source-of-truth priority order
- [CONVENTIONS.md](CONVENTIONS.md) — Naming, structure, and coding conventions
- [docs/03-engineering/backend.md](docs/03-engineering/backend.md) — Backend architecture guide
- [docs/03-engineering/frontend.md](docs/03-engineering/frontend.md) — Frontend architecture guide
- [docs/03-engineering/api-guidelines.md](docs/03-engineering/api-guidelines.md) — API design standards
- [docs/03-engineering/testing.md](docs/03-engineering/testing.md) — Testing strategy and patterns
- [docs/delivery/development-status.md](docs/delivery/development-status.md) — Current delivery status
