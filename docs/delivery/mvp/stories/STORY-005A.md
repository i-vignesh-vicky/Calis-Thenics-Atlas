# STORY-005A · Add CI Workflow for Main and Pull Requests

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add a minimal CI pipeline that runs on every pull request and every push to the main branch,
proving the repository builds, tests pass, and nothing is broken before code is merged.

## Implementation Steps

- [ ] Add a GitHub Actions workflow file at `.github/workflows/ci.yml`.
- [ ] The workflow triggers on `push` to `main` and `pull_request` to `main`.
- [ ] CI steps (in order):
  1. Checkout repository
  2. Install .NET 10 SDK (`actions/setup-dotnet@v4` with `dotnet-version: '10.x'`)
  3. Install Flutter stable channel (`subosito/flutter-action@v2` with `channel: stable`)
  4. Restore backend dependencies (`dotnet restore`)
  5. Build backend (`dotnet build --no-restore --configuration Release`)
  6. Run backend tests (`dotnet test --no-build`)
  7. Install Flutter dependencies (`flutter pub get`)
  8. Build Flutter (`flutter build apk --debug` or `flutter analyze`)
  9. Run Flutter tests (`flutter test`)
- [ ] The workflow must fail if any step exits with a non-zero code.
- [ ] Add a CI status badge to the root README pointing to the workflow run.

## Technical Notes

- Pin SDK versions explicitly in the workflow (`dotnet-version`, `flutter-version`) using the same
  versions documented in the README prerequisites. Drift between local and CI is a common first-week
  failure mode.
- Use GitHub Actions secrets for any environment values needed by tests (connection strings, JWT keys).
  Do not hard-code secrets in the workflow file.
- Keep the initial workflow narrow — only what is needed to verify the skeleton. It grows as features
  are added.
- The workflow file is the CI contract. Any change to required SDK versions must update both the
  README and this file at the same time.

## Tests

- [ ] Push a sample branch and confirm the workflow runs and passes in GitHub Actions.
- [ ] Introduce a deliberate build error, push, and confirm the workflow fails and reports the error clearly.

## Documentation

- [ ] Document the workflow purpose, branch triggers, and expected failure behavior in a comment
  block at the top of `ci.yml`.
- [ ] Add the CI badge to the root README.

## Acceptance Criteria

- [ ] CI runs on every pull request and every push to main.
- [ ] Backend build, backend tests, Flutter analyze, and Flutter tests all run in CI.
- [ ] SDK versions are pinned and match the README prerequisites.
- [ ] The workflow fails loudly and clearly when a step breaks.
- [ ] A CI status badge is visible in the README.

## Deliverables

- `.github/workflows/ci.yml`
- CI status badge in README
- Workflow documentation comment
