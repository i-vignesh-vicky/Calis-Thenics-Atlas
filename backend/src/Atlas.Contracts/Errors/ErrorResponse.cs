namespace Atlas.Contracts.Errors;

public sealed record ErrorEnvelope(ErrorBody Error);

public sealed record ErrorBody(
    string Code,
    string Message,
    IReadOnlyList<ErrorDetail> Details,
    string TraceId,
    DateTimeOffset Timestamp);
