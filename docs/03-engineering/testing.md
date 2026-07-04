Excellent. This is another document that many startups neglect, but it becomes invaluable as the codebase grows.

One correction before we begin:

> **We are not aiming for 100% test coverage.**
>
> We are aiming for **100% confidence in our critical business logic.**

That distinction is important. Chasing coverage percentages often leads to brittle tests with little value. Atlas should focus on testing what matters.

---

# `03-engineering/testing.md`

````markdown
# Testing Strategy

> "Testing is not about increasing code coverage.
> Testing is about increasing confidence."

---

# Purpose

This document defines the testing philosophy and strategy for Atlas.

The objective is to ensure that the platform remains reliable, maintainable, and safe to evolve as new features are introduced.

Testing should provide confidence that business rules, user workflows, and system integrations continue to function correctly.

---

# Testing Philosophy

Atlas values:

- Confidence over coverage
- Business behavior over implementation details
- Fast feedback
- Deterministic tests
- Readable tests
- Long-term maintainability

A passing test suite should give engineers confidence to refactor without fear.

---

# Testing Pyramid

Atlas follows the traditional testing pyramid.

```
                E2E Tests
             Integration Tests
               Unit Tests
```

Approximate distribution:

- Unit Tests: 70%
- Integration Tests: 25%
- End-to-End Tests: 5%

These percentages are guidelines rather than strict targets.

---

# Types of Tests

## Unit Tests

Purpose

Validate business logic in isolation.

Characteristics

- Fast
- Independent
- No database
- No network
- No file system

Examples

- Workout volume calculation
- Skill progression logic
- Recovery score calculation
- Consistency streak logic
- Milestone unlocking

---

## Integration Tests

Purpose

Verify that multiple components work together correctly.

May include

- Database
- Entity Framework
- Redis
- External services (mocked when appropriate)

Examples

- Create workout
- Save routine
- Authenticate user
- Query workout history

---

## API Tests

Purpose

Verify API behavior from the consumer's perspective.

Should validate

- Status codes
- Request validation
- Authorization
- Response contracts
- Error responses

---

## End-to-End Tests

Purpose

Validate complete user journeys.

Examples

- Register account
- Create routine
- Start workout
- Complete workout
- View progress timeline

These tests simulate real user behavior.

---

# What Should Be Tested

Business rules

Always.

Business rules represent the heart of Atlas.

Examples

- Workout completion rules
- Skill unlocking
- Milestone eligibility
- Challenge completion
- Recovery calculations

---

Application Services

Important workflows.

Examples

- Create Workout
- Complete Workout
- Join Challenge
- Update Profile

---

Infrastructure

Critical integrations.

Examples

- PostgreSQL
- Redis
- Authentication
- File Storage

---

Presentation

Focus on API contracts rather than implementation details.

---

# What Should Not Be Tested Excessively

Avoid testing:

- Framework behavior
- Simple property getters/setters
- Entity Framework internals
- Third-party libraries
- Auto-generated code

Trust mature frameworks.

---

# Test Naming

Tests should describe behavior.

Good

```
CompleteWorkout_ShouldUnlockMilestone_WhenConditionsAreMet
```

Good

```
CannotCompleteWorkout_WithoutCompletedSets
```

Bad

```
WorkoutTest1
```

Bad

```
TestWorkout
```

---

# Arrange / Act / Assert

Every unit test should follow:

Arrange

↓

Act

↓

Assert

Avoid mixing these phases.

---

# One Assertion Philosophy

Prefer one logical assertion per test.

Multiple related assertions are acceptable when validating one behavior.

---

# Test Independence

Every test must be independent.

Tests must never depend on execution order.

---

# Deterministic Tests

Tests should always produce the same result.

Avoid

- Random values
- Current system time
- External APIs
- Internet connectivity

Inject clocks and random generators when necessary.

---

# Test Data

Use builders or factories.

Avoid manually creating large object graphs repeatedly.

Example

WorkoutBuilder

UserBuilder

RoutineBuilder

SkillBuilder

---

# Database Testing

Integration tests should use isolated databases.

Tests must clean up after execution.

Avoid sharing mutable state.

---

# Mocking

Mock only external dependencies.

Examples

- Email service
- Push notifications
- Payment gateway
- AI service
- Wearable APIs

Avoid mocking domain objects.

---

# Performance Tests

Critical endpoints should have performance benchmarks.

Examples

- Workout history
- Progress timeline
- Dashboard loading

Performance tests should run separately from the standard CI pipeline.

---

# Load Testing

Future releases should include load testing for:

- Authentication
- Workout logging
- Community feed
- AI recommendations

---

# Security Testing

Verify:

- Authorization
- Authentication
- Input validation
- Rate limiting
- Injection attacks

These tests should be automated where practical.

---

# Regression Testing

Every bug fix should include a regression test.

A bug should never be fixed without preventing its return.

---

# Code Coverage

Code coverage is a metric—not a goal.

Atlas prioritizes:

- Critical business paths
- High-risk modules
- Core domain logic

Suggested minimums

Domain Layer: 90%+

Application Layer: 80%+

Infrastructure: Meaningful coverage

UI: Critical flows only

Coverage should never justify low-value tests.

---

# Continuous Integration

Every pull request should automatically run:

- Unit Tests
- Integration Tests
- API Tests
- Static Analysis

Pull requests must not be merged if mandatory tests fail.

---

# Test Environment

Production and testing environments should behave consistently.

Configuration differences should be minimal.

---

# Manual Testing

Manual testing remains valuable for:

- User experience
- Visual polish
- Accessibility
- Exploratory testing
- Beta feedback

Automation complements—not replaces—manual testing.

---

# AI Feature Testing

Future AI capabilities require additional validation.

Test for:

- Recommendation consistency
- Explainability
- Performance
- Safety
- Bias
- Failure handling

AI recommendations should never encourage unsafe training behavior.

---

# Definition of a Tested Feature

A feature is considered tested when:

✓ Business rules verified

✓ Edge cases covered

✓ API contracts validated

✓ Error handling tested

✓ Security checks verified

✓ Integration scenarios tested

✓ Regression tests added

---

# Guiding Principle

Test behavior, not implementation.

A well-tested system enables confident change.

Confidence—not coverage—is the ultimate measure of testing quality.
````

---

# Technical Architect Notes

There are two additional testing practices I'd like Atlas to adopt once the project grows:

### 1. Architecture Tests

Automatically verify architectural rules, such as:

* Domain must not reference Infrastructure.
* Application must not reference Presentation.
* No circular dependencies.
* Modules remain isolated.

This helps preserve Clean Architecture over time.

### 2. Fitness Scenario Tests

Given Atlas's domain, we should create high-level scenario tests that model realistic user journeys, for example:

* Beginner unlocks first pull-up over 12 weeks.
* User returns after a 3-month break.
* Injured athlete resumes training.
* Recovery-driven deload week.

These aren't just software tests—they validate that our product behaves sensibly from a fitness perspective.

---
