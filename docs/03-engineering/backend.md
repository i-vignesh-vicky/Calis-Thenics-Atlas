# Backend Architecture

## Purpose

The backend is the foundation of Calis-Thenics-Atlas. It is responsible for:

- Modeling the fitness domain accurately
- Enforcing business rules and constraints
- Managing user data safely and reliably
- Orchestrating AI capabilities
- Exposing a secure, intuitive API consumed by Flutter clients

The backend must prioritize **maintainability, correctness, and extensibility** over premature optimization. Every decision should align with the long-term vision of supporting millions of users while remaining understandable to a small team.

---

## Technology Stack

### Runtime: ASP.NET Core

**Why:**
- High performance
- Mature, proven ecosystem
- Excellent tooling and IDE support
- Strong static typing
- Cross-platform support
- Enterprise-grade reliability

### Language: C#

**Why:**
- Modern language with excellent async/await support
- Strong type safety reduces bugs
- Productive developer experience
- Extensive standard library

### Database: PostgreSQL

**Why:**
- Rich relational model with JSON support
- ACID compliance ensures data integrity
- Scalable and reliable
- Excellent for complex queries required by AI features

### ORM: Entity Framework Core

- Primary ORM for all database access
- Use Dapper or raw SQL **only** when profiling identifies genuine performance bottlenecks
- Prefer LINQ for type safety and maintainability

### Authentication & Authorization

**Mechanisms:**
- JWT with short-lived access tokens
- Refresh tokens with rotation
- HTTPS mandatory for all tokens
- OAuth 2.0 integration (Google, Apple)

**Future:**
- Passkeys
- Enterprise SSO

### Cache: Redis

**Uses:**
- Leaderboards and competitive rankings
- Session management
- Frequently accessed user data
- Rate limiting
- Temporary job state
- Real-time features (future)

### Storage: S3-Compatible Object Storage

**Stores:**
- User images and media
- Videos (if applicable)
- AI-generated assets
- Documents and exports

### Background Jobs: Hangfire

**Uses:**
- Email and push notifications
- Scheduled tasks and reports
- Weekly digest generation
- AI processing pipelines
- Data cleanup and maintenance

### Logging: Serilog

- All logs must be structured (JSON format)
- Includes context: request ID, user ID, module name, timestamp
- Integration with centralized logging solution

### Monitoring: OpenTelemetry

- Metrics collection and visualization
- Distributed tracing for request flows
- Health check endpoints for all critical services

### API Format: REST

- JSON-based request/response
- API versioning (e.g., `/api/v1/...`)
- OpenAPI (Swagger) documentation required for all endpoints

---

## Architecture Overview

```
Flutter Mobile Client
        ↓
    REST API Layer
        ↓
    Application Layer
    (Commands, Queries, Handlers)
        ↓
    Domain Layer
    (Business Rules, Entities)
        ↓
    Infrastructure Layer
    (Data Access, External Services)
        ↓
PostgreSQL | Redis | Object Storage
```

---

## Architectural Pattern: Modular Monolith

**Style:** Modular Monolith with Clean Architecture and Domain-Driven Design

**Why not Microservices?**
- Simpler deployment and operational burden
- Faster feedback loop during development
- Easier testing and debugging
- Lower infrastructure cost for an early-stage startup
- Easier to maintain consistency and transactional integrity
- **Can evolve into microservices later if justified**

The monolith is organized into independent modules that communicate through well-defined interfaces, making future separation straightforward if needed.

---

## Project Structure

```
src/
  Atlas.Api/              # REST endpoints, controllers, middleware
  Atlas.Application/      # Use cases, commands, queries, handlers
  Atlas.Domain/           # Business logic, entities, value objects
  Atlas.Infrastructure/   # Data access, external integrations, services
  Atlas.Contracts/        # DTOs, request/response models, shared contracts
  Atlas.Shared/           # Common utilities, constants, extensions

tests/
  Atlas.UnitTests/        # Domain and business logic tests
  Atlas.IntegrationTests/ # Database, API, and service integration tests
  Atlas.ArchitectureTests/ # Structural and dependency rules
```

---

## Module Organization

Organize by **business capability**, not by technical type.

```
Modules/
  Auth/
    Commands/
    Queries/
    Services/
    Handlers/
    Tests/
    
  Users/
  Workouts/
  Programs/
  Routines/
  Exercises/
  Skills/
  Progress/
  Consistency/
  Social/
    Comments/
    Likes/
    Follows/
  Notifications/
  Analytics/
  AI/
```

Each module owns its own:
- Commands and queries
- Domain entities and value objects
- Validators and business logic
- Service implementations
- Repository implementations
- Unit and integration tests
- Database migrations

Avoid large shared "Service" or "Manager" classes. Favor cohesive, focused modules.

---

## API Design Philosophy

The backend is fundamentally **API-first**. Principles:

- **Consistent:** Predictable naming, structure, and behavior
- **Versioned:** Allow evolution without breaking clients
- **Stateless:** Each request is independent; session state in JWT
- **Secured:** Authentication and authorization on every endpoint
- **Well-documented:** OpenAPI/Swagger specification required
- **Paginated:** Large collections return paginated results
- **Filterable:** Support filtering by relevant attributes
- **Sortable:** Allow clients to control result ordering

