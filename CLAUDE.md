# CLAUDE

This file is the operating system for AI-assisted development in this repository.
Its job is simple: help a solo developer ship a high-quality MVP fast, without chaos.

## Mission

Build Calis-Thenics-Atlas as a practical, maintainable MVP that improves user consistency, progress, and long-term health behavior.

AI must optimize for:

1. Correctness
2. Simplicity
3. Delivery speed
4. Maintainability

## Source of Truth

Always resolve decisions using this priority order:

1. [PRODUCT.md](PRODUCT.md)
2. [ARCHITECTURE.md](ARCHITECTURE.md)
3. [CONVENTIONS.md](CONVENTIONS.md)
4. [docs/01-product/functional-requirements.md](docs/01-product/functional-requirements.md)
5. [docs/01-product/features](docs/01-product/features)
6. [docs/02-domain/domain-model.md](docs/02-domain/domain-model.md)
7. [docs/03-engineering](docs/03-engineering)
8. [docs/stories/PLAN.md](docs/stories/PLAN.md)

If two docs conflict, do not guess. Call out the conflict and propose the minimum update to restore one truth.

## Product Guardrails (Non-Negotiable)

1. This is a long-term fitness companion, not a vanity engagement app.
2. Progress is self-referenced, not social-comparison-first.
3. Recovery and safety matter as much as intensity.
4. AI gives explainable recommendations, never commands.
5. Data trust is critical: no silent loss, no hidden mutations of historical performance.

## MVP Scope Discipline

In scope now:

- Identity and access
- Profile and goals
- Exercise library
- Programs and routine builder
- Workout execution and history
- Skills, milestones, progress, consistency
- Basic community, notifications, search
- Foundational personalization

Out of scope unless explicitly requested:

- Advanced AI coaching
- Wearable-native recovery intelligence
- Nutrition intelligence
- Enterprise/platform extras

When asked for out-of-scope work, recommend a phased alternative instead of silently expanding scope.

## Solo Developer Mode

Default behavior for AI:

1. Prefer boring, proven technology choices already documented in this repo.
2. Prefer modular monolith patterns over distributed complexity.
3. Minimize operational burden (fewer moving parts, fewer services, fewer knobs).
4. Keep setup and onboarding friction low.
5. Choose solutions that one person can debug at 2 AM.

## Architecture Invariants

1. Keep clean architecture boundaries: domain logic must not depend on frameworks.
2. Completed workout facts are immutable; corrections must be explicit.
3. Use consistent naming and module boundaries from [CONVENTIONS.md](CONVENTIONS.md).
4. Keep APIs resource-oriented and versioned.
5. Keep database design aligned with domain entities and invariants.

## Execution Protocol for AI Tasks

For every meaningful task, follow this sequence:

1. Restate intent in one sentence.
2. List assumptions and risks.
3. Propose the smallest viable change.
4. Implement only what is needed.
5. Verify with tests/checks.
6. Summarize what changed, why, and what remains.

If uncertainty is high, pause and ask one focused question before coding.

## Decision Framework

When deciding between options, score quickly on:

1. User value now
2. Implementation complexity
3. Long-term maintainability
4. Reversibility
5. Operational cost for a solo maintainer

Prefer options that are high-value, low-complexity, reversible, and low-ops.

## Anti-Trouble Rules

AI must not:

1. Invent requirements not in docs.
2. Add broad refactors without request.
3. Introduce new infrastructure because it is trendy.
4. Change architecture direction without explicit ADR-level reasoning.
5. Produce large speculative code that is not immediately needed.

AI should:

1. Flag contradictions early.
2. Preserve backward compatibility where practical.
3. Keep diffs surgical and easy to review.
4. Prefer clarity over cleverness.

## Documentation Rules

1. Keep one source of truth per topic.
2. Avoid duplicate explanations across files.
3. Update related docs in the same change when decisions shift.
4. Mark unknowns as "Open Questions" instead of guessing.
5. Archive outdated strategy docs; do not leave conflicting active docs.

## Quality Bar Before Merge

A change is done only when:

1. Acceptance criteria are satisfied.
2. Tests or verifications are passed (or explicit reason provided).
3. No known conflicts with product, domain, or architecture docs.
4. Naming and structure follow conventions.
5. Impact and rollback path are understandable.

## Weekly Delivery Rhythm

Use [docs/stories/PLAN.md](docs/stories/PLAN.md) as the master roadmap.

For each week:

1. Ship one vertical slice with user-visible progress.
2. Keep scope tight.
3. Capture decisions and tradeoffs briefly.
4. Leave the repo cleaner than before.

## Communication Style for AI

1. Be direct and practical.
2. Explain tradeoffs briefly.
3. Highlight risks clearly.
4. Do not overwhelm with theory when action is needed.
5. Recommend the next best step, not ten optional rabbit holes.

## Definition of Success

This file is successful if AI consistently helps you:

1. Make wise technical decisions.
2. Avoid unnecessary complexity.
3. Maintain architectural integrity.
4. Ship weekly progress with confidence.
5. Preserve product intent while building fast.