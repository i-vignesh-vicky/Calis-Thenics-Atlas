# Engineering Standards

> "Code is read far more often than it is written. Every line should optimize for clarity, maintainability, and longevity."

## Purpose

This document defines engineering standards for Calis-Thenics-Atlas. These standards ensure the codebase remains maintainable, testable, scalable, and consistent as the project evolves.

Every engineer and AI coding assistant is expected to follow these guidelines.

---

## Engineering Philosophy

Atlas is built for the next decade, not the next sprint.

### Priorities (in order)

1. **Correctness** over cleverness
2. **Readability** over brevity
3. **Simplicity** over unnecessary abstraction
4. **Maintainability** over premature optimization
5. **Long-term architecture** over short-term convenience

---

## Architectural Principles

### SOLID

All application code must follow SOLID principles:

- **S**ingle Responsibility — Classes have one reason to change
- **O**pen/Closed — Open for extension, closed for modification
- **L**iskov Substitution — Subtypes must be substitutable
- **I**nterface Segregation — Depend on specific interfaces, not fat ones
- **D**ependency Inversion — Depend on abstractions, not concretions

### Clean Architecture

Dependencies always point **inward**:

```
Presentation Layer
        ↓
Application Layer
        ↓
Domain Layer
        ↓
Infrastructure Layer
```

- Outer layers may depend on inner layers
- Inner layers **must never** depend on outer layers
- The domain layer is framework-agnostic

### Domain-Driven Design

Business logic belongs exclusively in the **Domain Layer**.

- Controllers, APIs, and UI **coordinate** business rules—they don't implement them
- The domain model represents real fitness concepts (Workout, Exercise, Skill, etc.)
- Business decisions should be testable without frameworks or databases

### Separation of Concerns

Each architectural layer has one responsibility:

**Presentation**
- HTTP request/response handling
- Authentication and authorization checks
- Input serialization/deserialization
- Format translation

**Application**
- Use case orchestration
- Command and query handling
- Permission verification
- Transaction management
- Event raising

**Domain**
- Business rules and constraints
- Entity behavior and lifecycle
- Value object definitions
- Aggregate design
- Domain events

**Infrastructure**
- Database access and persistence
- External API integration
- File storage and retrieval
- Email and notification sending
- Caching mechanisms
- Authentication providers

---

## Code Organization

### By Feature, Then by Concern

Organize code by **business capability first**, then by technical type:

```
Modules/
  Workouts/
    Application/
      Commands/
      Queries/
      Handlers/
    Domain/
      Workout.cs
      Exercise.cs
      Skill.cs
      WorkoutValidator.cs
    Infrastructure/
      WorkoutRepository.cs
      WorkoutQueries.cs
    Presentation/
      WorkoutController.cs

  Programs/
  Skills/
  Community/
```

**Never** create large "Services" or "Utilities" folders.

### Why Feature-Based?

- Features are self-contained and understandable
- Team members own vertical slices
- New engineers find code naturally
- Dependencies between features are explicit
- Removing features doesn't require hunting for scattered files

---

## Naming Conventions

### Classes & Types

Use **descriptive nouns** that represent concepts:

**Good:**
```csharp
WorkoutSession
ProgressCalculator
WorkoutCompletedEvent
SkillUnlocker
ConsistencyTracker
RecoveryEstimator
```

**Bad:**
```csharp
Manager
Handler
Processor
Utility
Service
Thing
DataHandler
```

Names should answer: "What is this?"

### Methods & Functions

Use **descriptive verbs** that explain what they do:

**Good:**
```csharp
CompleteWorkout()
CalculateWorkoutVolume()
UnlockSkill()
VerifyMilestoneEligibility()
EstimateRecoveryTime()
```

**Bad:**
```csharp
DoStuff()
Handle()
Process()
Execute()
RunLogic()
DoThing()
```

Methods should be imperative: "What does this do?"

### Variables & Properties

Use **clear, intention-revealing names**:

**Good:**
```csharp
completedWorkout
totalVolume
userRecoveryScore
averageRepsPerSet
weeklyCosistencyPercentage
```

**Bad:**
```csharp
x, y, z
obj
data
temp
tmp
val
info
```

### Constants & Enums

Use **UPPER_SNAKE_CASE** for constants:

```csharp
const int MAX_WORKOUT_DURATION_MINUTES = 300;
const decimal MIN_RECOVERY_SCORE = 0.0m;
const string DEFAULT_TIMEZONE = "UTC";
```

---

## Method Design

### Single Responsibility

Each method should do **one thing well**.

Ask: "Can I describe this method in one sentence without using 'and'?"

If not, split it.

### Size

Aim for methods under 30 lines.

- Longer methods are harder to understand
- Longer methods are harder to test
- Longer methods often have hidden responsibilities

**Exceptions:** Builders and fluent APIs may be longer.

### Level of Abstraction

Statements in a method should be at the same level of abstraction.

