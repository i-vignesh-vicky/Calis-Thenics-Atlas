# Business Rules

## Purpose

Define non-negotiable rules that govern platform behavior independent of technology choices.

## Rule Intent

These rules exist to preserve long-term user outcomes, data integrity, and trust. If implementation convenience conflicts with these rules, implementation must change.

## Rule Set

### User Rules

- BR-001: Every user has exactly one profile.
- BR-002: User owns personal fitness data.
- BR-003: Personal data lifecycle follows retention and deletion policy.

### Routine Rules

- BR-101: Routine must contain at least one exercise.
- BR-102: Exercise order in routine is explicit and preserved.
- BR-103: Routine edits do not mutate historical completed workouts.

### Workout Rules

- BR-201: Workout belongs to exactly one user.
- BR-202: Only completed workouts affect analytics and progression.
- BR-203: Workout start must be earlier than workout end.
- BR-204: Completed workout is immutable except explicit correction flow.
- BR-205: Historical records are never silently altered.

### Program Rules

- BR-301: Program contains one or more planned sessions.
- BR-302: Program revisions are versioned.
- BR-303: Historical user progress remains preserved across program version changes.

### Skill Rules

- BR-401: Skill progression requires ordered prerequisites.
- BR-402: Milestones are awarded once per milestone definition.

### Progress and Recovery Rules

- BR-501: Progress is evaluated against user's own baseline.
- BR-502: Personal record updates only on true improvement.
- BR-601: Recovery is an estimate with bounded range.
- BR-602: Recovery recommendations must prioritize long-term health over short-term performance.

### Community and Challenge Rules

- BR-701: Users own authored content.
- BR-702: Community deletion does not erase fitness achievement history.
- BR-801: Challenge has explicit start/end boundaries.
- BR-802: Challenge completion uses objective activity evidence where possible.

### AI Governance Rules

- BR-901: AI provides recommendations, not commands.
- BR-902: AI should explain rationale where practical.
- BR-903: AI cannot fabricate performance evidence.
- BR-904: When confidence is low, AI behavior must default to conservative guidance.
