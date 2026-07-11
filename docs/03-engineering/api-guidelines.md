# API Design Guidelines

## Purpose

This document defines standards, conventions, and best practices for designing and implementing APIs across Calis-Thenics-Atlas.

APIs are the public contract between the backend and its consumers. Once published, changing an API becomes expensive and breaks clients. Therefore, **design APIs deliberately**.

The goal is to create APIs that are intuitive, consistent, versionable, secure, and easy to evolve without breaking clients.

---

## API Philosophy

The API is the interface between backend and consumers:

- Mobile app (Flutter)
- Future web app
- Admin portal
- AI services
- Third-party integrations
- Wearables (future)

### Design Principle

**APIs should model business capabilities, not database tables.**

Bad API design exposes database structure. Good API design exposes business behavior.

---

## Guiding Principles

Every API must be:

1. **Consistent** — Predictable naming, structure, behavior
2. **Predictable** — Users can infer patterns
3. **Discoverable** — Self-documenting through conventions
4. **Backward Compatible** — Client evolution doesn't break servers
5. **Business-Oriented** — Models real user workflows
6. **Secure** — Requires authentication/authorization
7. **Well-Documented** — OpenAPI/Swagger specification required

---

## Resource Naming

Use **nouns**, not verbs. HTTP methods describe the action.

### Good Examples

```
GET    /users
POST   /users
GET    /users/{id}
GET    /workouts
POST   /workouts
GET    /workouts/{id}
GET    /routines
GET    /programs/{id}/exercises
POST   /skills/{id}/unlock
GET    /timeline
POST   /challenges/{id}/join
```

### Bad Examples

```
GET    /getUser
POST   /createUser
POST   /updateWorkout
POST   /deleteWorkout
GET    /fetchRoutines
POST   /joinChallenge
```

### Resource Hierarchy

Keep URLs simple and flat:

**Good:**
```
GET /workouts/{id}
GET /workouts?createdAfter=2025-01-01
```

**Avoid excessive nesting:**
```
❌ GET /users/123/workouts/456/exercises/789/sets/1000
✓ GET /workout-exercises/{id}  (with links to related resources)
```

Query related resources separately. Use link relationships or include parameters.

---

## Business Actions (Non-CRUD)

Some operations are not standard CRUD. Use domain verbs in the URL:

**Examples:**

Instead of:
```
POST /workouts/{id}
{ "status": "completed" }
```

Use:
```
POST /workouts/{id}/complete
{}
```

Instead of:
```
POST /skills
{ "action": "unlock" }
```

Use:
```
POST /skills/{id}/unlock
{}
```

Domain-specific actions clarify intent:
```
POST /challenges/{id}/join
POST /routines/{id}/activate
POST /milestones/{id}/claim
POST /workouts/{id}/pause
```

---

## HTTP Methods

| Method | Purpose | Idempotent | Has Body |
|--------|---------|-----------|----------|
| GET | Retrieve resource(s) | Yes | No |
| POST | Create resource or perform action | No | Yes |
| PUT | Replace entire resource | Yes | Yes |
| PATCH | Partial update | No | Yes |
| DELETE | Remove resource | Yes | No |

### Guidelines

- **GET** — Retrieve data, no side effects
- **POST** — Create resources OR perform business actions
- **PUT** — Replace entire resource (include all fields)
- **PATCH** — Partial updates (only provided fields)
- **DELETE** — Remove resource (may be soft delete)

Do not misuse POST for simple reads.

---

## URL Structure

### Path Format

```
/api/v1/{resource}/{id}/{sub-resource}
```

### Query Parameters

Use query parameters for:
- Filtering: `?status=completed`
- Sorting: `?sort=createdAt`
- Pagination: `?page=1&pageSize=20`
- Searching: `?search=push`
- Including related data: `?include=exercises,comments`

### Examples

