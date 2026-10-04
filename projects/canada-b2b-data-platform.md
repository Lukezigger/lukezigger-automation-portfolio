# Canada B2B Data Automation Platform

## Scope

This case study documents a large-scale Canadian B2B data automation project. The public repository does not contain the raw dataset, private source configuration, credentials or proprietary entity-matching logic.

## Documented project checkpoint — 3 October 2026

| Metric | Recorded state |
|---|---:|
| Live establishments | 2,743,454 |
| Organizations | 815,427 |
| Geographic coverage | 10 provinces + 3 territories |
| Database | PostgreSQL 16 |
| Schema | 0005 |
| API | 0.2.0 |
| Tests | 435 collected / 423 passed / 0 failed / 12 skipped |

The project checkpoint also recorded a fresh-image migration from schema **0001 → 0005** in a disposable database.

**Evidence status:** these values come from the project release checkpoint. The public portfolio does not yet include the raw pytest output, count-query output or migration log, so this page does not claim that a visitor can independently verify the numbers from this repository alone.

## Pipeline

```text
Source inputs
    ↓
Ingestion
    ↓
Validation / normalization
    ↓
Deduplication / entity handling
    ↓
Provenance-aware storage
    ↓
PostgreSQL
    ↓
API + scheduled processing
    ↓
Health / release verification
```

A more detailed public diagram is in [architecture/canada-b2b-platform.md](../architecture/canada-b2b-platform.md).

## Engineering work represented

The project required database/schema management, repeatable migrations, API/database health checks, scheduled processing, regression testing and provenance-aware data handling at multi-million-record scale.

## Evidence still required for a stronger public claim

Before this portfolio calls the checkpoint independently verified, it should contain sanitized copies of:
- the corresponding pytest output and skip reasons;
- the fresh-database migration log;
- timestamped aggregate count-query output;
- a safe API specification or representative API evidence.

## Data and ownership boundary

The public portfolio intentionally does not state a source/licence category or ownership claim that has not yet been cleared for publication. Raw records, personal information, source endpoints and proprietary matching rules are not published.

Any future runnable public example should use synthetic data.
