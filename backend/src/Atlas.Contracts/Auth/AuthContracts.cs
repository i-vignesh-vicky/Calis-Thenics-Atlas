namespace Atlas.Contracts.Auth;

public sealed record RegisterRequest(string Email, string Password, string DisplayName);
public sealed record LoginRequest(string Email, string Password);
public sealed record RefreshRequest(string RefreshToken);
public sealed record LogoutRequest(string RefreshToken);

public sealed record AuthResponse(string AccessToken, string RefreshToken, UserSummary User);
public sealed record UserSummary(Guid Id, string Email, string DisplayName);
