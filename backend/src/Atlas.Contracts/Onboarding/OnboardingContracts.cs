namespace Atlas.Contracts.Onboarding;

public sealed record CompleteOnboardingRequest(
    string FirstName,
    string? Sex,
    int? WeightKg,
    int? HeightCm,
    string? ExperienceLevel,
    string? PrimaryGoal,
    List<string> Locations,
    List<string> Equipment,
    string? Frequency,
    string? SessionLength,
    List<string> Injuries,
    AssessmentDto? Assessment);

public sealed record AssessmentDto(int? PullUps, int? PushUps, int? Dips);
