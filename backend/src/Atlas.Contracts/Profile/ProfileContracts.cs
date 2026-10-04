namespace Atlas.Contracts.Profile;

public sealed record ProfileResponse(
    Guid Id,
    string Email,
    string DisplayName,
    DateTimeOffset CreatedAt,
    ProfileDetailsDto? Profile);

public sealed record ProfileDetailsDto(
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
    ProfileAssessmentDto Assessment);

public sealed record ProfileAssessmentDto(int? PullUps, int? PushUps, int? Dips);

public sealed record UpdateProfileRequest(
    string? DisplayName,
    string? FirstName,
    string? Sex,
    int? WeightKg,
    int? HeightCm);
