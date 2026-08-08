# STORY-044 · Add Search Metadata and Query Service

Epic: [epic-10-search](../epics/epic-10-search.md)
Estimate: 3 hrs
Priority: High
Status: Todo

## Objective

Prepare the data model and query service for content search.

## Implementation Steps

- [ ] Add searchable fields for exercises and routines such as title, description, and tags.
- [ ] Create a simple query service that filters and ranks results based on the search term.
- [ ] Add a small metadata helper or index for search terms so the query layer can stay simple.

## Technical Notes

- The first search implementation should be local and deterministic rather than a full-text engine.
- Keep the ranking heuristic explicit so it is easy to adjust as the content grows.

## Tests

- [ ] Add tests for query service behavior against sample data.
- [ ] Verify ranking and empty results behave consistently.

## Documentation

- [ ] Document the search metadata contract and the basic ranking rules.

## Acceptance Criteria

- [ ] Searchable fields exist in the content models.
- [ ] The query service can return matching results.
- [ ] The ranking logic is deterministic for sample data.

## Deliverables

- Search metadata
- Query service
- Search ranking skeleton
