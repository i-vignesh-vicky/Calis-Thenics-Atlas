# STORY-003 · Configure Backend Solution Shell

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 4 hrs
Priority: High
Status: Done

## Objective

Create the ASP.NET Core backend solution with the full six-project structure, a health endpoint,
logging middleware, and a consistent error response shape — ready for feature modules to plug into.

## Implementation Steps

- [x] Create the backend solution file `backend/Atlas.slnx` with all six projects:
  - `src/Atlas.Api` — REST endpoints, controllers, middleware
  - `src/Atlas.Application` — commands, queries, handlers
  - `src/Atlas.Domain` — entities, value objects, domain logic (no framework references)
  - `src/Atlas.Infrastructure` — data access, external integrations
  - `src/Atlas.Contracts` — DTOs, request/response models
  - `src/Atlas.Shared` — utilities, constants, extensions
- [x] Create the three test projects:
  - `tests/Atlas.UnitTests`
  - `tests/Atlas.IntegrationTests`
  - `tests/Atlas.ArchitectureTests`
- [x] Set project references: `Api → Application → Domain`; `Api → Infrastructure → Domain`; `Api → Contracts`; all can reference `Shared`.
  Domain must not reference any other project.
- [x] Add a health endpoint at `GET /api/v1/health` that returns `200 OK` with a minimal JSON payload.
- [x] Add Serilog for structured JSON logging and wire a request-logging middleware.
- [x] Define the standard error response type in `Atlas.Contracts` matching the shape in `docs/03-engineering/api-guidelines.md`:
  `{ "error": { "code", "message", "details"[], "traceId", "timestamp" } }`
- [x] Add a global exception handler middleware that catches unhandled exceptions and returns the standard error shape with a 500 status.
- [x] Add a route grouping pattern (e.g., `MapGroup("/api/v1")`) so future modules mount their routes cleanly.
- [x] Add an `IClock` abstraction in `Atlas.Shared` or `Atlas.Domain` to avoid `DateTime.UtcNow` in testable code.

## Technical Notes

- The `Atlas.Domain` project must have zero NuGet or project references to frameworks.
  `Atlas.ArchitectureTests` will enforce this with a layer dependency rule.
- All API routes must be under `/api/v1/` — no unversioned routes.
- The health endpoint is public (no auth required). All future feature endpoints will require JWT.
- Do not add feature code (no auth, no workout logic). This is a structural shell only.
- `appsettings.json` and `appsettings.Development.json` should be in `Atlas.Api`.
  Connection strings and secrets come from environment variables (see STORY-002).

## Tests

- [x] Add a layer dependency test in `Atlas.ArchitectureTests` that asserts `Atlas.Domain` does not reference
  `Atlas.Infrastructure`, `Atlas.Api`, or `Atlas.Application`.
- [x] Add an integration smoke test in `Atlas.IntegrationTests` that boots the API in-process and
  calls `GET /api/v1/health`, asserting `200 OK`.

## Documentation

- [x] Document backend start command (`dotnet run --project src/Atlas.Api`) in the README.
- [x] Document the project dependency graph in the engineering notes or README.

## Acceptance Criteria

- [x] Solution builds without errors (`dotnet build`).
- [x] All six source projects and three test projects exist with correct project references.
- [x] `GET /api/v1/health` returns `200 OK`.
- [x] Unhandled exceptions return the standard error JSON shape.
- [x] `Atlas.Domain` has no dependency on infrastructure or framework packages.
- [x] The layer dependency architecture test passes.
- [x] The health endpoint smoke test passes.

## Deliverables

- `backend/Atlas.slnx` with all projects
- Health endpoint at `GET /api/v1/health`
- Standard error response type and global exception handler
- Serilog request logging middleware
- `IClock` abstraction
- Layer dependency architecture test
- Integration smoke test for health endpoint
