# Conventions

This document is the short entrypoint for naming, folder structure, API patterns, testing strategy, and coding conventions.

The detailed engineering guidance lives in [docs/03-engineering](docs/03-engineering).

## Code Organization

- Organize by **business capability first**, then by technical concern.
- Each module owns: commands, queries, domain entities, validators, repositories, tests, migrations.
- No large shared "Services", "Managers", or "Utilities" folders.

## Naming

| Context | Convention | Example |
|---------|-----------|---------|
| C# classes/types | PascalCase descriptive nouns | `WorkoutSession`, `SkillUnlocker` |
| C# methods | PascalCase imperative verbs | `CompleteWorkout()`, `CalculateVolume()` |
| C# variables | camelCase intention-revealing | `completedWorkout`, `totalVolume` |
| Constants | UPPER_SNAKE_CASE | `MAX_WORKOUT_DURATION_MINUTES` |
| DB tables | snake_case plural | `workout_sessions`, `workout_sets` |
| DB columns | snake_case | `created_at`, `user_id` |
| API URLs | kebab-case plural nouns | `/api/v1/workout-sessions` |
| Feature folders | kebab-case | `01-identity-and-access/` |

## API Patterns

- REST + JSON, versioned (`/api/v1/...`).
- Resource-oriented URLs (nouns), HTTP verbs for actions.
- Domain actions as sub-resource verbs: `POST /workouts/{id}/complete`.
- Standard pagination: `?page=1&pageSize=20`.
- Consistent error response envelope with error code and message.

## Testing Strategy

- 70% unit (domain logic, fast, no I/O).
- 25% integration (services, DB, module interactions).
- 5% E2E (critical user journeys only).
- Test behavior, not implementation details.
- Architecture tests enforce layer boundaries.

## Key Principles

- SOLID everywhere, especially SRP and DIP.
- Clean Architecture: dependencies always point inward.
- Domain layer knows nothing about HTTP, DB, or frameworks.
- Prefer composition over inheritance.
- Methods under 30 lines; one level of abstraction per method.
- Immutable value objects; entities protect their invariants.

## Focus

- Naming and code organization
- Folder and module structure
- API design and request/response patterns
- Testing strategy and quality expectations
- Coding conventions that keep the codebase consistent

## Related References

- [docs/03-engineering/coding-standards.md](docs/03-engineering/coding-standards.md)
- [docs/03-engineering/api-guidelines.md](docs/03-engineering/api-guidelines.md)
- [docs/03-engineering/testing.md](docs/03-engineering/testing.md)
- [docs/03-engineering/frontend.md](docs/03-engineering/frontend.md)
- [docs/03-engineering/backend.md](docs/03-engineering/backend.md)