using System.Text;
using Atlas.Api.Configuration;
using Atlas.Api.Endpoints;
using Atlas.Api.Middleware;
using Atlas.Infrastructure.Identity;
using Atlas.Infrastructure.Persistence;
using Atlas.Shared;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseSerilog((ctx, services, config) =>
    config
        .ReadFrom.Configuration(ctx.Configuration)
        .ReadFrom.Services(services)
        .Enrich.FromLogContext()
        .WriteTo.Console(outputTemplate:
            "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj} {Properties:j}{NewLine}{Exception}"));

builder.Services.AddOptions<AppSettings>()
    .BindConfiguration(AppSettings.SectionName)
    .ValidateDataAnnotations()
    .ValidateOnStart();

builder.Services.AddDbContext<AtlasDbContext>(options =>
    options
        .UseNpgsql(builder.Configuration.GetConnectionString("AtlasDb"))
        .UseSnakeCaseNamingConvention());

// Authentication: options resolved lazily so test ConfigureAppConfiguration runs first.
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer();

builder.Services.AddSingleton<IConfigureOptions<JwtBearerOptions>>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<AppSettings>>().Value;
    return new ConfigureOptions<JwtBearerOptions>(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = settings.JwtIssuer,
            ValidAudience = settings.JwtAudience,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(settings.JwtSecret)),
            ClockSkew = TimeSpan.FromSeconds(30),
        };
    });
});

builder.Services.AddAuthorization();

builder.Services.AddTokenService();

builder.Services.AddSingleton<IClock, SystemClock>();
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
builder.Services.AddProblemDetails();

var app = builder.Build();

app.UseExceptionHandler();
app.UseSerilogRequestLogging();
app.UseAuthentication();
app.UseAuthorization();

var api = app.MapGroup("/api/v1");

api.MapGet("/health", () => Results.Ok(new { status = "healthy" }))
   .WithName("GetHealth")
   .AllowAnonymous();

api.MapAuthEndpoints();

app.Run();

public partial class Program { }
