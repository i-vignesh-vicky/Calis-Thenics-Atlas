namespace Atlas.Shared;

public interface IClock
{
    DateTimeOffset UtcNow { get; }
}
