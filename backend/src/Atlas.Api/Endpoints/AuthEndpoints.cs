using Atlas.Application.Identity;
using Atlas.Contracts.Auth;
using Atlas.Domain.Identity;
using Atlas.Infrastructure.Persistence;
using Atlas.Shared;
using BCrypt.Net;
using Microsoft.EntityFrameworkCore;

namespace Atlas.Api.Endpoints;

internal static class AuthEndpoints
{
    internal static IEndpointRouteBuilder MapAuthEndpoints(this IEndpointRouteBuilder app)
    {
        var auth = app.MapGroup("/auth");

        auth.MapPost("/register", Register).AllowAnonymous();
        auth.MapPost("/login", Login).AllowAnonymous();
        auth.MapPost("/refresh", Refresh).AllowAnonymous();
        auth.MapPost("/logout", Logout).AllowAnonymous();

        return app;
    }

    private static async Task<IResult> Register(
        RegisterRequest req,
        AtlasDbContext db,
        ITokenService tokens,
        IClock clock)
    {
        if (await db.Users.AnyAsync(u => u.Email == req.Email.ToLowerInvariant()))
            return Results.Conflict(new { error = "Email already registered." });

        var hash = BCrypt.Net.BCrypt.HashPassword(req.Password, workFactor: 12);
        var now = clock.UtcNow;
        var user = User.Register(req.Email, hash, req.DisplayName, now);
        db.Users.Add(user);

        var refreshTokenValue = tokens.GenerateRefreshToken();
        var refreshToken = RefreshToken.Create(user.Id, refreshTokenValue, now.AddDays(7), now);
        db.RefreshTokens.Add(refreshToken);

        await db.SaveChangesAsync();

        var accessToken = tokens.GenerateAccessToken(user);
        return Results.Ok(new AuthResponse(
            accessToken,
            refreshTokenValue,
            new UserSummary(user.Id, user.Email, user.DisplayName)));
    }

    private static async Task<IResult> Login(
        LoginRequest req,
        AtlasDbContext db,
        ITokenService tokens,
        IClock clock)
    {
        var user = await db.Users.FirstOrDefaultAsync(u => u.Email == req.Email.ToLowerInvariant());
        if (user is null || !BCrypt.Net.BCrypt.Verify(req.Password, user.PasswordHash))
            return Results.Unauthorized();

        var now = clock.UtcNow;
        var refreshTokenValue = tokens.GenerateRefreshToken();
        var refreshToken = RefreshToken.Create(user.Id, refreshTokenValue, now.AddDays(7), now);
        db.RefreshTokens.Add(refreshToken);
        await db.SaveChangesAsync();

        var accessToken = tokens.GenerateAccessToken(user);
        return Results.Ok(new AuthResponse(
            accessToken,
            refreshTokenValue,
            new UserSummary(user.Id, user.Email, user.DisplayName)));
    }

    private static async Task<IResult> Refresh(
        RefreshRequest req,
        AtlasDbContext db,
        ITokenService tokens,
        IClock clock)
    {
        var now = clock.UtcNow;
        var existing = await db.RefreshTokens
            .Include(rt => rt.User)
            .FirstOrDefaultAsync(rt => rt.Token == req.RefreshToken);

        if (existing is null || !existing.IsActive)
            return Results.Unauthorized();

        existing.Revoke(now);

        var newRefreshValue = tokens.GenerateRefreshToken();
        var newRefresh = RefreshToken.Create(existing.UserId, newRefreshValue, now.AddDays(7), now);
        db.RefreshTokens.Add(newRefresh);
        await db.SaveChangesAsync();

        var accessToken = tokens.GenerateAccessToken(existing.User);
        return Results.Ok(new AuthResponse(
            accessToken,
            newRefreshValue,
            new UserSummary(existing.User.Id, existing.User.Email, existing.User.DisplayName)));
    }

    private static async Task<IResult> Logout(
        LogoutRequest req,
        AtlasDbContext db,
        IClock clock)
    {
        var token = await db.RefreshTokens.FirstOrDefaultAsync(rt => rt.Token == req.RefreshToken);
        if (token is not null && token.IsActive)
        {
            token.Revoke(clock.UtcNow);
            await db.SaveChangesAsync();
        }
        return Results.NoContent();
    }
}
