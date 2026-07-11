# Functional Requirements

## Document Metadata

- Version: 2.0
- Status: Active
- Owner: Product and Engineering

## Purpose

Define MVP functional requirements at portfolio level and map each feature to its detailed requirement document.

## Scope

In scope for MVP:

- Identity and profile
- Exercise library
- Programs and routine builder
- Workout execution and logging
- Skills, milestones, progress, consistency
- Basic community and challenges
- Search and notifications
- Foundational personalization

Out of scope for MVP:

- Advanced AI coaching
- Full nutrition intelligence
- Wearable-native recovery intelligence

## Source of Truth

Detailed functional requirements are maintained in feature-specific folders under:

- `docs/01-product/features/`

## Feature Requirement Map

### FA-01 Identity and Access

- Requirement doc: `features/01-identity-and-access/functional-requirements.md`
- Key IDs:
	- FR-AUTH-001: User can register with email and password.
	- FR-AUTH-002: User can log in securely.
	- FR-AUTH-003: User can reset password.
	- FR-AUTH-004: Session persists until logout or expiration.
	- FR-AUTH-005: User can logout.

### FA-02 Profile and Goals

- Requirement doc: `features/02-user-profile-and-goals/functional-requirements.md`
- Key IDs:
	- FR-PROFILE-001: User can create and update profile details.
	- FR-PROFILE-002: User can set primary training goals.
	- FR-PROFILE-003: User can set experience level.
	- FR-PROFILE-004: User can define available equipment.

### FA-03 Exercise Library

- Requirement doc: `features/03-exercise-library/functional-requirements.md`
- Key IDs:
	- FR-LIB-001: User can browse categorized exercises.
	- FR-LIB-002: Exercise includes instructions and difficulty metadata.
	- FR-LIB-003: User can search exercises.
	- FR-LIB-004: User can filter exercises.

### FA-04 Programs

- Requirement doc: `features/04-programs/functional-requirements.md`
- Key IDs:
	- FR-PROGRAM-001: User can browse available programs.
	- FR-PROGRAM-002: Program includes duration, difficulty, and goal metadata.
	- FR-PROGRAM-003: User can enroll in a program.
	- FR-PROGRAM-004: User can pause and resume a program.
	- FR-PROGRAM-005: System tracks program progress.

### FA-05 Routine Builder

- Requirement doc: `features/05-routine-builder/functional-requirements.md`
- Key IDs:
	- FR-ROUTINE-001: User can create routine.
	- FR-ROUTINE-002: User can edit routine.
	- FR-ROUTINE-003: User can duplicate routine.
	- FR-ROUTINE-004: User can archive routine.
	- FR-ROUTINE-005: User can order exercises in routine.

### FA-06 Workout Execution and Logging

- Requirement doc: `features/06-workout-execution/functional-requirements.md`
- Key IDs:
	- FR-WORKOUT-001: User can start, pause, resume, and complete workout session.
	- FR-WORKOUT-002: User can log set-level reps/load/duration.
	- FR-WORKOUT-003: System auto-saves in-progress workout session.
	- FR-WORKOUT-004: Completed workout is stored in history.
	- FR-WORKOUT-005: User can add notes and perceived exertion.

### FA-07 Skills and Milestones

- Requirement doc: `features/07-skills-and-milestones/functional-requirements.md`
- Key IDs:
	- FR-SKILL-001: User can track skill progression stage.
	- FR-SKILL-002: System records milestone achievement.
	- FR-SKILL-003: Skill history is visible in timeline.

### FA-08 Progress and Consistency

- Requirement doc: `features/08-progress-and-consistency/functional-requirements.md`
- Key IDs:
	- FR-PROGRESS-001: User can view personal records.
	- FR-PROGRESS-002: User can view workout and progression timeline.
	- FR-PROGRESS-003: System tracks streaks and active days.
	- FR-PROGRESS-004: User can view period summaries.

### FA-09 Community and Challenges

- Requirement doc: `features/09-community-and-challenges/functional-requirements.md`
- Key IDs:
	- FR-COMMUNITY-001: User has public profile surface.
	- FR-COMMUNITY-002: User can create post and comment.
	- FR-COMMUNITY-003: User can join challenge.
	- FR-COMMUNITY-004: System tracks challenge progress.

### FA-10 Search and Notifications

- Requirement doc: `features/10-notifications-and-search/functional-requirements.md`
- Key IDs:
	- FR-SEARCH-001: User can search users, exercises, and programs.
	- FR-NOTIF-001: System sends workout reminders.
	- FR-NOTIF-002: System sends social and challenge updates.

### FA-11 AI and Personalization

- Requirement doc: `features/11-ai-personalization/functional-requirements.md`
- Key IDs:
	- FR-AI-001: System provides personalized workout recommendations.
	- FR-AI-002: Recommendations include explainable reasoning.
	- FR-AI-003: User can accept, skip, or reject recommendations.
	- FR-AI-004: System captures recommendation feedback for improvement.

## Requirement Traceability Rules

- Portfolio requirement IDs in this document are stable reference IDs.
- Detailed behavior, edge cases, data contracts, and acceptance criteria live in each feature folder.
- If conflicts occur, feature-level functional requirement documents are the source of truth and this file must be updated in the same change.

## Directory Convention

- `features/NN-feature-name/functional-requirements.md`

Where:

- `NN` is a two-digit sequence aligned with product capability numbering.
- `feature-name` is lowercase kebab-case.
