# Architecture

This document is the short entrypoint for high-level system design and decisions.

The detailed architecture guidance lives in [docs/03-engineering/architecture.md](docs/03-engineering/architecture.md).

## Resolved Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Architectural style | Modular Monolith | Fastest to deliver, debug, test; can evolve to microservices later |
| Backend runtime | ASP.NET Core / C# — **.NET 10 LTS** | Performance, type safety, mature ecosystem; LTS for stability |
| Frontend | Flutter (mobile-first) — **stable channel** | Cross-platform, single codebase, strong UI toolkit |
| Frontend routing | **go_router** | Declarative, deep-link capable, well-maintained Flutter routing package |
| Primary database | PostgreSQL | Relational integrity, JSON support, scalable |
| Cache | Redis | Leaderboards, sessions, rate limiting |
| ORM | Entity Framework Core | Type-safe queries; Dapper only for profiled bottlenecks |
| Auth (MVP) | Email/password + JWT | Short-lived access (15–60 min) + refresh token rotation (30 days) |
| Auth (future) | OAuth 2.0, Passkeys, SSO | Deferred to v2.0+ per product requirements |
| API style | REST + JSON | Versioned (`/api/v1/`), OpenAPI documented |
| CI platform | **GitHub Actions** | Integrated with the GitHub repository; no additional tooling required |
| Background jobs | Hangfire | Notifications, scheduled tasks, AI pipelines |
| Logging | Serilog (structured JSON) | Correlatable, searchable production logs |
| Monitoring | OpenTelemetry | Metrics, tracing, health checks |
| Data strategy | Event-rich CRUD hybrid | Append-only performance ledger + mutable operational state |
| Storage | S3-compatible object storage | Media, exports, AI assets |

## Key Constraints

- Domain layer is framework-agnostic (no HTTP, no DB, no Redis).
- Dependencies always point inward (Clean Architecture).
- Completed workout data is immutable (corrections via compensating events).
- AI recommendations store rationale, confidence, and user response.
- No premature microservices, CQRS everywhere, or event sourcing everywhere.

## Focus

- System boundaries and layering
- Backend and frontend interaction model
- Data, infrastructure, and integration decisions
- Constraints that affect MVP implementation

## Related References

- [docs/03-engineering/backend.md](docs/03-engineering/backend.md)
- [docs/03-engineering/frontend.md](docs/03-engineering/frontend.md)
- [docs/03-engineering/database.md](docs/03-engineering/database.md)
- [docs/03-engineering/api-guidelines.md](docs/03-engineering/api-guidelines.md)