See [api-guidelines.md](api-guidelines.md) for detailed standards.

---

## Domain-First Design

Business logic belongs exclusively in the **Domain Layer**.

Examples of domain logic:
- Workout completion and validation
- Skill progression and unlocking
- Milestone achievement calculations
- Consistency streak calculations
- Recovery score estimation
- AI recommendation logic

**Controllers and services coordinate business logic; they never implement it.**

The domain layer must be completely independent of HTTP, databases, and frameworks.

---

## Data-First Philosophy

Every feature should ask: **"What useful data does this generate?"**

Example workflow:
```
User completes workout
    ↓
Generate progress record
    ↓
Estimate recovery time
    ↓
Recalculate consistency score
    ↓
Check milestone thresholds
    ↓
Feed data to AI for future recommendations
```

The database captures meaningful user progress without collecting unnecessary personal data. Data is a competitive advantage for AI features.

---

## Performance Principles

**Optimize only after measuring.**

Priority order:
1. **Correctness** — Business rules enforced accurately
2. **Readability** — Code is clear and maintainable
3. **Simplicity** — Fewest dependencies, straightforward logic
4. **Performance** — Optimize when profiling identifies bottlenecks

Premature optimization is forbidden.

Optimization is only justified with:
- Profiling data showing the bottleneck
- Measurements showing the improvement
- Understanding of trade-offs (e.g., added complexity)

---

## Security

All backends must enforce:

- ✓ JWT authentication with short-lived tokens
- ✓ Refresh token rotation
- ✓ Role-based access control (RBAC)
- ✓ Input validation on all endpoints
- ✓ Rate limiting to prevent abuse
- ✓ HTTPS only (never HTTP)
- ✓ Secure password hashing (Argon2 or bcrypt)
- ✓ Audit logging for sensitive actions
- ✓ Principle of least privilege for database access
- ✓ No sensitive data in logs
- ✓ CORS configuration aligned with frontend domain

See [security.md](security.md) for detailed security guidelines.

---

## Observability

Every critical action must be observable in production.

**Required Metrics:**
- API endpoint latency (p50, p95, p99)
- Error rates and error types
- Background job failures and execution time
- Database query performance
- Cache hit rates
- Authentication failures
- User activity summaries

**Required Logs:**
- Request start/completion with latency
- Errors with full stack traces
- Background job execution
- Database migrations
- External service calls and failures
- Business events (user creation, milestone unlock, etc.)

See [observability.md](observability.md) for detailed standards.

---

## Testing Strategy

Follow the testing pyramid:

```
        E2E Tests (5%)
    Integration Tests (25%)
      Unit Tests (70%)
```

- **Unit Tests:** Validate domain logic in isolation
- **Integration Tests:** Verify module interactions and database access
- **Architecture Tests:** Enforce structural rules and layer boundaries
- **End-to-End Tests:** Critical user workflows only

Coverage is important, but **meaningful tests matter more than percentages**.

See [testing.md](testing.md) for detailed testing strategy.

---

## Evolution & Scaling Strategy

### Phase 1: MVP (Monolith)
- Single modular monolith
- PostgreSQL for all data
- Redis for caching
- REST API
- Hangfire for background jobs

### Phase 2: Growth (Scale-out)
- Read replicas for database scaling
- Elasticsearch for full-text search
- CDN for static assets
- Enhanced caching strategies
- Dedicated logging/monitoring infrastructure

### Phase 3: Scale (Distributed)
- Event streaming (Kafka/RabbitMQ) if needed
- Dedicated AI services
- Horizontal scaling of API servers
- Advanced analytics warehouse
- Multi-region deployment

**Principle:** Only introduce complexity when driven by real, measured needs—never by speculation about future scale.

---

## What We Explicitly Will NOT Do

Defining constraints is as important as defining features. For the MVP and growth phase, we will **not**:

- ✗ Prematurely build microservices
- ✗ Introduce Kubernetes without operational maturity
- ✗ Implement CQRS everywhere (only where justified)
- ✗ Adopt event sourcing without clear requirements
- ✗ Optimize for millions of users before validating product-market fit
- ✗ Let technical trends dictate architecture
- ✗ Add unnecessary abstraction layers

This clarity prevents the project from accumulating technical debt driven by "what if" scenarios.

---

## Engineering Principles

Every contribution to the backend must satisfy:

1. **SOLID Principles** — Especially SRP, DIP, and OCP
2. **Clean Code** — Clear naming, small functions, obvious intent
3. **Separation of Concerns** — Each layer has one responsibility
4. **Domain-Driven Design** — Business concepts modeled accurately
5. **High Cohesion** — Related logic belongs together
6. **Low Coupling** — Modules don't depend on implementation details
7. **Testability** — Code can be tested in isolation
8. **Observability** — Important actions produce observable signals
9. **Backward Compatibility** — API changes consider existing clients
10. **Documentation** — Non-obvious decisions are documented
