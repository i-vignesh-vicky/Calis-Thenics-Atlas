# Observability

> "You can't improve what you can't observe."

## Purpose

This document defines the observability strategy for Calis-Thenics-Atlas.

Observability enables engineers to understand the health, performance, and behavior of the platform in production. The goal is to detect issues early, diagnose problems quickly, and continuously improve the user experience.

**Many startups only discover they need observability after production breaks. We build it in from day one.**

---

## Objectives

Atlas should provide visibility into:

- System health (is it up?)
- Application performance (how fast?)
- User experience (are users succeeding?)
- Infrastructure health (capacity, resources)
- Business events (are features working?)
- Failures (what went wrong?)
- Resource usage (costs, efficiency)

Observability is a first-class engineering concern, not an afterthought.

---

## Three Pillars of Observability

```
Logs              Metrics           Traces
(What happened)   (How much/many)    (How long)
```

Together, they provide complete system visibility.

---

## Logs

### Purpose

Record what happened, when, and why.

### Structured Logging

All application logs must be structured (JSON format):

```json
{
  "timestamp": "2025-01-15T10:30:00.123Z",
  "level": "INFO",
  "service": "atlas-api",
  "environment": "production",
  "correlationId": "req-abc-123",
  "requestId": "req-abc-123",
  "userId": "user-456",
  "module": "workouts",
  "message": "Workout completed successfully",
  "workoutId": "workout-789",
  "duration": 45,
  "volume": 5250,
  "exception": null
}
```

### Required Fields

Every log entry must include:

- **timestamp** — ISO 8601 UTC
- **level** — TRACE, DEBUG, INFO, WARNING, ERROR, CRITICAL
- **service** — Which service (e.g., atlas-api, ai-service)
- **environment** — prod, staging, dev
- **correlationId** — Trace request across services
- **requestId** — Unique per API request
- **message** — Human-readable description

### Optional Context

Add relevant context:

- **userId** — Who triggered this?
- **module** — Which feature/module?
- **action** — What action was performed?
- **duration** — How long did it take?
- **errorCode** — Error classification
- **statusCode** — HTTP status
- **exception** — Full stack trace if error

### Log Levels

**TRACE** — Very detailed diagnostic information
- Development only
- Example: Each SQL query executed

**DEBUG** — Useful for debugging
- Disabled in production unless troubleshooting
- Example: Function entry/exit

**INFO** — Normal application events (default)
- Workout completed
- User registered
- Payment processed
- API endpoint called
- Background job started

**WARNING** — Unexpected situations that don't stop execution
- Retry succeeded after failure
- Missing optional data
- API rate limit approaching
- Slow response time

**ERROR** — Recoverable failures
- Database timeout (will retry)
- External API call failed (will fallback)
- AI recommendation unavailable (skip)
- Duplicate email (user already exists)

**CRITICAL** — System or service failure requiring immediate attention
- Database unavailable
- Authentication service down
- Out of memory
- Disk full

### What to Log

**Always log:**
- ✓ Important business events (workout completed, skill unlocked)
- ✓ Errors and exceptions
- ✓ Performance bottlenecks
- ✓ Integration failures (API calls, database)
- ✓ Authentication events (login, logout, failed attempts)
- ✓ Permission denials
- ✓ Data modifications (create, update, delete)

**Never log:**
- ✗ Passwords
- ✗ JWT tokens or access tokens
- ✗ Refresh tokens
- ✗ API keys or secrets
- ✗ Sensitive health data (full body measurements)
- ✗ Large request/response payloads

### Logging Best Practices

```csharp
// Good - Clear context
logger.LogInformation(
    "Workout completed: {@Workout}",
    new { WorkoutId = 123, Volume = 5000, Duration = 45 }
);

// Bad - Vague message
logger.LogInformation("Workout done");

// Good - Errors with context
try
{
    await database.SaveAsync(workout);
}
catch (DbException ex)
{
    logger.LogError(
        ex,
        "Failed to save workout {WorkoutId}: {ErrorMessage}",
        workout.Id,
        ex.Message
    );
}

// Bad - Logging exceptions without context
catch (DbException ex)
{
    logger.LogError(ex.ToString());
}
```

