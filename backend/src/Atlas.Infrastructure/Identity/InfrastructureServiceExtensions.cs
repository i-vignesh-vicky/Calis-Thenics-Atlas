using Atlas.Application.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Atlas.Infrastructure.Identity;

public static class InfrastructureServiceExtensions
{
    // Reads config keys lazily at first resolve so WebApplicationFactory's
    // ConfigureAppConfiguration callbacks are already applied by then.
    public static IServiceCollection AddTokenService(this IServiceCollection services)
    {
        services.AddSingleton<ITokenService>(sp =>
        {
            var cfg = sp.GetRequiredService<IConfiguration>();
            var secret  = cfg["App:JwtSecret"]   ?? throw new InvalidOperationException("App:JwtSecret is required.");
            var issuer   = cfg["App:JwtIssuer"]   ?? throw new InvalidOperationException("App:JwtIssuer is required.");
            var audience = cfg["App:JwtAudience"] ?? throw new InvalidOperationException("App:JwtAudience is required.");
            return new JwtTokenService(secret, issuer, audience);
        });
        return services;
    }
}
