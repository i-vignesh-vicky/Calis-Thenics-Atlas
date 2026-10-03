using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Atlas.Contracts.Onboarding;
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

        return app;
    }

    private static async Task<IResult> CompleteOnboarding(
        CompleteOnboardingRequest req,
        ClaimsPrincipal principal,
        AtlasDbContext db,
        IClock clock)
    {
        var sub = principal.FindFirstValue(JwtRegisteredClaimNames.Sub);
        if (sub is null || !Guid.TryParse(sub, out var userId))
            return Results.Unauthorized();

        var now = clock.UtcNow;

        var existing = await db.UserProfiles.FirstOrDefaultAsync(p => p.UserId == userId);

        if (existing is null)
        {
            var profile = UserProfile.Create(
                userId: userId,
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
}