```
GET /api/v1/workouts
GET /api/v1/workouts?status=completed&sort=-createdAt
GET /api/v1/workouts/{id}
GET /api/v1/workouts/{id}/exercises
GET /api/v1/users/{id}/programs?include=exercises
GET /api/v1/workouts?createdAfter=2025-01-01&createdBefore=2025-01-31
```

---

## Versioning

### Strategy

Version APIs only when **breaking changes** are necessary.

```
/api/v1/  ← Current production version
/api/v2/  ← If breaking changes required
```

### Breaking vs. Non-Breaking

**Breaking:**
- ✗ Removing a field
- ✗ Changing field type
- ✗ Changing required fields
- ✗ Changing behavior

**Non-Breaking:**
- ✓ Adding optional field
- ✓ Adding new endpoint
- ✓ Adding query parameter
- ✓ Expanding enum values

### Deprecation

Before removing an API version:
1. Announce deprecation date (90+ days notice)
2. Provide migration guide
3. Monitor usage
4. Sunset on announced date

---

## Request Format

### Request Body

Include only data required for the operation.

**Example:**
```json
{
  "name": "Push Day",
  "description": "Upper body strength focus",
  "exercises": [
    { "id": "ex-123", "sets": 4, "reps": 8 }
  ]
}
```

### Forbidden in Requests

Never accept from clients:
- ✗ `createdAt`, `updatedAt` timestamps
- ✗ Internal IDs for generated values
- ✗ Audit fields (`createdBy`, `updatedBy`)
- ✗ Server-calculated values (`totalVolume`, `maxWeight`)
- ✗ Status fields that should be controlled by business logic

### Content-Type

Always use:
```
Content-Type: application/json
```

---

## Response Format

### Standard Response Structure

```json
{
  "data": { ... },
  "meta": {
    "timestamp": "2025-01-15T10:30:00Z",
    "correlationId": "req-abc-123"
  }
}
```

### Collection Response

```json
{
  "data": [ ... ],
  "meta": {
    "page": 1,
    "pageSize": 20,
    "totalItems": 150,
    "totalPages": 8,
    "hasMore": true
  }
}
```

### Single Resource Response

```json
{
  "data": {
    "id": "workout-123",
    "name": "Monday Push",
    "duration": 45,
    "exercises": [ ... ],
    "createdAt": "2025-01-15T10:30:00Z"
  },
  "meta": {
    "timestamp": "2025-01-15T10:30:00Z"
  }
}
```

---

## HTTP Status Codes

### Success Codes

| Code | When | Example |
|------|------|---------|
| 200 | Successful GET, PUT, PATCH | Retrieve workout |
| 201 | Successful POST (created) | Created new routine |
| 202 | Async action queued | Background processing |
| 204 | Successful DELETE | Resource deleted |

### Client Error Codes

| Code | When | Example |
|------|------|---------|
| 400 | Invalid request | Missing required field |
| 401 | Not authenticated | Missing JWT token |
| 403 | Not authorized | User can't access resource |
| 404 | Resource not found | Workout doesn't exist |
| 409 | Conflict | Duplicate routine name |
| 422 | Validation failed | Email invalid |

### Server Error Codes

| Code | When | Example |
|------|------|---------|
| 500 | Unexpected error | Database crash |
| 503 | Service unavailable | Maintenance |

---

## Error Responses

Errors should follow a consistent format:

```json
{
  "error": {
    "code": "WORKOUT_NOT_FOUND",
    "message": "The workout with ID 'abc-123' does not exist.",
    "details": [
      {
        "field": "workoutId",
        "issue": "Resource not found"
      }
    ],
    "traceId": "trace-xyz",
    "timestamp": "2025-01-15T10:30:00Z"
  }
}
```

### Error Code Guidelines

- Use **UPPER_SNAKE_CASE** for error codes
- Make codes **programmer-friendly** (for code)
- Make messages **user-friendly** (for humans)

**Example:**

```json
{
  "error": {
    "code": "INVALID_EMAIL_FORMAT",
    "message": "The email address format is invalid. Please check and try again."
  }
}
```

