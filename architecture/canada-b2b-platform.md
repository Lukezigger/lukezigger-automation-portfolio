# Canada B2B Platform — Public Architecture

This diagram intentionally shows system boundaries and engineering controls without exposing source endpoints, raw records, credentials, or proprietary entity-matching logic.

```mermaid
flowchart LR
    A[Source Inputs] --> B[Ingestion Layer]
    B --> C[Validation & Normalization]
    C --> D[Deduplication / Entity Handling]
    D --> E[Provenance-Aware Storage]
    E --> F[(PostgreSQL 16)]
    F --> G[API Layer]
    F --> H[Scheduled Worker]
    G --> I[Dashboard / Consumers]
    H --> J[Health & Verification]
    G --> J
```

## Release controls

```mermaid
flowchart TD
    A[Source Change] --> B[Automated Tests]
    B --> C{Tests clean?}
    C -- No --> D[Fix / Re-test]
    D --> B
    C -- Yes --> E[Fresh-image migration test]
    E --> F[Database + API health checks]
    F --> G[Production verification]
```

### Verified checkpoint

At the documented 3 October 2026 checkpoint:

- 2,743,454 live establishments
- 815,427 organizations
- coverage across 10 provinces and 3 territories
- PostgreSQL 16
- schema 0005
- API 0.2.0
- 435 tests collected / 423 passed / 0 failed / 12 skipped
- fresh-image migration 0001 → 0005 verified in a disposable database

These are engineering-scale and verification metrics, not claims of customer revenue or business outcomes.
