Perfect. This is probably the **most important engineering document** in the entire project.

If I were joining Atlas as a Senior Staff Engineer, this is the first document I'd read before writing a single line of code.

---

# `03-engineering/coding-standards.md`

````markdown
# Atlas Engineering Standards

> "Code is read far more often than it is written.
> Every line of code should optimize for clarity, maintainability, and longevity."

---

# Purpose

This document defines the engineering standards for Atlas.

These standards ensure that the codebase remains:

- Maintainable
- Testable
- Scalable
- Consistent
- Easy to understand
- Easy to extend

Every engineer and AI coding assistant contributing to Atlas is expected to follow these guidelines.

---

# Engineering Philosophy

Atlas is being built for the next decade, not the next sprint.

We prioritize:

- Correctness over cleverness
- Readability over brevity
- Simplicity over unnecessary abstraction
- Maintainability over premature optimization
- Long-term architecture over short-term convenience

---

# Core Principles

## SOLID

All application code should follow SOLID principles.

Especially:

- Single Responsibility Principle
- Dependency Inversion Principle
- Open/Closed Principle

Avoid classes with multiple unrelated responsibilities.

---

## Clean Architecture

Dependencies always point inward.

```
Presentation

↓

Application

↓

Domain

↓

Infrastructure
```

Outer layers may depend on inner layers.

Inner layers must never depend on outer layers.

---

## Domain-Driven Design

Business logic belongs in the Domain layer.

Controllers, APIs, and UI should coordinate—not implement—business rules.

The domain model should represent real-world fitness concepts.

---

## Separation of Concerns

Each layer has one responsibility.

Presentation

- HTTP
- Authentication
- Serialization

Application

- Use Cases
- Commands
- Queries

Domain

- Business Rules
- Entities
- Value Objects

Infrastructure

- Database
- Redis
- External APIs
- Email
- Storage

---

# Folder Organization

Organize code by feature first, then by technical concern.

Example

```
Modules/

Workout/

Application/

Domain/

Infrastructure/

Presentation/

Program/

Skill/

Community/
```

Avoid large "Services" folders.

---

# Naming

Names should describe intent.

Good

WorkoutSession

ProgressCalculator

WorkoutCompletedEvent

Bad

Manager

Helper

Processor

Utility

Thing

DataHandler

---

Methods should describe actions.

Good

CompleteWorkout()

CalculateVolume()

UnlockSkill()

Bad

DoStuff()

Handle()

Process()

Execute()

---

Variables

Prefer descriptive names.

Good

completedWorkout

totalVolume

userRecoveryScore

Avoid

x

obj

data

tmp

---

# Method Design

Methods should:

- Perform one task
- Have one level of abstraction
- Be easy to test

Aim for methods under 30 lines where practical.

---

# Class Design

Classes should represent one concept.

Large classes usually indicate multiple responsibilities.

---

# Dependency Injection

Always depend on abstractions.

Avoid:

```
new PostgreSqlRepository()
```

Prefer constructor injection.

---

# Business Logic

Business rules belong in the Domain.

Never implement business logic in:

- Controllers
- Flutter Widgets
- API Filters
- Database Stored Procedures

---

# Entities

Entities should protect their own invariants.

Bad

```
workout.Status = Completed;
```

Good

```
workout.Complete();
```

The entity decides whether completion is valid.

---

# Value Objects

Use Value Objects when identity is unimportant.

Examples

Weight

Height

Duration

Email

ExperienceLevel

Benefits

Immutable

Self-validating

Reusable

---

# Domain Events

Significant business events should raise domain events.

Examples

WorkoutCompleted

SkillUnlocked

MilestoneEarned

ChallengeJoined

Future systems can subscribe without changing existing code.

---

# Commands & Queries

Use CQRS.

Commands modify state.

Queries read state.

Never mix the two.

---

# Validation

Validation occurs at multiple levels.

Presentation

Basic request validation.

Application

Input validation.

Domain

Business validation.

---

# Exceptions

Use exceptions only for exceptional situations.

Business validation should return meaningful failures rather than relying on exceptions.

---

# Logging

Log meaningful events.

Avoid logging every method call.

Include:

Correlation ID

User ID (when appropriate)

Execution time

Request path

Exception details

Never log:

Passwords

Tokens

Sensitive personal information

---

# Async Programming

Prefer async APIs throughout the stack.

Avoid blocking calls.

Support cancellation tokens where appropriate.

---

# Configuration

Configuration belongs outside code.

Environment-specific settings should never be hardcoded.

---

# Constants

Avoid magic numbers.

Bad

```
if(days > 14)
```

Good

```
const int RecoveryWindowDays = 14;
```

---

# Comments

Code should explain *how*.

Comments should explain *why*.

Avoid redundant comments.

Bad

```
// increment i
i++;
```

Good

```
// Recovery calculations require a 7-day rolling window
```

---

# Error Handling

Handle errors close to their source.

Provide meaningful messages.

Never expose internal implementation details to clients.

---

# DTOs

Never expose domain entities directly through APIs.

Always use DTOs.

---

# Mapping

Mapping should be explicit.

Avoid excessive "magic" mapping that hides intent.

---

# Immutability

Prefer immutable objects whenever practical.

Immutable objects reduce bugs and improve reasoning.

---

# Database Access

Repositories belong in Infrastructure.

Business logic should not know about SQL or Entity Framework.

---

# Testing

Every business rule should have automated tests.

Complex domain logic requires unit tests.

Critical workflows require integration tests.

---

# Code Reviews

Every pull request should answer:

Is the code understandable?

Is the architecture respected?

Are business rules correct?

Can this be simplified?

Is it sufficiently tested?

Will this still make sense two years from now?

---

# Performance

Optimize only after measurement.

Premature optimization is discouraged.

Measure first.

Optimize second.

---

# Refactoring

Leave the codebase better than you found it.

Small continuous improvements are encouraged.

Large rewrites require architectural discussion.

---

# Technical Debt

Technical debt should be:

Documented

Prioritized

Intentional

Never ignored.

---

# AI-Generated Code

AI-generated code must meet the same engineering standards as human-written code.

Every AI contribution should be:

Reviewed

Tested

Understood

Maintainable

Readable

AI accelerates development.

It does not replace engineering judgment.

---

# Documentation

Every feature should include:

Architecture notes

API documentation

Business rule references

Relevant ADRs

Avoid undocumented behavior.

---

# Definition of Done

A feature is complete only when:

✓ Requirements implemented

✓ Tests passing

✓ Reviewed

✓ Logged appropriately

✓ Error handling included

✓ Documentation updated

✓ API documented

✓ No known critical bugs

✓ Meets performance expectations

---

# Guiding Principle

Write code that your future self—and every future teammate—will thank you for.

Atlas is intended to last for years.

Its code should reflect that ambition.
````

---

# Technical Architect Review

This is an excellent baseline, but I want to strengthen it further for Atlas.

As our codebase grows, I would add dedicated sections for:

* **Entity Framework Core Best Practices** (tracking, migrations, LINQ, performance)
* **Vertical Slice Architecture conventions**
* **MediatR usage guidelines**
* **FluentValidation conventions**
* **Caching strategy (Redis)**
* **Event publishing patterns**
* **Background jobs**
* **File organization examples**
* **Git branching and commit message conventions**
* **Pull Request template**
* **Performance budgets**
* **AI-assisted development workflow**

These don't need to be in the first version, but they'll become valuable as the engineering team grows.

---