Clients should:
- Switch on `code` for logic
- Display `message` to users

---

## Pagination

Large collections must be paginated.

### Offset-Based Pagination

For standard queries:

```
GET /api/v1/workouts?page=2&pageSize=20
```

Response includes:
```json
{
  "data": [ ... ],
  "meta": {
    "page": 2,
    "pageSize": 20,
    "totalItems": 500,
    "totalPages": 25,
    "hasMore": true
  }
}
```

### Cursor-Based Pagination

For large datasets (activity feeds, comments):

```
GET /api/v1/timeline?limit=20&cursor=abc123
```

Response:
```json
{
  "data": [ ... ],
  "meta": {
    "nextCursor": "def456",
    "hasMore": true
  }
}
```

---

## Filtering

Use query parameters for filtering:

```
GET /api/v1/workouts?status=completed
GET /api/v1/workouts?createdAfter=2025-01-01
GET /api/v1/workouts?difficulty=advanced&type=strength
```

### Common Filters

- `status` — Filter by status
- `createdAfter` / `createdBefore` — Date range
- `type` — Category filter
- `search` — Text search
- `tags` — Multiple values

---

## Sorting

Use query parameter for ordering:

```
GET /api/v1/workouts?sort=createdAt
GET /api/v1/workouts?sort=-createdAt  (descending)
GET /api/v1/workouts?sort=difficulty,createdAt
```

### Convention

- Default: ascending order
- Prefix `-` for descending (e.g., `-createdAt`)
- Multiple sort fields comma-separated

---

## Partial Responses (Include)

Allow clients to request specific fields:

```
GET /api/v1/workouts/{id}?include=exercises,comments
```

Reduces payload for mobile clients.

---

## Caching

### Cache Headers

```
GET /api/v1/exercises  (cacheable)
Cache-Control: public, max-age=3600

GET /api/v1/workouts/{id}  (user-specific, not public cache)
Cache-Control: private, max-age=300

POST /api/v1/workouts  (not cacheable)
Cache-Control: no-cache, no-store
```

### ETag Support

Support ETags for efficient updates:

```
Response:
ETag: "33a64df551425fcc55e4d42a148795d9f25f89d4"
Cache-Control: max-age=60

Client (next request):
If-None-Match: "33a64df551425fcc55e4d42a148795d9f25f89d4"

Response:
304 Not Modified  (use cached version)
```

---

## Rate Limiting

Include rate limit headers in responses:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1234567890
```

When limit exceeded:
```
429 Too Many Requests

{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please retry after 60 seconds."
  }
}
```

---

## API Documentation

Every API must include:

- **OpenAPI Specification (Swagger)** — Machine-readable contract
- **README** — High-level overview
- **Examples** — Request/response examples
- **Error Documentation** — All possible error codes
- **Authentication** — How to authenticate
- **Rate Limits** — Limits per endpoint

---

## Backward Compatibility

### When Adding Features

✓ Add optional fields
✓ Add new endpoints
✓ Expand enum values
✓ Add query parameters

### When Removing Features

✗ Remove required fields
✗ Remove endpoints
✗ Change field types
✗ Change endpoint behavior

Maintain compatibility for 1-2 API versions.

---

## Security in APIs

- ✓ Require authentication (JWT token)
- ✓ Require authorization (check user owns resource)
- ✓ Validate all input
- ✓ Enforce rate limiting
- ✓ Use HTTPS only
- ✓ Don't expose internal errors
- ✓ Log security events
- ✓ Include CORS headers appropriately

---

## API Design Checklist

Before publishing an API:

- ✓ Does the URL clearly represent the resource?
- ✓ Does the HTTP method match the action?
- ✓ Are required fields documented?
- ✓ Are possible error codes documented?
- ✓ Is the response format consistent?
- ✓ Is pagination supported (if applicable)?
- ✓ Is filtering supported (if applicable)?
- ✓ Is rate limiting configured?
- ✓ Is authentication/authorization required?
- ✓ Is the API documented in OpenAPI?

---

## Evolution Over Time

APIs should evolve gracefully:

**Today:** Core CRUD + business actions
**Growth:** Filtering, sorting, search
**Scale:** Async operations, webhooks
**Maturity:** GraphQL variant, custom query language
GET /workouts?status=completed

GET /skills?level=beginner

GET /posts?tag=mobility
```

