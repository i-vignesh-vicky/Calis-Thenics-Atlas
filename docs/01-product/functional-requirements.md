# Functional Requirements

## Document Metadata

- Version: 1.0
- Status: Draft for MVP implementation
- Owner: Product and Engineering

## Purpose

Define what the MVP must do, independent of technical implementation.

## Scope

In scope for MVP:

- Identity and profile
- Exercise library
- Programs and routine builder
- Workout execution and logging
- Skills, milestones, progress, consistency
- Basic community and challenges
- Search and notifications

Out of scope for MVP:

- Advanced AI coaching
- Full nutrition intelligence
- Wearable-native recovery intelligence

## Functional Areas and Requirements

### FA-01 Identity and Access

- FR-AUTH-001: User can register with email and password.
- FR-AUTH-002: User can log in securely.
- FR-AUTH-003: User can reset password.
- FR-AUTH-004: Session persists until logout or expiration.
- FR-AUTH-005: User can logout.

### FA-02 Profile and Goals

- FR-PROFILE-001: User can create and update profile details.
- FR-PROFILE-002: User can set primary training goals.
- FR-PROFILE-003: User can set experience level.
- FR-PROFILE-004: User can define available equipment.

### FA-03 Exercise Library

- FR-LIB-001: User can browse categorized exercises.
- FR-LIB-002: Exercise includes instructions and difficulty metadata.
- FR-LIB-003: User can search exercises.
- FR-LIB-004: User can filter exercises.

### FA-04 Programs

- FR-PROG-001: User can browse available programs.
- FR-PROG-002: Program includes duration, difficulty, and goal metadata.
- FR-PROG-003: User can enroll in a program.
- FR-PROG-004: User can pause and resume a program.
- FR-PROG-005: System tracks program progress.

### FA-05 Routine Builder

- FR-ROUT-001: User can create routine.
- FR-ROUT-002: User can edit routine.
- FR-ROUT-003: User can duplicate routine.
- FR-ROUT-004: User can archive routine.
- FR-ROUT-005: User can order exercises in routine.

### FA-06 Workout Execution and Logging

- FR-WORK-001: User can start, pause, resume, and complete workout session.
- FR-WORK-002: User can log set-level reps/load/duration.
- FR-WORK-003: System auto-saves in-progress workout session.
- FR-WORK-004: Completed workout is stored in history.
- FR-WORK-005: User can add notes and perceived exertion.

### FA-07 Skills and Milestones

- FR-SKILL-001: User can track skill progression stage.
- FR-SKILL-002: System records milestone achievement.
- FR-SKILL-003: Skill history is visible in timeline.

### FA-08 Progress and Consistency

- FR-PROG-101: User can view personal records.
- FR-PROG-102: User can view workout and progression timeline.
- FR-PROG-103: System tracks streaks and active days.
- FR-PROG-104: User can view period summaries.

### FA-09 Community and Challenges

- FR-COMM-001: User has public profile surface.
- FR-COMM-002: User can create post and comment.
- FR-COMM-003: User can join challenge.
- FR-COMM-004: System tracks challenge progress.

### FA-10 Search and Notifications

- FR-SEARCH-001: User can search users, exercises, and programs.
- FR-NOTIF-001: System sends workout reminders.
- FR-NOTIF-002: System sends social and challenge updates.
