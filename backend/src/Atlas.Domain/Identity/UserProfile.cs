namespace Atlas.Domain.Identity;

public sealed class UserProfile
{
    private UserProfile() { }

    public Guid UserId { get; private set; }
    public User User { get; private set; } = null!;

    public string FirstName { get; private set; } = string.Empty;
    public string? Sex { get; private set; }
    public int? WeightKg { get; private set; }
    public int? HeightCm { get; private set; }
    public string? ExperienceLevel { get; private set; }
    public string? PrimaryGoal { get; private set; }
    public List<string> Locations { get; private set; } = [];
    public List<string> Equipment { get; private set; } = [];
    public string? Frequency { get; private set; }
    public string? SessionLength { get; private set; }
    public List<string> Injuries { get; private set; } = [];
    public int? AssessmentPullUps { get; private set; }
    public int? AssessmentPushUps { get; private set; }
    public int? AssessmentDips { get; private set; }
    public DateTimeOffset CompletedAt { get; private set; }

    public static UserProfile Create(
        Guid userId,
        string firstName,
        string? sex,
        int? weightKg,
        int? heightCm,
        string? experienceLevel,
        string? primaryGoal,
        List<string> locations,
        List<string> equipment,
        string? frequency,
        string? sessionLength,
        List<string> injuries,
        int? assessmentPullUps,
        int? assessmentPushUps,
        int? assessmentDips,
        DateTimeOffset completedAt) => new()
    {
        UserId = userId,
        FirstName = firstName,
        Sex = sex,
        WeightKg = weightKg,
        HeightCm = heightCm,
        ExperienceLevel = experienceLevel,
        PrimaryGoal = primaryGoal,
        Locations = locations,
        Equipment = equipment,
        Frequency = frequency,
        SessionLength = sessionLength,
        Injuries = injuries,
        AssessmentPullUps = assessmentPullUps,
        AssessmentPushUps = assessmentPushUps,
        AssessmentDips = assessmentDips,
        CompletedAt = completedAt,
    };

    public void Update(
        string firstName,
        string? sex,
        int? weightKg,
        int? heightCm,
        string? experienceLevel,
        string? primaryGoal,
        List<string> locations,
        List<string> equipment,
        string? frequency,
        string? sessionLength,
        List<string> injuries,
        int? assessmentPullUps,
        int? assessmentPushUps,
        int? assessmentDips,
        DateTimeOffset completedAt)
    {
        FirstName = firstName;
        Sex = sex;
        WeightKg = weightKg;
        HeightCm = heightCm;
        ExperienceLevel = experienceLevel;
        PrimaryGoal = primaryGoal;
        Locations = locations;
        Equipment = equipment;
        Frequency = frequency;
        SessionLength = sessionLength;
        Injuries = injuries;
        AssessmentPullUps = assessmentPullUps;
        AssessmentPushUps = assessmentPushUps;
        AssessmentDips = assessmentDips;
        CompletedAt = completedAt;
    }
}
