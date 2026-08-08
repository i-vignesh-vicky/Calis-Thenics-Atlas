# Week 01 · Foundation and Project Setup

**Goal:** Initialize the monorepo, configure tooling, and produce a working skeleton that runs locally and passes CI.

**Epic:** [epic-01-foundation](../mvp/epics/epic-01-foundation.md)

## Stories This Week

| Story | Title | Estimate |
|-------|-------|----------|
| [STORY-001](../mvp/stories/STORY-001.md) | Create Repository Skeleton | 3 hrs |
| [STORY-002](../mvp/stories/STORY-002.md) | Add Shared Environment Configuration | 3 hrs |
| [STORY-003](../mvp/stories/STORY-003.md) | Configure Backend Solution Shell | 4 hrs |
| [STORY-004](../mvp/stories/STORY-004.md) | Configure Frontend App Shell | 4 hrs |
| [STORY-005A](../mvp/stories/STORY-005A.md) | Add CI Workflow for Main and Pull Requests | 3 hrs |
| [STORY-005B](../mvp/stories/STORY-005B.md) | Add Baseline Smoke Test and Startup Validation | 3 hrs |
| [STORY-005C](../mvp/stories/STORY-005C.md) | Set Up Database and Migration Tooling | 3 hrs |

**Total estimate:** ~23 hrs

## Story Dependency Order

```
STORY-001 (repo skeleton)
  ├── STORY-002 (env config)
  ├── STORY-003 (backend shell)
  │     └── STORY-005C (database + migrations)
  ├── STORY-004 (frontend shell)
  └── STORY-005A (CI workflow)
        └── STORY-005B (smoke test + CI wiring)
```

STORY-002, STORY-003, and STORY-004 can proceed in parallel once STORY-001 is done.
STORY-005C depends on STORY-003 (requires backend project to exist).
STORY-005A and STORY-005B are last — they need all other pieces to wire together.

## Exit Criteria

- Monorepo builds without errors on a clean checkout.
- Backend starts locally and the health endpoint returns 200.
- Frontend app renders the landing screen without runtime errors.
- Database migrations run cleanly against a local PostgreSQL instance.
- CI runs on every push and pull request and reports pass or fail.
- A smoke test exercises the health endpoint in CI.
- All changes are committed and pushed to GitHub.

## Scope Notes

Staging deployment is deliberately deferred. The priority for Week 01 is a
working local development environment. Hosting setup belongs to the release
phase once the core application is stable.
