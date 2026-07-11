# Non-Functional Requirements

## Document Metadata

- Version: 1.0
- Status: Draft for MVP engineering baseline
- Owner: Engineering

## Purpose

Define quality attributes and operational expectations for MVP and near-term scale.

## Quality Attributes

- Performance
- Reliability
- Availability
- Security and privacy
- Maintainability
- Extensibility
- Observability
- Accessibility
- Offline resilience
- Data integrity
- AI readiness

## Requirements

### Performance

- NFR-PERF-001: Core user interactions must feel responsive.
- NFR-PERF-002: Workout execution flow must remain smooth under normal usage.
- NFR-PERF-003: Large collections must use pagination.

### Reliability and Availability

- NFR-REL-001: Critical user data operations must be fault-tolerant and recoverable.
- NFR-REL-002: Workout data must never be silently lost.
- NFR-AVL-001: Critical services expose health endpoints.

### Security and Privacy

- NFR-SEC-001: All traffic must use HTTPS.
- NFR-SEC-002: Credentials must be stored using secure hashing.
- NFR-SEC-003: Authorization enforced on protected resources.
- NFR-SEC-004: Inputs validated on all API boundaries.
- NFR-PRIV-001: Users can export their data.
- NFR-PRIV-002: Users can delete their account and personal data per policy.

### Maintainability and Extensibility

- NFR-MAIN-001: Business logic remains separated from framework concerns.
- NFR-MAIN-002: Modules have clear ownership and boundaries.
- NFR-MAIN-003: Public APIs are documented.
- NFR-EXT-001: Domain supports future modality expansion.

### Observability

- NFR-OBS-001: Application logs are structured.
- NFR-OBS-002: Critical business events are logged.
- NFR-OBS-003: Performance metrics are collected for key flows.

### Offline and Data Integrity

- NFR-OFF-001: User can continue active workout during temporary network loss.
- NFR-OFF-002: Data syncs reliably when connectivity returns.
- NFR-DATA-001: Historical workout records are preserved as source of truth.
- NFR-DATA-002: Timestamps stored in UTC.
- NFR-AI-001: Data shape supports longitudinal analysis and future AI services.
