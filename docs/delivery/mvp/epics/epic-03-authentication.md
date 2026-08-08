# Epic 03 — Authentication

## Purpose

Enable users to create accounts, log in, and remain securely authenticated throughout a session.

## Functional Requirements Satisfied

| FR ID | Requirement |
|---|---|
| FR-AUTH-001 | User can register with email and password |
| FR-AUTH-002 | User can log in securely |
| FR-AUTH-003 | User can reset password |
| FR-AUTH-004 | Session persists until logout or expiration |
| FR-AUTH-005 | User can logout |

Detailed requirements: `docs/01-product/features/01-identity-and-access/functional-requirements.md`

## Stories

| Story ID | Title | Estimate |
|---|---|---|
| STORY-010 | Create Auth Database Schema | 3 hrs |
| STORY-011 | Implement Auth API Endpoints | 4 hrs |
| STORY-012 | Add Session Persistence and Token Handling | 4 hrs |
| STORY-013 | Build Auth Screens and Form Validation | 4 hrs |
| STORY-014 | Add Auth Regression Tests | 3 hrs |

## Milestone

M2 — Authentication

## Depends On

EPIC-01, EPIC-02 (screens require the app shell and design primitives)

## Week

Week 03
