using Atlas.Domain.Identity;

namespace Atlas.Application.Identity;

public interface ITokenService
{
    string GenerateAccessToken(User user);
    string GenerateRefreshToken();
}
