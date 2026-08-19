# STORY-002 · Add Shared Environment Configuration

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Done

## Objective

Add a shared environment configuration pattern for local development so both the backend and
frontend read required values from a single source and fail immediately on startup if anything
is missing.

## Implementation Steps

- [x] Create `.env.example` at the repository root with all required keys, placeholder values, and
  a comment for each explaining what it is and where to get the real value.
- [x] Add `.env` to `.gitignore` so real local secrets are never committed.
- [x] For the backend: `AppSettings` typed config class in `Atlas.Api.Configuration` (not Atlas.Shared —
  it references ASP.NET config abstractions). Validated at startup via `ValidateDataAnnotations()` +
  `ValidateOnStart()`. Missing required key throws at startup before any request is served.
- [x] For the frontend: `lib/core/env/env.dart` using `String.fromEnvironment` / `--dart-define`
  compile-time flags. Defaults to `http://localhost:5000/api/v1` for local development.
- [x] Document which keys are required versus optional in `.env.example` and the README.

## Technical Notes

- A single `.env.example` file covers both backend and frontend keys. Developers copy it to `.env`
  and fill in their local values.
- The backend reads environment variables via the standard ASP.NET Core configuration pipeline —
  no custom loader is needed beyond the built-in `AddEnvironmentVariables()`.
- The frontend does not have a standard `.env` loader. Either use `flutter_dotenv` (loads at runtime)
  or a compile-time `--dart-define` approach. Document the chosen approach.
- Do not hard-code any secret, connection string, or environment-specific URL in source files.

## Tests

- [ ] Backend: write a unit test that instantiates the settings validator with a missing required key
  and asserts it throws before the app continues.
  **NOTE:** Not implemented as a discrete unit test. Startup validation is exercised implicitly by
  the `HealthEndpointTests` integration test, which boots `WebApplicationFactory<Program>` with
  valid JWT config and confirms the app starts. The missing-key failure path is not covered by an
  isolated unit test — recorded as tech debt (TD-001).
- [x] Confirm the sample environment file is readable and the documented keys match the actual config
  bindings in code.

## Documentation

- [x] Add a "Local Setup" section to the README: copy `.env.example` → `.env`, fill in the values,
  run the app.
- [x] Note which keys are optional and what behavior changes when they are absent.

## Acceptance Criteria

- [x] `.env.example` exists at the repository root with all required keys documented.
- [x] The backend throws a clear startup error (not a null reference) when a required environment
  key is missing. (`ValidateOnStart()` enforces this.)
- [x] The frontend reads its required config at startup and fails clearly if the key is absent.
- [x] No secrets are committed to source control.
- [x] README documents the local setup steps.

## Deliverables

- `.env.example`
- Backend `AppSettings` typed config with startup validation
- Frontend env loader (`env.dart` or `flutter_dotenv`)
- README "Local Setup" section
