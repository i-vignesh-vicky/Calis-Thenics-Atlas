# Epic 08 — Progress and History

## Purpose

Make completed workouts understandable and reviewable; surface meaningful growth signals from training data.

## Functional Requirements Satisfied

| FR ID | Requirement |
|---|---|
| FR-PROGRESS-001 | User can view personal records |
| FR-PROGRESS-002 | User can view workout and progression timeline |
| FR-PROGRESS-003 | System tracks streaks and active days |
| FR-PROGRESS-004 | User can view period summaries |
| FR-SKILL-001 | User can track skill progression stage |
| FR-SKILL-002 | System records milestone achievement |
| FR-SKILL-003 | Skill history is visible in timeline |

Detailed requirements:
- `docs/01-product/features/07-skills-and-milestones/functional-requirements.md`
- `docs/01-product/features/08-progress-and-consistency/functional-requirements.md`

## Coverage Note

FR-SKILL-001 (skill progression stage tracking) and FR-SKILL-003 (skill history timeline) are partially addressed by STORY-036 (milestone logic) but require further story decomposition if full skill stage tracking is needed. Flagged as an open question; see `development-status.md`.

## Stories

**Workout History (Week 08)**

| Story ID | Title | Estimate |
|---|---|---|
| STORY-032 | Add Workout History Queries | 3 hrs |
| STORY-033 | Build Workout History List UI | 3 hrs |
| STORY-034 | Build Workout Detail and Summary UI | 3 hrs |
| STORY-035 | Add History Tests and Notes | 3 hrs |

**Progress Tracking (Week 09)**

| Story ID | Title | Estimate |
|---|---|---|
| STORY-036 | Implement Streak and Milestone Calculations | 3 hrs |
| STORY-037 | Expose Progress Summary API | 3 hrs |
| STORY-038 | Build Progress Dashboard UI | 3 hrs |
| STORY-039 | Add Progress Logic Tests | 3 hrs |

## Milestone

M3 — Core training flow

## Depends On

EPIC-07 (progress is derived from completed workout sessions)

## Weeks

Week 08 (history), Week 09 (progress tracking)