**Bad** (mixed levels):
```csharp
public void ProcessWorkout(Workout workout)
{
    // High level
    var isValid = ValidateWorkout(workout);
    
    // Too low level
    if (workout.ExerciseIds.Count == 0) { ... }
    
    // High level
    SaveWorkout(workout);
}
```

**Good:**
```csharp
public void ProcessWorkout(Workout workout)
{
    ValidateWorkout(workout);
    SaveWorkout(workout);
    RaiseWorkoutCompletedEvent(workout);
}
```

### Testability

Methods should be testable in isolation:

- Avoid hard dependencies on databases or external services
- Use dependency injection
- Return values rather than side effects
- Keep logic pure where possible

---

## Class Design

### Single Responsibility

A class should have **one reason to change**.

If you're describing a class and use "and", it probably has multiple responsibilities.

**Bad:**
```csharp
public class WorkoutManager
{
    public void CreateWorkout() { }
    public void LogWorkout() { }
    public void CalculateStats() { }
    public void SaveToDatabase() { }
    public void SendEmail() { }
}
```

**Good:**
```csharp
public class WorkoutService
{
    public Workout Create(CreateWorkoutCommand command) { }
    public void Complete(CompleteWorkoutCommand command) { }
}

public class WorkoutStatisticsCalculator
{
    public WorkoutStats Calculate(Workout workout) { }
}

public class WorkoutRepository
{
    public void Save(Workout workout) { }
}
```

### Cohesion

Related data and behavior should be in the same class.

Avoid classes that are just bags of static utility methods.

### Immutability Where Possible

Value objects should be immutable:

```csharp
public record ExerciseSet(int Reps, decimal WeightKg, int DurationSeconds);
```

Entities can be mutable but should protect their invariants:

```csharp
public class Workout
{
    private List<Exercise> _exercises = new();
    
    public IReadOnlyList<Exercise> Exercises => _exercises.AsReadOnly();
    
    public void AddExercise(Exercise exercise)
    {
        if (_exercises.Count >= MAX_EXERCISES)
            throw new InvalidOperationException("Too many exercises");
        _exercises.Add(exercise);
    }
}
```

---

## Dependency Injection

**Always depend on abstractions**, not concrete implementations.

**Bad:**
```csharp
public class WorkoutService
{
    private readonly PostgreSqlWorkoutRepository _repository = 
        new PostgreSqlWorkoutRepository();
}
```

**Good:**
```csharp
public class WorkoutService
{
    private readonly IWorkoutRepository _repository;
    
    public WorkoutService(IWorkoutRepository repository)
    {
        _repository = repository;
    }
}
```

Benefits:
- Easy to test (inject test doubles)
- Easy to swap implementations
- Loose coupling
- Composition root handles wiring

---

## Business Logic Location

**Business rules belong exclusively in the Domain layer.**

### Never put business logic in:

- ✗ Controllers or API endpoints
- ✗ Flutter widgets or UI code
- ✗ API filters or middleware
- ✗ Database stored procedures
- ✗ Background jobs (they orchestrate, domain rules run in domain)

### Always put business logic in:

- ✓ Domain entities
- ✓ Domain services
- ✓ Value objects
- ✓ Business rule classes

---

## Entity Design

### Entities Should Enforce Invariants

Entities protect their own business rules. Don't let callers break invariants.

**Bad:**
```csharp
workout.Status = WorkoutStatus.Completed;
```

An invalid status might be set. No validation. No side effects.

**Good:**
```csharp
workout.Complete();
```

The entity decides:
- Can the workout be completed?
- What should happen when it completes?
- What events should be raised?

### Behavior vs. Data

Entities should expose **behavior**, not just data:

**Bad:**
```csharp
public class Workout
{
    public int TotalVolume { get; set; }
    public bool IsMilestoneReached { get; set; }
}

// Callers calculate
if (workout.TotalVolume > 5000)
    workout.IsMilestoneReached = true;
```

**Good:**
```csharp
public class Workout
{
    public void CompleteExercise(Exercise exercise)
    {
        _exercises.Add(exercise);
        
        if (CalculateVolume() > 5000)
            RaiseMilestoneReachedEvent();
    }
    
    public int GetTotalVolume() => ...;
}
```

---

## Code Quality Standards

Every contribution should satisfy:

1. **Readable** — Clear to others on first reading
2. **Testable** — Can be unit tested
3. **Maintainable** — Easy to change
4. **Consistent** — Follows established patterns
5. **Performant** — No obvious inefficiencies
6. **Documented** — Non-obvious intent is explained
7. **Safe** — Null-safe, boundary-safe, exception-safe

---

## Refactoring

Refactoring is ongoing, not occasional.

- Small refactorings keep code quality high
- Regular refactoring prevents design erosion
- Refactoring is safer than large rewrites
- Tests protect refactoring

Bad habits that necessitate large refactorings:
- Ignoring SOLID violations
- Accumulating "just for now" hacks
- Allowing dead code to remain
- Not questioning design decisions

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

Write code that your future self and every future teammate will thank you for.

Atlas is intended to last for years.

Its code should reflect that ambition.
