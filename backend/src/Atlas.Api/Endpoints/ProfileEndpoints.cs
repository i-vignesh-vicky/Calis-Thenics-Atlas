using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Atlas.Contracts.Onboarding;
using Atlas.Contracts.Profile;
using Atlas.Domain.Identity;
using Atlas.Infrastructure.Persistence;
using Atlas.Shared;
using Microsoft.EntityFrameworkCore;

namespace Atlas.Api.Endpoints;

internal static class ProfileEndpoints
{
    internal static IEndpointRouteBuilder MapProfileEndpoints(this IEndpointRouteBuilder app)
    {
        var profile = app.MapGroup("/profile").RequireAuthorization();

        profile.MapPost("/onboarding", CompleteOnboarding);
        profile.MapGet("", GetProfile);
        profile.MapPatch("", UpdateProfile);

        return app;
    }

    private static async Task<IResult> GetProfile(
        ClaimsPrincipal principal,
        AtlasDbContext db)
    {
        var userId = ParseUserId(principal);
        if (userId is null) return Results.Unauthorized();

        var user = await db.Users.AsNoTracking().FirstOrDefaultAsync(u => u.Id == userId.Value);
        if (user is null) return Results.NotFound();

        var up = await db.UserProfiles.AsNoTracking().FirstOrDefaultAsync(p => p.UserId == userId.Value);

        var profileDto = up is null ? null : new ProfileDetailsDto(
            FirstName: up.FirstName,
            Sex: up.Sex,
            WeightKg: up.WeightKg,
            HeightCm: up.HeightCm,
            ExperienceLevel: up.ExperienceLevel,
            PrimaryGoal: up.PrimaryGoal,
            Locations: up.Locations,
            Equipment: up.Equipment,
            Frequency: up.Frequency,
            SessionLength: up.SessionLength,
            Injuries: up.Injuries,
            Assessment: new ProfileAssessmentDto(up.AssessmentPullUps, up.AssessmentPushUps, up.AssessmentDips));

        return Results.Ok(new ProfileResponse(
            Id: user.Id,
            Email: user.Email,
            DisplayName: user.DisplayName,
            CreatedAt: user.CreatedAt,
            Profile: profileDto));
    }

    private static async Task<IResult> UpdateProfile(
        UpdateProfileRequest req,
        ClaimsPrincipal principal,
        AtlasDbContext db,
        IClock clock)
    {
        var userId = ParseUserId(principal);
        if (userId is null) return Results.Unauthorized();

        var user = await db.Users.FirstOrDefaultAsync(u => u.Id == userId.Value);
        if (user is null) return Results.NotFound();

        var now = clock.UtcNow;

        if (!string.IsNullOrWhiteSpace(req.DisplayName))
            user.UpdateDisplayName(req.DisplayName.Trim(), now);

        var hasProfilePatch = req.FirstName is not null || req.Sex is not null || req.WeightKg is not null || req.HeightCm is not null;
        if (hasProfilePatch)
        {
            var up = await db.UserProfiles.FirstOrDefaultAsync(p => p.UserId == userId.Value);
            if (up is not null)
            {
                up.UpdateBasicInfo(
                    firstName: req.FirstName ?? up.FirstName,
                    sex: req.Sex ?? up.Sex,
                    weightKg: req.WeightKg ?? up.WeightKg,
                    heightCm: req.HeightCm ?? up.HeightCm,
                    now: now);
            }
        }

        await db.SaveChangesAsync();

        return Results.NoContent();
    }

    private static async Task<IResult> CompleteOnboarding(
        CompleteOnboardingRequest req,
        ClaimsPrincipal principal,
        AtlasDbContext db,
        IClock clock)
    {
        var userId = ParseUserId(principal);
        if (userId is null) return Results.Unauthorized();

        var now = clock.UtcNow;

        var existing = await db.UserProfiles.FirstOrDefaultAsync(p => p.UserId == userId.Value);

        if (existing is null)
        {
            var profile = UserProfile.Create(
                userId: userId.Value,
                firstName: req.FirstName,
                sex: req.Sex,
                weightKg: req.WeightKg,
                heightCm: req.HeightCm,
                experienceLevel: req.ExperienceLevel,
                primaryGoal: req.PrimaryGoal,
                locations: req.Locations ?? [],
                equipment: req.Equipment ?? [],
                frequency: req.Frequency,
                sessionLength: req.SessionLength,
                injuries: req.Injuries ?? [],
                assessmentPullUps: req.Assessment?.PullUps,
                assessmentPushUps: req.Assessment?.PushUps,
                assessmentDips: req.Assessment?.Dips,
                completedAt: now);

            db.UserProfiles.Add(profile);
        }
        else
        {
            existing.Update(
                firstName: req.FirstName,
                sex: req.Sex,
                weightKg: req.WeightKg,
                heightCm: req.HeightCm,
                experienceLevel: req.ExperienceLevel,
                primaryGoal: req.PrimaryGoal,
                locations: req.Locations ?? [],
                equipment: req.Equipment ?? [],
                frequency: req.Frequency,
                sessionLength: req.SessionLength,
                injuries: req.Injuries ?? [],
                assessmentPullUps: req.Assessment?.PullUps,
                assessmentPushUps: req.Assessment?.PushUps,
                assessmentDips: req.Assessment?.Dips,
                completedAt: now);
        }

        await db.SaveChangesAsync();

        return Results.NoContent();
    }

    private static Guid? ParseUserId(ClaimsPrincipal principal)
    {
        var sub = principal.FindFirstValue(JwtRegisteredClaimNames.Sub);
        return sub is not null && Guid.TryParse(sub, out var id) ? id : null;
    }
}
