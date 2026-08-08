# Epic 06 — Routine Builder

## Purpose

Introduce structured training plans so users can create, edit, reorder, and manage routines composed of exercises.

## Domain Note

A **routine** is a user-created or system-provided sequence of exercises forming a single workout plan. Users can create custom routines or follow system-provided ones.

**Programs** (goal-oriented workout collections targeting a specific end goal — Muscle-Ups, Planche, Upper Body, etc.) are deferred to Phase 2. See `docs/07-delivery/roadmap/post-mvp.md`.

## Functional Requirements Satisfied

| FR ID | Requirement |
|---|---|
| FR-ROUTINE-001 | User can create routine |
| FR-ROUTINE-002 | User can edit routine |
| FR-ROUTINE-003 | User can duplicate routine |
| FR-ROUTINE-004 | User can archive routine |
| FR-ROUTINE-005 | User can order exercises in routine |

Detailed requirements: `docs/01-product/features/05-routine-builder/functional-requirements.md`

## Out of Scope for This Epic

FA-04 (Programs: enroll, pause/resume, goal-oriented program tracking) — deferred to Phase 2.

## Stories

| Story ID | Title | Estimate |
|---|---|---|
| STORY-023 | Create Routine Schema and Migration | 3 hrs |
| STORY-024 | Add Routine CRUD API | 4 hrs |
| STORY-025 | Build Routine List and Create UI | 4 hrs |
| STORY-026 | Build Routine Editor Screen | 4 hrs |
| STORY-026A | Implement Reorder and Persist Flow | 3 hrs |

## Milestone

M3 — Core training flow

## Depends On

EPIC-05 (routine items reference exercises from the library)

## Week

Week 06
