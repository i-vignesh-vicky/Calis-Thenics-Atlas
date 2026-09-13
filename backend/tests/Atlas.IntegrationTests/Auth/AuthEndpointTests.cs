using System.Net;
using System.Net.Http.Json;
using Atlas.Contracts.Auth;
using Atlas.Infrastructure.Persistence;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace Atlas.IntegrationTests.Auth;

public abstract class AuthTestBase : IClassFixture<WebApplicationFactory<Program>>
{
    protected readonly HttpClient Client;

    protected AuthTestBase(WebApplicationFactory<Program> factory)
    {
        var dbName = Guid.NewGuid().ToString();

        Client = factory
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureAppConfiguration((_, cfg) =>
                    cfg.AddInMemoryCollection(new Dictionary<string, string?>
                    {
                        ["App:JwtSecret"]             = "test-secret-at-least-32-chars-long!!",
                        ["App:JwtIssuer"]             = "atlas-test",
                        ["App:JwtAudience"]           = "atlas-test",
                        ["ConnectionStrings:AtlasDb"] = "Host=noop",
                    }));

                builder.ConfigureTestServices(services =>
                {
                    // Remove DbContextOptions and all provider-specific option configurations
                    // so Npgsql and InMemory don't both end up registered.
                    var toRemove = services
                        .Where(d =>
                            d.ServiceType == typeof(DbContextOptions<AtlasDbContext>) ||
                            (d.ServiceType.IsGenericType &&
                             d.ServiceType.GetGenericTypeDefinition() == typeof(IDbContextOptionsConfiguration<>) &&
                             d.ServiceType.GenericTypeArguments.Length == 1 &&
                             d.ServiceType.GenericTypeArguments[0] == typeof(AtlasDbContext)))
                        .ToList();

                    foreach (var d in toRemove) services.Remove(d);

                    services.AddDbContext<AtlasDbContext>(
                        o => o.UseInMemoryDatabase(dbName));
                });
            })
            .CreateClient();
    }
}

// ─── /register ────────────────────────────────────────────────────────────────

public sealed class RegisterTests(WebApplicationFactory<Program> factory)
    : AuthTestBase(factory)
{
    [Fact]
    public async Task Register_HappyPath_Returns200WithTokens()
    {
        var response = await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "alice@example.com", "Password1!", "Alice"));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var body = await response.Content.ReadFromJsonAsync<AuthResponse>();
        Assert.NotNull(body);
        Assert.False(string.IsNullOrWhiteSpace(body.AccessToken));
        Assert.False(string.IsNullOrWhiteSpace(body.RefreshToken));
        Assert.Equal("alice@example.com", body.User.Email);
        Assert.Equal("Alice", body.User.DisplayName);
        Assert.NotEqual(Guid.Empty, body.User.Id);
    }

    [Fact]
    public async Task Register_DuplicateEmail_Returns409()
    {
        await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "bob@example.com", "Password1!", "Bob"));

        var response = await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "BOB@EXAMPLE.COM", "DifferentPass1!", "Bob2"));

        Assert.Equal(HttpStatusCode.Conflict, response.StatusCode);
    }

    [Fact]
    public async Task Register_EmailStoredLowercased()
    {
        var response = await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "Carol@EXAMPLE.COM", "Password1!", "Carol"));

        var body = await response.Content.ReadFromJsonAsync<AuthResponse>();
        Assert.Equal("carol@example.com", body!.User.Email);
    }
}

// ─── /login ───────────────────────────────────────────────────────────────────

