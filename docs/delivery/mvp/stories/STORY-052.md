# STORY-052 · Add Centralized Error Handling

Epic: [epic-12-quality](../epics/epic-12-quality.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Introduce consistent error handling across the API and UI layers.

## Implementation Steps

- [ ] Add a centralized API error handler that formats all error responses with a consistent shape.
- [ ] Add a global error boundary or error handler in the UI that catches unhandled exceptions.
- [ ] Normalize error codes and messages so the frontend can display consistent feedback for known errors.

## Technical Notes

- Keep the error shape simple: status, code, message, and optional details.
- Avoid exposing stack traces or internal implementation details in API error responses.

## Tests

- [ ] Add tests that verify the API error shape for known error types.
- [ ] Verify the UI error boundary catches and renders an error state.

## Documentation

- [ ] Document the error response shape and the known error codes.

## Acceptance Criteria

- [ ] All API errors follow a consistent response shape.
- [ ] Unhandled UI exceptions are caught and displayed gracefully.
- [ ] Error codes are predictable and documentable.

## Deliverables

- Centralized API error handler
- UI error boundary
- Error response shape spec