Do not create separate endpoints for every filter combination.

---

# 13. Sorting

Support explicit sorting.

Example:

```text
GET /timeline?sort=createdAt,desc

GET /leaderboard?sort=score,desc
```

Never rely on implicit ordering.

---

# 14. Idempotency

Operations should behave predictably.

Safe operations:

* GET
* PUT
* DELETE

Business actions that may be retried (e.g., payment, subscription purchase) should support idempotency keys where appropriate.

---

# 15. Validation

Validate all input.

Reject:

* Invalid types
* Missing required fields
* Negative values where not allowed
* Invalid enums
* Malformed payloads

Return clear validation errors.

---

# 16. Authentication

Protected endpoints require authentication.

Use JWT access tokens.

Sensitive operations should verify user ownership.

Never trust client-supplied user identifiers.

---

# 17. Authorization

Authentication answers:

> Who are you?

Authorization answers:

> Are you allowed to do this?

Every endpoint should enforce appropriate authorization checks.

---

# 18. API Documentation

Every endpoint should document:

* Purpose
* Request schema
* Response schema
* Error codes
* Authentication requirements
* Example requests
* Example responses

OpenAPI (Swagger) should be generated from code where possible.

---

# 19. Performance

APIs should return only what clients need.

Avoid over-fetching.

Support selective expansion only when justified.

Large payloads increase latency and battery usage.

---

# 20. Rate Limiting

Protect public endpoints from abuse.

Examples:

* Login
* Password reset
* OTP requests
* AI endpoints
* Search

Different limits may apply based on endpoint sensitivity.

---

# 21. Long-Running Operations

Operations expected to take significant time (e.g., AI analysis, report generation) should be asynchronous.

Pattern:

1. Client submits request.
2. Server returns an operation ID.
3. Client polls or receives a notification upon completion.

Do not keep HTTP requests open unnecessarily.

---

# 22. File Uploads

Large files (e.g., profile photos, exercise videos, future form-analysis clips) should be uploaded directly to object storage using pre-signed URLs.

The backend should issue upload permissions rather than proxying large files whenever possible.

---

# 23. API Evolution

Prefer additive changes.

Safe changes:

* New optional fields
* New endpoints
* Additional enum values (with care)

Avoid:

* Removing fields
* Renaming fields
* Changing field types
* Changing endpoint behavior unexpectedly

---

# 24. Consistency Rules

Maintain consistency in:

* Naming
* Date formats (ISO 8601)
* Time zones (UTC internally)
* Boolean naming (`isCompleted`, `isPremium`)
* Enum values
* Error structures
* Pagination

Consistency reduces cognitive load for both developers and AI coding assistants.

---

# 25. API Principles Checklist

Before exposing a new endpoint, ask:

* Does it represent a business capability?
* Is the naming intuitive?
* Is it secure?
* Is the response minimal but sufficient?
* Can it evolve without breaking clients?
* Is validation comprehensive?
* Is the documentation complete?

If any answer is "no", revisit the design.

---

# Technical Architect Notes

An API is not just a transport layer—it is a **contract**. Every poorly designed endpoint becomes technical debt that affects every client application.

As we build this platform, our APIs should tell the story of the business. When someone reads `POST /workouts/{id}/complete`, they immediately understand the intent. They don't need to know how the database is structured.

One final principle I want us to adopt for this project:

> **Optimize APIs for the domain, not for today's UI.**

Screens will change. Mobile apps will evolve. AI services will be added. But a well-designed domain API can serve all of them for years without major redesign. This mindset will give your platform the flexibility it needs to grow from an MVP into the intelligent fitness ecosystem you've envisioned.
