namespace Atlas.Domain.Identity;

public sealed class User
{
    private User() { }

    public Guid Id { get; private set; }
    public string Email { get; private set; } = string.Empty;
    public string PasswordHash { get; private set; } = string.Empty;
    public string DisplayName { get; private set; } = string.Empty;
    public DateTimeOffset CreatedAt { get; private set; }
    public DateTimeOffset UpdatedAt { get; private set; }

    public ICollection<RefreshToken> RefreshTokens { get; private set; } = [];

    public static User Register(string email, string passwordHash, string displayName, DateTimeOffset now)
    {
        return new User
        {
            Email = email.ToLowerInvariant(),
            PasswordHash = passwordHash,
            DisplayName = displayName,
            CreatedAt = now,
            UpdatedAt = now,
        };
    }
}
