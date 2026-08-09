# STORY-001 · Create Repository Skeleton

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Done

## Objective

Create the root workspace structure and initial folder layout for the monorepo so every subsequent
story has a stable home for its files.

## Implementation Steps

- [x] Create the top-level folder structure:
  ```
  /
    backend/        — ASP.NET Core solution (STORY-003, STORY-005C)
    frontend/       — Flutter app (STORY-004)
    docs/           — existing documentation (already present)
    shared/         — cross-platform shared assets or contracts (future use)
    .github/
      workflows/    — CI pipeline (STORY-005A)
  ```
  The `infrastructure/` folder is deferred — nothing is assigned to it in Week 1.
  Create it only when a concrete artifact (e.g. Terraform, Helm) requires a home.
- [x] Add a `global.json` at the repository root pinning the .NET SDK version:
  ```json
  {
    "sdk": {
      "version": "10.0.0",
      "rollForward": "latestFeature"
    }
  }
  ```
  This enforces the same SDK locally and in CI without relying solely on README prose.
- [x] Add a `.gitignore` covering .NET, Flutter, macOS, Windows, JetBrains, and VS Code artifacts.
- [x] Add a `Makefile` at the repository root with commands for the full developer lifecycle.
  **Windows prerequisite:** `make` is not in the Windows PATH by default. Install via
  Chocolatey (`choco install make`) or use Git Bash / WSL where `make` is available.
  Document this in the README prerequisites section.
  - `make install` — restore all dependencies (`dotnet restore` + `flutter pub get`)
  - `make build` — build backend and frontend (`dotnet build` + `flutter build apk --debug`)
  - `make test` — run all tests (`dotnet test` + `flutter test`)
  - `make db-up` — now wired to `docker compose up -d postgres` (STORY-005C completed)
  - `make lint` — run linters:
    - Backend: `dotnet format --verify-no-changes` (built into the .NET SDK; no extra install)
    - Frontend: `dart analyze && dart format --set-exit-if-changed .`
- [x] Add a root `.editorconfig` enforcing consistent indentation (2 spaces for Dart, 4 for C#),
  LF line endings, and UTF-8 encoding. This keeps diffs clean across editors and OSes.
- [x] Update the root `README.md`:
  - Remove or fix any links that no longer resolve (e.g. `docs/stories/PLAN.md`,
    `docs/03-engineering/architecture.md`) — replace with current paths or remove entirely.
  - Add: folder layout and the purpose of each top-level directory.
  - Add: prerequisites section listing .NET 10 SDK, Flutter stable, Docker Desktop,
    and `make` (with the Windows installation note).
  - Add: developer workflow (clone → `make install` → `make db-up` → run).
  - Add: links to ARCHITECTURE.md, CLAUDE.md, and the engineering docs under `docs/03-engineering/`.

## Technical Notes

- Keep the structure simple enough for a single developer to navigate without extra tooling.
- The `shared/` folder can be empty at this stage — its presence defines the boundary before any
  code goes into it. Do not create `infrastructure/` until a concrete artifact needs a home.
- SDK version pins: `global.json` pins the .NET SDK at repo level. Document the Flutter stable
  channel version in the README prerequisites. Both must match what CI installs (STORY-005A).
- `make lint` uses tools already on the PATH after SDK installs: `dotnet format` is built into
  the .NET SDK; `dart analyze` and `dart format` are bundled with Flutter. No extra tooling required.
- `make db-up` is a stub at this stage — it must print a clear message rather than silently fail
  or attempt to call a `docker-compose.yml` that does not yet exist.

## Verification (Manual)

- [x] Clone the repo on a clean machine (or clean shell); confirm `make install`, `make build`,
  `make lint`, and `make test` each run without path errors.
- [x] Run `make db-up`; wired to docker compose (STORY-005C superseded the stub).
- [x] Confirm all README links resolve to real files in the repository.
- [x] Confirm `global.json` causes `dotnet --version` to report the pinned version.

## Documentation

- [x] README: folder layout, prerequisites, and developer workflow.

## Acceptance Criteria

- [x] The repository has a clear folder structure matching the MVP architecture.
- [x] `global.json` is present at the repo root and pins .NET 10.
- [x] A `.gitignore` is present and covers .NET, Flutter, and common IDE artifacts.
- [x] A `.editorconfig` is present and enforces indentation and encoding rules.
- [x] Root Makefile targets exist for `install`, `build`, `test`, `db-up`, and `lint`.
- [x] `make db-up` wired to `docker compose up -d postgres` (STORY-005C completed).
- [x] `make lint` runs `dotnet format --verify-no-changes` and `dart analyze`/`dart format`.
- [x] The README documents prerequisites (including the `make` Windows install note),
  folder layout, and developer workflow. All README links resolve.

## Deliverables

- Top-level folder structure (`backend/`, `frontend/`, `shared/`, `.github/workflows/`)
- `global.json`
- `.gitignore`
- `.editorconfig`
- Root `Makefile`
- Updated `README.md`
