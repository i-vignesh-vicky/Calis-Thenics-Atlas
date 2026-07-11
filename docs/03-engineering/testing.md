# Testing Strategy

> "Testing is not about increasing code coverage. Testing is about increasing confidence."

## Purpose

This document defines the testing philosophy and strategy for Calis-Thenics-Atlas.

Objective: Ensure the platform remains reliable, maintainable, and safe to evolve as new features are introduced. Testing should provide confidence that business rules, user workflows, and system integrations continue to function correctly.

**Key Distinction:** We aim for 100% confidence in our critical business logic, not 100% code coverage. Chasing coverage percentages often leads to brittle tests with little value.

---

## Testing Philosophy

Atlas values:

1. **Confidence** over coverage percentages
2. **Business behavior** over implementation details
3. **Fast feedback** — Tests should run quickly
4. **Deterministic tests** — Same input always produces same output
5. **Readable tests** — Tests should document behavior
6. **Maintainability** — Tests should be easy to update

**Goal:** A passing test suite gives engineers confidence to refactor fearlessly.

---

## Testing Pyramid

Atlas follows the traditional testing pyramid:

```
        ┌───────────────┐
        │  E2E Tests    │  5%
        │   (Critical)  │
        ├───────────────┤
        │ Integration   │  25%
        │    Tests      │
        ├───────────────┤
        │  Unit Tests   │  70%
        │   (Fast)      │
        └───────────────┘
```

Distribution is a guideline, not a strict rule. Focus on testing what matters.

---

## Unit Tests (70%)

### Purpose

Validate business logic in isolation.

### Characteristics

- ✓ Fast (milliseconds)
- ✓ Independent (no dependencies on other tests)
- ✓ No database access
- ✓ No network calls
- ✓ No file system access
- ✓ Deterministic (same result every run)

### What to Test

**Domain Logic:**
- Workout volume calculation
- Skill progression logic
- Recovery score calculation
- Consistency streak logic
- Milestone unlocking conditions
- Challenge eligibility

**Value Object Behavior:**
- Immutability
- Equality
- Validation

**Aggregate Rules:**
- Can an entity be in this state?
- What side effects occur?

### Example

```csharp
[Fact]
public void CompleteWorkout_ShouldUnlockMilestone_WhenVolumeThresholdMet()
{
    // Arrange
    var workout = new Workout(userId: 1, totalVolume: 5500);
    
    // Act
    workout.Complete();
    
    // Assert
    Assert.True(workout.IsMilestoneUnlocked);
    Assert.Single(workout.DomainEvents, 
        e => e is MilestoneUnlockedEvent);
}
```

### Tools

- xUnit or NUnit
- Moq or NSubstitute (for dependencies)
- FluentAssertions (readable assertions)

---

## Integration Tests (25%)

### Purpose

Verify that multiple components work together correctly.

### Characteristics

- ✓ Medium speed (seconds)
- ✓ May include database
- ✓ May include ORM (EF Core)
- ✓ May include external dependencies (mocked appropriately)
- ✓ Test real interactions

### What to Test

**Application Services:**
- Create workout
- Complete workout
- Join challenge
- Authenticate user
- Update profile

**Database Access:**
- Entity Framework queries
- Saved data persistence
- Relationships
- Data validation

**Service Integrations:**
- Cache read/write
- File upload
- Email sending (mocked)
- API calls (mocked)

### Example

```csharp
[Fact]
public async Task CreateWorkout_ShouldSaveAndReturnId()
{
    // Arrange
    using var context = new TestDbContext();
    var service = new WorkoutService(context);
    var command = new CreateWorkoutCommand(userId: 1, name: "Push Day");
    
    // Act
    var result = await service.CreateWorkout(command);
    
    // Assert
    Assert.NotEqual(0, result.Id);
    var saved = await context.Workouts.FindAsync(result.Id);
    Assert.NotNull(saved);
    Assert.Equal("Push Day", saved.Name);
}
```

---

## API Tests

### Purpose

Verify API behavior from the client's perspective.

