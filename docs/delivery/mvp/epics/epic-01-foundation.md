# Epic 01 — Foundation

## Purpose

Establish the project baseline so every subsequent MVP week can be built safely and predictably.
This includes the repository structure, environment configuration, backend and frontend shells,
database and migration tooling, and a CI pipeline that validates every push.

## Functional Requirements Satisfied

None from the portfolio FR list. Foundation is infrastructure, not a product capability.

## Stories

| Story ID | Title | Estimate |
|---|---|---|
| STORY-001 | Create Repository Skeleton | 3 hrs |
| STORY-002 | Add Shared Environment Configuration | 3 hrs |
| STORY-003 | Configure Backend Solution Shell | 4 hrs |
| STORY-004 | Configure Frontend App Shell | 4 hrs |
| STORY-005A | Add CI Workflow for Main and Pull Requests | 3 hrs |
| STORY-005B | Add Baseline Smoke Test and Startup Validation | 3 hrs |
| STORY-005C | Set Up Database and Migration Tooling | 3 hrs |

**Total estimate:** ~23 hrs

## Definition of Done

- Repository clones and builds on a clean machine without manual intervention.
- Backend health endpoint returns 200.
- Frontend landing screen renders without runtime errors.
- Database migrations apply cleanly to a local PostgreSQL instance.
- CI pipeline runs on every push and pull request.
- A smoke test is wired into CI.

## Milestone

M1 — Foundation

## Depends On

Nothing. This is the first epic.

## Week

Week 01