---

## Metrics

### Purpose

Measure how much, how many, how long.

Metrics answer quantitative questions:
- How many requests per second?
- What's the average response time?
- How many errors occurred?
- How many workouts were logged?
- What's our database connection pool utilization?

### Metric Types

**Counter** — Only goes up
```
requests_total: 1000000
errors_total: 25
workouts_completed_total: 50000
```

**Gauge** — Can go up or down
```
active_users: 1250
request_queue_length: 45
memory_usage_bytes: 512000000
```

**Histogram** — Distribution of values
```
api_request_duration_ms: [0.5, 1.2, 3.5, 12.1]
```

**Summary** — Percentile tracking
```
api_request_duration (p50, p95, p99)
p50: 10ms
p95: 50ms
p99: 200ms
```

### System Metrics

Monitor infrastructure health:

```
CPU Usage
Memory Usage
Disk Space
Network I/O
Container/Pod Status
Process Count
```

### Application Metrics

Monitor application behavior:

```
Requests per second
Average response time
Error rate
Database connection pool (active, available)
Redis connection pool status
Cache hit ratio
Background job queue length
Background job duration
```

### Business Metrics

Monitor business health and success:

```
Daily active users
Workouts completed
Skills unlocked
New user registrations
User retention rate
Consistency streak continuation
Challenges completed
Feature adoption
Milestone achievement rate
```

### Metric Naming Convention

Use lowercase with underscores:

```
http_requests_total
http_request_duration_milliseconds
database_query_duration_milliseconds
cache_hits_total
cache_misses_total
active_user_sessions
workouts_completed_total
```

---

## Distributed Tracing

### Purpose

Follow a request across system boundaries.

Today: Single backend service
Future: Multiple services (AI, notifications, etc.)

### Trace ID

Every incoming request receives a trace ID:

```
trace-id: "550e8400-e29b-41d4-a716-446655440000"
```

This ID flows through:
- API gateway
- Backend service
- Database queries
- Cache operations
- Background jobs
- External API calls
- Log entries

### Span

A span represents a unit of work:

```
HTTP Request
├── Authenticate User (span)
├── Load Workout (span)
│   └── Database Query (child span)
├── Calculate Volume (span)
└── Save Workout (span)
    └── Database Query (child span)
```

### Benefits

- **End-to-end visibility** — See full request journey
- **Performance bottlenecks** — Find slow operations
- **Error diagnosis** — See exactly where failure occurred
- **Service dependencies** — Understand call chain

---

## Health Checks

### Endpoints

Expose standardized health endpoints:

```
GET /health          — Is the service alive?
GET /health/ready    — Is it ready for traffic?
GET /health/live     — Is it still running?
```

### Health Check Implementation

```csharp
public class HealthCheckController
{
    [HttpGet("health")]
    public async Task<IActionResult> Health()
    {
        var checks = new
        {
            status = "healthy",
            timestamp = DateTime.UtcNow,
            version = "1.0.0"
        };
        return Ok(checks);
    }
    
    [HttpGet("health/ready")]
    public async Task<IActionResult> Ready()
    {
        try
        {
            // Check database
            var dbOk = await database.IsHealthy();
            
            // Check cache
            var cacheOk = await cache.IsHealthy();
            
            if (!dbOk || !cacheOk)
                return StatusCode(503, "Not ready");
            
            return Ok("Ready");
        }
        catch
        {
            return StatusCode(503, "Not ready");
        }
    }
}
```

### What Health Checks Verify

- ✓ Database connectivity
- ✓ Redis/cache availability
- ✓ Disk space
- ✓ Memory usage
- ✓ Background workers running
- ✓ External dependency status

---

## Alerting

### Purpose

Notify engineers of critical issues requiring action.

### Alert Types

**Immediate (page oncall):**
- Database unavailable
- Error rate > 5%
- API response time > 5000ms
- Authentication service down
- Out of memory
- Disk full

**Urgent (notify team):**
- Error rate > 1%
- API response time > 1000ms
- Cache unavailable
- Background jobs failing