public sealed class LoginTests(WebApplicationFactory<Program> factory)
    : AuthTestBase(factory)
{
    [Fact]
    public async Task Login_ValidCredentials_Returns200WithTokens()
    {
        await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "dan@example.com", "Password1!", "Dan"));

        var response = await Client.PostAsJsonAsync("/api/v1/auth/login", new LoginRequest(
            "dan@example.com", "Password1!"));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var body = await response.Content.ReadFromJsonAsync<AuthResponse>();
        Assert.NotNull(body);
        Assert.False(string.IsNullOrWhiteSpace(body.AccessToken));
        Assert.False(string.IsNullOrWhiteSpace(body.RefreshToken));
    }

    [Fact]
    public async Task Login_WrongPassword_Returns401()
    {
        await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "eve@example.com", "Password1!", "Eve"));

        var response = await Client.PostAsJsonAsync("/api/v1/auth/login", new LoginRequest(
            "eve@example.com", "WrongPass!"));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Login_UnknownEmail_Returns401()
    {
        var response = await Client.PostAsJsonAsync("/api/v1/auth/login", new LoginRequest(
            "nobody@example.com", "Password1!"));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Login_EmailCaseInsensitive_Returns200()
    {
        await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "frank@example.com", "Password1!", "Frank"));

        var response = await Client.PostAsJsonAsync("/api/v1/auth/login", new LoginRequest(
            "FRANK@EXAMPLE.COM", "Password1!"));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}

// ─── /refresh ─────────────────────────────────────────────────────────────────

public sealed class RefreshTests(WebApplicationFactory<Program> factory)
    : AuthTestBase(factory)
{
    [Fact]
    public async Task Refresh_ValidToken_Returns200WithNewTokens()
    {
        var reg = await (await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "grace@example.com", "Password1!", "Grace")))
            .Content.ReadFromJsonAsync<AuthResponse>();

        var response = await Client.PostAsJsonAsync("/api/v1/auth/refresh", new RefreshRequest(
            reg!.RefreshToken));

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var body = await response.Content.ReadFromJsonAsync<AuthResponse>();
        Assert.NotNull(body);
        Assert.False(string.IsNullOrWhiteSpace(body.AccessToken));
        Assert.False(string.IsNullOrWhiteSpace(body.RefreshToken));
        Assert.NotEqual(reg.RefreshToken, body.RefreshToken);
    }

    [Fact]
    public async Task Refresh_RevokedToken_Returns401()
    {
        var reg = await (await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "hank@example.com", "Password1!", "Hank")))
            .Content.ReadFromJsonAsync<AuthResponse>();

        await Client.PostAsJsonAsync("/api/v1/auth/refresh", new RefreshRequest(reg!.RefreshToken));

        var response = await Client.PostAsJsonAsync("/api/v1/auth/refresh", new RefreshRequest(
            reg.RefreshToken));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }

    [Fact]
    public async Task Refresh_UnknownToken_Returns401()
    {
        var response = await Client.PostAsJsonAsync("/api/v1/auth/refresh", new RefreshRequest(
            "totally-fake-token-value"));

        Assert.Equal(HttpStatusCode.Unauthorized, response.StatusCode);
    }
}

// ─── /logout ──────────────────────────────────────────────────────────────────

public sealed class LogoutTests(WebApplicationFactory<Program> factory)
    : AuthTestBase(factory)
{
    [Fact]
    public async Task Logout_ValidToken_Returns204()
    {
        var reg = await (await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "iris@example.com", "Password1!", "Iris")))
            .Content.ReadFromJsonAsync<AuthResponse>();

        var response = await Client.PostAsJsonAsync("/api/v1/auth/logout", new LogoutRequest(
            reg!.RefreshToken));

        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);
    }

    [Fact]
    public async Task Logout_AfterLogout_RefreshTokenIsRevoked()
    {
        var reg = await (await Client.PostAsJsonAsync("/api/v1/auth/register", new RegisterRequest(
            "jake@example.com", "Password1!", "Jake")))
            .Content.ReadFromJsonAsync<AuthResponse>();

        await Client.PostAsJsonAsync("/api/v1/auth/logout", new LogoutRequest(reg!.RefreshToken));

        var refreshResponse = await Client.PostAsJsonAsync("/api/v1/auth/refresh", new RefreshRequest(
            reg.RefreshToken));

        Assert.Equal(HttpStatusCode.Unauthorized, refreshResponse.StatusCode);
    }

    [Fact]
    public async Task Logout_UnknownToken_Returns204()
    {
        var response = await Client.PostAsJsonAsync("/api/v1/auth/logout", new LogoutRequest(
            "nonexistent-token"));

        Assert.Equal(HttpStatusCode.NoContent, response.StatusCode);
    }
}
