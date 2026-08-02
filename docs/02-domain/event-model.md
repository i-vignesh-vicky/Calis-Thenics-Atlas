# Event Model

## Purpose

Define domain event conventions and the standard event envelope. The authoritative event catalog is maintained in [domain-model.md](domain-model.md#event-catalog).

## Event Principles

1. Events represent facts that happened.
2. Event names use past tense.
3. Events are append-only and timestamped.
4. Derived views can be rebuilt from event history.

## Event Envelope (Standard)

Every event includes:

- eventId
- eventType
- occurredAtUtc
- userId
- aggregateId
- payload
- correlationId
- causationId
- schemaVersion

## Processing Model

- Synchronous handling for critical transactional integrity where needed.
- Asynchronous handling for analytics, notifications, and AI pipelines.
- Idempotent consumers required.
- Dead-letter queue for failed event processing.

## Event Categories

See [domain-model.md — Event Catalog](domain-model.md#event-catalog) for the full list organized by context:

- Identity and Profile Events
- Training Events
- Progress and Skill Events
- Recovery and Recommendation Events
- Community Events

## Permanence Guidance

See [domain-model.md — Permanence Guidance](domain-model.md#permanence-guidance) for retention rules.