**Informational (log for review):**
- Error rate 0.5-1%
- Unusual traffic pattern
- Slow query detected

### Alert Example

```yaml
Alert: HighErrorRate
Condition: error_rate > 0.05 for 5 minutes
Severity: Critical
Action: Page oncall engineer
Message: "API error rate is 5% (normal: <0.1%)"
```

### Alert Fatigue

Avoid alert fatigue:
- ✓ Only alert on actionable issues
- ✓ Fine-tune thresholds based on real data
- ✓ Group related alerts
- ✓ Escalate intelligently
- ✗ Don't alert on non-critical items
- ✗ Don't use single-event triggers

---

## Dashboard Design

### Real-Time Dashboard

Shows current system state:

```
API Health          Errors (Last Hour)      User Activity
✓ 99.9% uptime      25 errors (0.001%)      1,245 active users
                    Top error: Timeout      1,852 workouts/hour

Database            Cache                   Background Jobs
Connections: 45/100 Hit ratio: 87%         Pending: 12
Query time: 15ms    Evictions: 2/min       Processing: 4
```

### Performance Dashboard

Shows trends:

```
Response Time (Last 24h)
[Graph showing p50, p95, p99]

Error Rate Trend
[Graph showing error rate over time]

User Registration
[Graph showing new registrations per day]
```

---

## Observability Checklist

Before going to production:

- ✓ All important business events are logged
- ✓ Error messages don't expose internals
- ✓ Secrets are never logged
- ✓ Response time is measured and visible
- ✓ Error rate is tracked
- ✓ Key business metrics are tracked
- ✓ Health check endpoints exist
- ✓ Alerts are configured for critical issues
- ✓ Logs are structured (JSON)
- ✓ Correlation IDs flow through system

---

## Tools & Services

### Logging

- **Serilog** (.NET logging library)
- **ELK Stack** or **Splunk** (log aggregation)
- **Datadog** or **New Relic** (managed logging)

### Metrics

- **Prometheus** (metrics collection)
- **Grafana** (visualization)
- **Datadog** or **New Relic** (managed metrics)

### Tracing

- **Jaeger** or **Zipkin** (distributed tracing)
- **Datadog** or **New Relic** (managed tracing)

### Alerting

- **PagerDuty** (incident management)
- **OpsGenie** (alerting)
- **Slack** (notifications)

---

## Observability Maturity

### Level 1: Basic
- Logs in files
- Manual error checking
- No metrics

### Level 2: Foundation
- Structured JSON logs
- Centralized log storage
- Basic metrics
- Health check endpoints

### Level 3: Comprehensive
- Distributed tracing
- Rich dashboards
- Automated alerts
- Business metrics
- Performance tracking

### Level 4: Advanced
- Predictive alerting
- Root cause analysis
- SLO tracking
- Cost optimization insights
- Anomaly detection

---

## Observability Best Practices

1. **Log intentionally** — Every log should serve a purpose
2. **Use correlation IDs** — Trace requests across boundaries
3. **Monitor business metrics** — Not just technical metrics
4. **Alert on outcomes** — Not on symptoms
5. **Design for debugging** — Make production debugging possible
6. **Observe in production** — Don't wait for failures
7. **Make it accessible** — Dashboards should be self-service
8. **Iterate on alerts** — Refine thresholds based on real data

Normal application events.

Examples:

- Workout completed
- User registered
- Routine created

---

## Warning

Unexpected situations that do not stop execution.

Examples:

- Retry succeeded
- Missing optional data
- Slow response

---

## Error

Recoverable failures.

Examples:

- Database timeout
- External API failure
- AI recommendation unavailable

---

## Critical

Application or infrastructure failure requiring immediate attention.

Examples:

- Database unavailable
- Authentication service failure
- Startup failure

---

# Logging Guidelines

Log:

✓ Important business events

✓ Errors

✓ Performance bottlenecks

✓ Integration failures

✓ Authentication events

Avoid logging:

✗ Passwords

✗ JWT tokens

✗ Refresh tokens

✗ Sensitive health data

✗ Large request payloads

---

# Correlation IDs

