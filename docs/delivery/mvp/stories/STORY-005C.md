# STORY-005C · Set Up Database and Migration Tooling

Epic: [epic-01-foundation](../epics/epic-01-foundation.md)
Estimate: 3 hrs
Priority: High
Status: Done

## Objective

Configure the database layer so the backend can connect to PostgreSQL locally and all future
schema changes are tracked through EF Core migrations.

## Context

This story wires up the data foundation. Every subsequent story that touches persistence depends
on these conventions being correct from the start. Retrofitting naming conventions, PK strategies,
or migration structure after entities have been written is expensive.

## Implementation Steps

- [x] Add a `docker-compose.yml` at the repository root with a PostgreSQL service suitable for local development.
- [x] Configure `Atlas.Infrastructure` with the EF Core DbContext (`AtlasDbContext`) and connection string binding from environment config.
- [x] Apply `UseSnakeCaseNamingConvention()` globally so all table and column names follow snake_case without per-entity mapping.
- [x] Configure UUID v7 or ULID as the default primary key generation strategy for all entities.
- [x] Configure all timestamps to use `TIMESTAMP WITH TIME ZONE` (UTC).
- [x] Add the `dotnet-ef` tool reference to the backend project so `dotnet ef migrations add` works out of the box.
- [x] Create the initial empty migration (`InitialCreate`) to prove the tooling works end-to-end.
- [x] Add `make db-up`, `make db-migrate`, and `make db-reset` (or equivalent) scripts to the root workspace so a developer can bootstrap the database in one command.

## Technical Notes

- `UseSnakeCaseNamingConvention()` comes from the `EFCore.NamingConventions` NuGet package.
- UUID v7 generation requires either a custom value generator or a library (e.g., `UUIDNext`).
  Wire it as the default in `OnModelCreating` so no entity has to specify it explicitly.
- The `AtlasDbContext` at this stage should have no entity `DbSet`s — it is a skeleton that
  future modules extend via partial classes or `IEntityTypeConfiguration<T>`.
- Do not apply production connection strings. The sample env file (STORY-002) holds the local
  PostgreSQL connection string.
- The initial migration should generate an empty schema — this confirms the tooling round-trips
  correctly before any real entities exist.

## Tests

- [x] Run `dotnet ef database update` against the local Docker PostgreSQL instance and confirm it applies without errors.
- [x] Confirm the initial migration file is generated and committed to source control under `backend/src/Atlas.Infrastructure/Migrations/`.

## Documentation

- [x] Document the `docker-compose.yml` services and local database setup steps in the repository README.
- [x] Document the migration commands (`dotnet ef migrations add`, `dotnet ef database update`) in the contributing or engineering notes.

## Acceptance Criteria

- [x] `docker-compose up -d` starts a PostgreSQL instance with the correct database and credentials.
- [x] `dotnet ef database update` applies the initial migration cleanly against the local database.
- [x] All EF Core column names are snake_case (verified by inspecting the generated migration SQL).
- [x] Primary key strategy is UUID v7 or ULID (configured globally, not per-entity).
- [x] All timestamp columns are `timestamp with time zone` in the migration SQL.
- [x] The `dotnet-ef` tool is resolvable without global installation (`dotnet tool restore`).

## Deliverables

- `docker-compose.yml` with PostgreSQL service
- `AtlasDbContext` skeleton in `Atlas.Infrastructure`
- EF Core naming and PK conventions wired globally
- Initial empty migration committed to source control
- Database bootstrap scripts / Makefile targets
- README section documenting local database setup
