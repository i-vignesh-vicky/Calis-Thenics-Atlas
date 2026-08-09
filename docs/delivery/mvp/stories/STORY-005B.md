# STORY-005B · Add Baseline Smoke Test and Startup Validation

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Done

## Objective

Confirm that the health endpoint smoke test (written in STORY-003) runs in CI and fails loudly
if the backend regresses, and that the Flutter widget test (written in STORY-004) is also wired
into the CI pipeline.

## Context

STORY-003 writes the backend integration smoke test and STORY-004 writes the Flutter widget smoke
test. This story's job is to verify they actually run in CI, that failures are visible, and that
the test commands are documented so any developer can run them locally in one step.

## Implementation Steps

- [x] Confirm the backend smoke test in `Atlas.IntegrationTests` runs under `dotnet test` and
  is picked up by the CI workflow (STORY-005A). If not, fix the project reference or test runner config.
- [x] Confirm the Flutter widget test runs under `flutter test` and is picked up by CI. If not,
  fix the test file location or pubspec.
- [x] Add or verify a `make smoke` (or equivalent) root script that runs both smoke tests in sequence
  locally without any manual steps.
- [x] If either smoke test requires environment variables (e.g., a connection string for the backend
  integration test), add those values to the CI secrets and document them in `.env.example`.

## Technical Notes

- The backend integration smoke test starts the API in-process using `WebApplicationFactory<Program>`
  and calls `GET /api/v1/health`. No external service (database, Redis) should be required for this
  specific test — use an in-memory or no-dependency configuration for the health check.
- The Flutter smoke test pumps the root `App` widget and asserts it renders without throwing.
  No network calls or platform channels should be required.
- The goal is the smallest test that proves startup works, not a comprehensive test suite. The test
  suite grows as features are added.

## Tests

- [x] Run `make smoke` (or the equivalent) locally and confirm both tests pass.
- [x] In CI, introduce a deliberate regression (e.g., throw in `Program.cs`) and confirm the workflow
  fails and shows the failure output.

## Documentation

- [x] Document the `make smoke` command (or equivalent) in the README contributing notes.
- [x] Note that smoke tests must run before any feature code is merged.

## Acceptance Criteria

- [x] Backend health endpoint smoke test passes locally and in CI.
- [x] Flutter widget smoke test passes locally and in CI.
- [x] CI fails clearly if either smoke test regresses.
- [x] A single command runs both smoke tests locally.
- [x] The smoke test command is documented.

## Deliverables

- Verified CI wiring for both backend and frontend smoke tests
- `make smoke` (or equivalent) root script
- README / contributing notes documenting the smoke command
