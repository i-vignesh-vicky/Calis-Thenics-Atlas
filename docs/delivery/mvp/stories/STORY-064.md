# STORY-064 · Add Health Checks and Uptime Signals

Epic: [epic-13-release-and-launch](../epics/epic-13-release-and-launch.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Add health check endpoints so the deployment infrastructure can verify the app is running correctly.

## Implementation Steps

- [ ] Add a liveness endpoint that returns a simple 200 OK to confirm the process is running.
- [ ] Add a readiness endpoint that checks database connectivity and returns 503 if the app is not ready to serve requests.
- [ ] Connect the readiness check to the load balancer or reverse proxy configuration.

## Technical Notes

- Keep health checks fast; they run frequently and should not trigger expensive queries.
- The readiness check should cover the minimum dependencies required to serve a request.

## Tests

- [ ] Add tests for liveness and readiness endpoints under healthy and unhealthy conditions.

## Documentation

- [ ] Document the health check endpoints and how they are used in the deployment infrastructure.

## Acceptance Criteria

- [ ] The liveness endpoint returns 200 OK.
- [ ] The readiness endpoint returns 503 when the database is unavailable.
- [ ] Both endpoints are connected to the deployment infrastructure.

## Deliverables

- Liveness endpoint
- Readiness endpoint
- Infrastructure configuration