### What to Validate

- HTTP status codes
- Request validation (400 errors)
- Authorization (403 errors)
- Response format and contracts
- Error response format
- Pagination
- Filtering

### Example

```csharp
[Fact]
public async Task GetWorkout_WithInvalidId_ShouldReturn404()
{
    // Arrange
    var client = new TestApiClient();
    
    // Act
    var response = await client.GetAsync("/api/v1/workouts/invalid-id");
    
    // Assert
    Assert.Equal(HttpStatusCode.NotFound, response.StatusCode);
    var error = await response.Content.ReadAsAsync<ErrorResponse>();
    Assert.Equal("WORKOUT_NOT_FOUND", error.Code);
}
```

---

## End-to-End Tests (5%)

### Purpose

Validate complete user journeys work correctly.

### What to Test

- Register account → Create routine → Log workout
- Create challenge → Invite users → Complete challenge
- Create program → Start workout → Log results

### Characteristics

- Slow (may take seconds or minutes)
- Test real application behavior
- Run against staging environment
- Use only for critical flows

### Example

```csharp
[Fact]
public async Task UserJourney_RegisterAndLogWorkout()
{
    // Arrange
    var app = new TestApplication();
    var client = app.CreateClient();
    
    // Act - Register
    var registerResponse = await client.PostAsJsonAsync(
        "/api/v1/auth/register",
        new { email = "user@test.com", password = "secure123" }
    );
    Assert.True(registerResponse.IsSuccessStatusCode);
    
    // Act - Create routine
    var routineResponse = await client.PostAsJsonAsync(
        "/api/v1/routines",
        new { name = "Morning Push" }
    );
    Assert.True(routineResponse.IsSuccessStatusCode);
    
    // Act - Log workout
    var workoutResponse = await client.PostAsJsonAsync(
        "/api/v1/workouts",
        new { routineId = 1, completedAt = DateTime.UtcNow }
    );
    Assert.Equal(HttpStatusCode.Created, workoutResponse.StatusCode);
}
```

---

## Test Organization

### By Feature

Organize tests with code:

```
tests/
  Atlas.UnitTests/
    Workouts/
      CompleteWorkoutTests.cs
      CalculateVolumeTests.cs
      WorkoutValidatorTests.cs
    Skills/
      SkillProgressionTests.cs
    Consistency/
      StreakCalculationTests.cs
  
  Atlas.IntegrationTests/
    Workouts/
      CreateWorkoutTests.cs
      CompleteWorkoutTests.cs
    Auth/
      AuthenticationTests.cs
  
  Atlas.ArchitectureTests/
    LayerDependencyTests.cs
    NamingConventionTests.cs
```

### Test Files

One test class per business behavior:

```csharp
public class CompleteWorkoutTests
{
    [Fact]
    public void ShouldMarkAsCompleted() { }
    
    [Fact]
    public void ShouldCalculateVolume() { }
    
    [Fact]
    public void ShouldUnlockMilestoneIfEligible() { }
    
    [Fact]
    public void ShouldThrowIfAlreadyCompleted() { }
}
```

---

## Test Naming

Tests should describe behavior, not implementation.

### Good Test Names

```csharp
CompleteWorkout_ShouldMarkAsCompleted()
CompleteWorkout_ShouldUnlockMilestone_WhenVolumeThresholdMet()
CreateWorkout_ShouldThrowException_WhenNameIsEmpty()
CalculateVolume_ShouldSumAllSets()
```

### Bad Test Names

```csharp
Test1()
WorkoutTest()
TestComplete()
DoTest()
```

---

## Arrange / Act / Assert

Every test should follow AAA pattern:

```csharp
[Fact]
public void CompleteWorkout_ShouldMarkAsCompleted()
{
    // ARRANGE - Set up test data
    var workout = new Workout(userId: 1);
    
    // ACT - Perform the action
    workout.Complete();
    
    // ASSERT - Verify the result
    Assert.True(workout.IsCompleted);
}
```

Keep these phases distinct and clear.

