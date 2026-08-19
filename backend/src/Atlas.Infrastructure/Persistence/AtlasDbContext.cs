using Microsoft.EntityFrameworkCore;
using UUIDNext;

namespace Atlas.Infrastructure.Persistence;

public sealed class AtlasDbContext : DbContext
{
    public AtlasDbContext(DbContextOptions<AtlasDbContext> options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AtlasDbContext).Assembly);
    }

    protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
    {
        // All Guid PKs default to UUID v7 via value generator wired per entity config.
        // All DateTimeOffset properties map to timestamptz (handled by Npgsql provider).
    }
}
