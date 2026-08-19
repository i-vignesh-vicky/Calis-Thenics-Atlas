using Atlas.Contracts.Errors;
using Microsoft.AspNetCore.Diagnostics;

namespace Atlas.Api.Middleware;

internal sealed class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        logger.LogError(exception, "Unhandled exception");

        var traceId = httpContext.TraceIdentifier;
        var body = new ErrorBody(
            Code: "INTERNAL_SERVER_ERROR",
            Message: "An unexpected error occurred.",
            Details: [],
            TraceId: traceId,
            Timestamp: DateTimeOffset.UtcNow);

        httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;
        httpContext.Response.ContentType = "application/json";

        await httpContext.Response.WriteAsJsonAsync(new ErrorEnvelope(body), cancellationToken);
        return true;
    }
}
