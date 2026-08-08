# STORY-002 · Add Shared Environment Configuration

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add a shared environment configuration pattern for local development so both the backend and
frontend read required values from a single source and fail immediately on startup if anything
is missing.

## Implementation Steps

- [ ] Create `.env.example` at the repository root with all required keys, placeholder values, and
  a comment for each explaining what it is and where to get the real value:
  ```
  # Backend database
  DATABASE_URL=postgresql://atlas:atlas@localhost:5432/atlas_dev

  # Backend JWT
  JWT_SECRET=change-me-local-only
  JWT_ISSUER=atlas-local
  JWT_AUDIENCE=atlas-app

  # Backend app
  ASPNETCORE_ENVIRONMENT=Development
  ASPNETCORE_URLS=http://localhost:5000

  # Frontend API base
  API_BASE_URL=http://localhost:5000/api/v1
  ```
- [ ] Add `.env` to `.gitignore` so real local secrets are never committed.
- [ ] For the backend: bind `IConfiguration` to a typed `AppSettings` class in `Atlas.Shared`.
  Validate required keys at startup using `IOptions<T>` with data annotations or manual guards.
  The app must throw a clear error (not `NullReferenceException`) if a required key is missing.
- [ ] For the frontend: add a `lib/core/env/env.dart` (or use `flutter_dotenv`) that reads the
  API base URL at startup. Fail fast with a readable message if the required key is absent.
- [ ] Document which keys are required for local development versus optional (e.g., push notification
  keys are optional until Week 09).

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
- [ ] Confirm the sample environment file is readable and the documented keys match the actual config
  bindings in code.

## Documentation

- [ ] Add a "Local Setup" section to the README: copy `.env.example` → `.env`, fill in the values,
  run the app.
- [ ] Note which keys are optional and what behavior changes when they are absent.

## Acceptance Criteria

- [ ] `.env.example` exists at the repository root with all required keys documented.
- [ ] The backend throws a clear startup error (not a null reference) when a required environment
  key is missing.
- [ ] The frontend reads its required config at startup and fails clearly if the key is absent.
- [ ] No secrets are committed to source control.
- [ ] README documents the local setup steps.

## Deliverables

- `.env.example`
- Backend `AppSettings` typed config with startup validation
- Frontend env loader (`env.dart` or `flutter_dotenv`)
- README "Local Setup" section
