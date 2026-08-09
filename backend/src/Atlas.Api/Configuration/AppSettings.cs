using System.ComponentModel.DataAnnotations;

namespace Atlas.Api.Configuration;

public sealed class AppSettings
{
    public const string SectionName = "App";

    [Required]
    public required string JwtSecret { get; init; }

    [Required]
    public required string JwtIssuer { get; init; }

    [Required]
    public required string JwtAudience { get; init; }
}