---

## One Assertion per Test

Prefer one logical assertion per test:

```csharp
[Fact]
public void ShouldUnlockMilestone() // One behavior
{
    // ...
    Assert.True(workout.MilestoneUnlocked);
}
```

Multiple related assertions to verify one behavior are acceptable:

```csharp
[Fact]
public void ShouldUpdateWorkout() // One behavior (with multiple assertions)
{
    // ...
    Assert.Equal(expectedVolume, workout.Volume);
    Assert.Equal(expectedTime, workout.Duration);
    Assert.True(workout.IsCompleted);
}
```

---

## Test Independence

Every test must be independent:

- ✓ Tests can run in any order
- ✓ Tests don't depend on other tests
- ✓ Tests can run in parallel
- ✓ Clean up after themselves

**Bad:**
```csharp
[Fact]
public void Test1() { /* creates data */ }

[Fact]
public void Test2() { /* depends on Test1's data */ }
```

**Good:**
```csharp
[Fact]
public void Test1() 
{ 
    var data = CreateTestData();
    // Use data
    CleanUp(data);
}

[Fact]
public void Test2() 
{ 
    var data = CreateTestData();
    // Independent setup
}
```

---

## Deterministic Tests

Tests must produce consistent results.

### Avoid

- ✗ Random values
- ✗ Current system time (DateTime.Now)
- ✗ External APIs
- ✗ Database not in known state
- ✗ Network calls

### Inject Dependencies

```csharp
// Create a clock abstraction
public interface IClock { DateTime UtcNow { get; } }

// Inject in tests
var testClock = new TestClock(new DateTime(2025, 1, 15));
var service = new WorkoutService(testClock);
```

---

## Test Data Management

### Use Builders or Factories

```csharp
var workout = new WorkoutBuilder()
    .WithUserId(1)
    .WithExercises(3)
    .WithVolume(5000)
    .Build();
```

### Avoid Manual Construction

```csharp
// Instead of:
var workout = new Workout(1, "Push", true, 45, [...], [...], 5000);

// Use:
var workout = WorkoutTestBuilder.Default().Build();
```

---

## Mocking & Test Doubles

### When to Mock

Mock external dependencies:
- ✓ Database (use in-memory or test DB)
- ✓ Email service
- ✓ External APIs
- ✓ File storage

Don't mock:
- ✗ Business logic
- ✗ Value objects
- ✗ Entities (test real ones)

### Mock Tools

- **Moq** — Recommended for .NET
- **NSubstitute** — Fluent API
- **Manual fakes** — Simple cases

---

## Architecture Tests

Enforce structural rules:

```csharp
[Fact]
public void DomainLayer_ShouldNotDependOnInfrastructure()
{
    var assembly = typeof(Workout).Assembly;
    var result = new ArchUnitNET.Loader.ArchLoader()
        .LoadAssemblies(assembly)
        .Build()
        .Subjects;
    
    Classes()
        .That()
        .ResideInNamespace("*.Domain")
        .Should()
        .NotDependOnAny(
            Classes()
                .That()
                .ResideInNamespace("*.Infrastructure")
        )
        .Check(result);
}
```

---

## Test Checklist

Before committing:

- ✓ Does the test have a clear name?
- ✓ Does it follow AAA pattern?
- ✓ Is it independent?
- ✓ Is it deterministic?
- ✓ Does it test behavior, not implementation?
- ✓ Is it fast enough?
- ✓ Does it make assertions that matter?
- ✓ Would this fail if the business logic breaks?

---

## Continuous Integration

Tests should run:

- ✓ On every commit (pre-commit hooks)
- ✓ On every pull request
- ✓ Before merge to main
- ✓ Regularly (nightly or continuous)

**Build should fail if tests fail.**

---

## Test Metrics

Track:

- Code coverage (informational, not gospel)
- Test execution time
- Test success rate
- Tests added per feature

Don't obsess over coverage percentage. Focus on meaningful tests.

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

Confidence-not coverage-is the ultimate measure of testing quality.

