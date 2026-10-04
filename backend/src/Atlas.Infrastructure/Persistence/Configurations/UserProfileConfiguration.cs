using Atlas.Domain.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Atlas.Infrastructure.Persistence.Configurations;

internal sealed class UserProfileConfiguration : IEntityTypeConfiguration<UserProfile>
{
    public void Configure(EntityTypeBuilder<UserProfile> builder)
    {
        builder.ToTable("user_profiles");

        builder.HasKey(p => p.UserId);
        builder.Property(p => p.UserId).ValueGeneratedNever();

        builder.Property(p => p.FirstName).IsRequired().HasMaxLength(100);
        builder.Property(p => p.Sex).HasMaxLength(20);
        builder.Property(p => p.ExperienceLevel).HasMaxLength(50);
        builder.Property(p => p.PrimaryGoal).HasMaxLength(50);
        builder.Property(p => p.Frequency).HasMaxLength(50);
        builder.Property(p => p.SessionLength).HasMaxLength(20);

        builder.Property(p => p.Locations).HasColumnType("text[]").IsRequired();
        builder.Property(p => p.Equipment).HasColumnType("text[]").IsRequired();
        builder.Property(p => p.Injuries).HasColumnType("text[]").IsRequired();

        builder.Property(p => p.CompletedAt).IsRequired();

        builder.HasOne(p => p.User)
            .WithOne()
            .HasForeignKey<UserProfile>(p => p.UserId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
