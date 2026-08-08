# STORY-045 · Add Search API Endpoint

Epic: [epic-10-search](../epics/epic-10-search.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Expose a search endpoint that accepts a query and returns matching exercises and routines.

## Implementation Steps

- [ ] Add a search route that accepts a query string parameter.
- [ ] Wire the route to the query service and return a structured results list.
- [ ] Add pagination or a top-N cap so the endpoint does not return unbounded results.

## Technical Notes

- The endpoint should return results in a uniform shape regardless of content type so the UI can render them generically.
- Keep authentication required so only logged-in users can search.

## Tests

- [ ] Add API tests for the search endpoint with valid and empty queries.
- [ ] Verify the response shape is consistent across result types.

## Documentation

- [ ] Document the search endpoint path, parameters, and response contract.

## Acceptance Criteria

- [ ] The endpoint returns results for a matching query.
- [ ] Empty queries return an empty results list.
- [ ] The response shape is stable.

## Deliverables

- Search API endpoint
- Query routing
- Results response model
