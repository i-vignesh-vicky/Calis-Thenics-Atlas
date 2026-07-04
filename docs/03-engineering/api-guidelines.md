Perfect. From this point onward, we stop talking about architecture in general and start defining **engineering contracts**.

This is one of the most important documents Claude Code (or any AI coding assistant) will repeatedly consult while generating APIs.

A good API guideline prevents thousands of inconsistent decisions.

---

# `03-engineering/api-guidelines.md`

# API Design Guidelines

> **Purpose**
>
> This document defines the standards, conventions, and best practices for designing and implementing APIs across the platform.
>
> The goal is to create APIs that are intuitive, consistent, versionable, secure, and easy to evolve without breaking clients.
>
> APIs should model business capabilities rather than database tables.

---

# 1. API Philosophy

The API is the public contract between the backend and its consumers.

Consumers may include:

* Mobile App
* Web App
* Admin Portal
* AI Services
* Third-party Integrations
* Future Wearables

Once an API is published, changing it becomes expensive.

Therefore:

> **Design APIs deliberately.**

---

# 2. Guiding Principles

Every API should be:

* Consistent
* Predictable
* Discoverable
* Backward compatible
* Business-oriented
* Secure
* Well documented

---

# 3. Resource Naming

Use nouns, not verbs.

Good:

```text
/users

/workouts

/routines

/programs

/exercises

/skills

/timeline

/challenges
```

Avoid:

```text
/getWorkout

/createRoutine

/deleteExercise

/updateWorkout
```

HTTP methods already describe the action.

---

# 4. Use Business Actions When Needed

Some operations are not CRUD.

Examples:

Instead of:

```text
POST /workouts/updateStatus
```

Use:

```text
POST /workouts/{id}/complete
```

Instead of:

```text
POST /skill/update
```

Use:

```text
POST /skills/{id}/unlock
```

The endpoint should reflect the business event.

---

# 5. HTTP Methods

| Method | Purpose                                      |
| ------ | -------------------------------------------- |
| GET    | Retrieve resources                           |
| POST   | Create resources or perform business actions |
| PUT    | Replace entire resource                      |
| PATCH  | Partial updates                              |
| DELETE | Remove resource                              |

Do not misuse POST for simple reads.

---

# 6. URL Structure

Keep URLs simple.

Good:

```text
/users/{id}

/workouts/{id}

/workouts/{id}/complete

/routines/{id}

/skills/{id}

/timeline
```

Avoid deeply nested URLs.

Bad:

```text
/users/1/workouts/2/exercises/5/sets/4
```

Prefer querying related resources separately.

---

# 7. API Versioning

Version APIs only when necessary.

Preferred approach:

```text
/api/v1/
```

Breaking changes require a new version.

Non-breaking additions should not.

Deprecation should follow a documented migration process.

---

# 8. Request Bodies

Requests should include only the data required for the operation.

Example:

```json
{
  "name": "Push Day",
  "description": "Upper body strength"
}
```

Do not expose database-specific fields.

Never accept:

* Created timestamps
* Internal IDs for generated values
* Audit fields
* Server-calculated values

---

# 9. Response Structure

Responses should be consistent.

Example:

```json
{
  "data": {
    ...
  },
  "meta": {
    ...
  }
}
```

For collections:

```json
{
  "data": [...],
  "meta": {
    "page": 1,
    "pageSize": 20,
    "totalItems": 150,
    "totalPages": 8
  }
}
```

---

# 10. Error Responses

Errors should follow a consistent format.

Example:

```json
{
  "error": {
    "code": "WORKOUT_ALREADY_COMPLETED",
    "message": "This workout has already been completed.",
    "traceId": "...",
    "timestamp": "..."
  }
}
```

Clients should rely on `code`, not the message.

Messages are for humans.

Codes are for software.

---

# 11. Pagination

Large collections must be paginated.

Example:

```text
GET /community/posts?page=1&pageSize=20
```

Avoid returning thousands of records in one request.

Cursor-based pagination can be introduced later for high-volume feeds.

---

# 12. Filtering

Use query parameters.

Example:

```text
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
