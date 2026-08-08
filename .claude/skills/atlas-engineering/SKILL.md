# Atlas Engineering Skill

This skill defines how Claude should engineer Atlas.

It does NOT duplicate project documentation.

| Source | Purpose |
|--------|---------|
| `CLAUDE.md` | Repository instructions and navigation |
| `PRODUCT.md` / `ARCHITECTURE.md` / `CONVENTIONS.md` | Top-level decisions |
| `docs/01-product/` | Product requirements and features |
| `docs/02-domain/` | Domain model, business rules, ubiquitous language |
| `docs/03-engineering/` | Architecture, API, data, security, testing, observability |
| `docs/delivery/` | MVP scope, stories, weekly plans, status |
| `SKILL.md` | Engineering behavior and workflow |

---

## Engineering Workflow

For every non-trivial task:

```
Understand request
→ Find relevant docs
→ Check domain rules
→ Inspect existing code
→ Check architecture
→ Identify impact
→ Plan
→ Implement
→ Test
→ Review
→ Update docs if required
```

Never jump directly from request to code.

---

## Core Rules

### Product

- Understand user value before implementing.
- Respect MVP boundaries in `docs/delivery/mvp/scope.md`.
- Do not implement post-MVP roadmap features unless explicitly requested.

### Domain

- Use Atlas ubiquitous language (`docs/02-domain/ubiquitous-language.md`).
- Check `docs/02-domain/domain-model.md` and `docs/02-domain/business-rules.md` before changing behavior.
- Do not duplicate domain concepts.
- Keep domain logic independent of infrastructure and UI.

### Architecture

- Follow `docs/03-engineering/` for backend, frontend, API, database, security, and observability conventions.
- Check existing implementations before creating new ones.
- Prefer simple, cohesive solutions.
- Avoid premature abstraction, unnecessary dependencies, god classes/services, and duplicate implementations.
- Never introduce major architectural changes silently.

### Data

- Respect `docs/03-engineering/database.md` and the documented data model.
- Protect historical workout data — completed session facts are immutable.
- Do not add speculative fields for possible future use.
- Consider migration and backward-compatibility impact on every schema change.

### API / Security / Observability

Follow `docs/03-engineering/api-guidelines.md`, `security.md`, and `observability.md`.

For every change touching an API or security boundary, consider:

- Contract stability
- Input validation
- Error handling and consistent error shapes
- Authentication and authorization
- Sensitive data exposure
- Logging and tracing

Never expose secrets or sensitive user information.

### Testing

Follow `docs/03-engineering/testing.md`.

Test behavior and business rules, not implementation details.

Add or update:

- Unit tests for domain logic
- Integration tests for API and data layers
- UI tests for critical journeys

Do not optimize for coverage numbers alone.

---

## Existing Code First

Before creating anything new, search for existing:

- Domain concepts and services
- API patterns and handlers
- Validation and error handling
- UI components and utilities
- Tests for the area being changed

Extend existing solutions when appropriate.

---

## Escalate Instead of Guessing

Stop and ask when:

- Requirements materially conflict with documented product or domain decisions.
- A new undefined domain concept is needed.
- MVP scope would change.
- A breaking API change is required.
- A destructive or irreversible database change is required.
- Security implications are unclear.
- A decision has significant long-term architectural or data consequences.

Do not invent significant product or architecture decisions to keep coding.

---

## Definition of Done

```
Requirement understood
→ Relevant docs checked
→ Domain respected
→ Architecture respected
→ Existing code considered
→ Implementation complete
→ Tests updated
→ Security and error handling considered
→ Documentation updated if necessary
```

---

## Atlas Principles

1. Understand before coding.
2. Product value before technology.
3. Domain before infrastructure.
4. Simple before clever.
5. Reuse before duplicate.
6. MVP discipline before feature expansion.
7. Data quality before AI complexity.
8. Long-term maintainability over short-term convenience.
9. Document significant decisions.
10. Build today's product to enable tomorrow's vision.

---

**The repository documentation defines Atlas. This skill defines how Claude works on Atlas.**