Every incoming request receives a Correlation ID.

The same Correlation ID must flow through:

- API
- Application
- Domain Events
- Background Jobs
- AI Services

This enables end-to-end tracing.

---

# Metrics

Metrics help answer:

"How is Atlas performing?"

Examples:

- API response time
- Active users
- Workout completion rate
- Error rate
- Database latency
- Queue length

Metrics should be lightweight and continuously collected.

---

# System Metrics

Monitor:

- CPU
- Memory
- Disk usage
- Network
- Container health

Infrastructure metrics provide early warning of capacity issues.

---

# Application Metrics

Examples:

- Requests per second
- Response time
- Error rate
- Authentication failures
- Background job duration
- Cache hit ratio

---

# Business Metrics

Atlas should also monitor business health.

Examples:

- Daily active users
- Workouts completed
- Skills unlocked
- New milestones earned
- Challenge participation
- User retention
- Streak continuation rate

Business metrics are as important as technical metrics.

---

# Distributed Tracing

Every request should be traceable across services.

Future architecture may include:

- Backend API
- AI Service
- Notification Service
- Community Service

Distributed tracing enables engineers to locate bottlenecks quickly.

---

# Health Checks

Expose health endpoints.

Examples:

/health

/ready

/live

Health checks verify:

- Database connectivity
- Cache availability
- External dependencies
- Background workers

---

# Alerting

Alerts should notify engineers of critical issues.

Examples:

- High error rate
- Increased latency
- Database unavailable
- Authentication failures
- Queue backlog

Avoid alert fatigue.

Only alert on actionable events.

---

# Dashboards

Dashboards should provide visibility into:

System Health

- CPU
- Memory
- Disk

Application

- Requests
- Errors
- Latency

Business

- DAU
- Workout activity
- Retention
- Community engagement

Dashboards should be understandable without reading logs.

---

# Performance Monitoring

Track:

- API latency
- Database query duration
- Cache performance
- Background job execution
- AI response time

Performance regressions should be visible.

---

# Exception Monitoring

Every unhandled exception should be captured automatically.

Include:

- Stack trace
- Correlation ID
- Request context
- Environment
- Application version

Never expose exception details to end users.

---

# Background Job Monitoring

Future background jobs include:

- Notifications
- AI recommendations
- Analytics
- Leaderboard updates

Monitor:

- Queue size
- Processing time
- Failure rate
- Retry count

---

# Database Observability

Track:

- Slow queries
- Deadlocks
- Connection pool usage
- Migration status
- Replication health (future)

---

# Cache Observability

Monitor:

- Hit ratio
- Miss ratio
- Memory usage
- Evictions
- Latency

---

# AI Observability (Future)

Monitor:

- Recommendation latency
- Prompt execution time
- Token usage
- Model failures
- Hallucination reports
- Recommendation acceptance rate

AI systems require observability beyond traditional APIs.

---

# User Experience Monitoring

Measure:

- App startup time
- Screen load time
- Crash rate
- Offline synchronization success
- Network failures

User experience metrics directly impact retention.

---

# Audit Events

Certain events should be permanently recorded.

Examples:

- Role changes
- Account deletion
- Password changes
- Security settings updates

Audit logs must be immutable.

---

# Tooling (Current Stack)

Recommended tools:

Logging:
- Serilog

Metrics:
- OpenTelemetry

Tracing:
- OpenTelemetry

Visualization:
- Grafana

Monitoring:
- Prometheus

Error Tracking:
- Sentry (or equivalent)

Cloud Monitoring:
- Azure Monitor

These choices may evolve over time.

---

# Continuous Improvement

Observability data should drive:

- Performance optimization
- Capacity planning
- Product improvements
- Reliability enhancements

Measure first.

Optimize second.

---

# Observability Checklist

Before releasing a feature:

✓ Logs added

✓ Metrics defined

✓ Health checks updated

✓ Alerts reviewed

✓ Dashboards updated

✓ Error handling verified

✓ Performance measured

---

# Guiding Principle

Every production issue should be answerable through logs, metrics, and traces.

Engineers should never need to guess what happened.


