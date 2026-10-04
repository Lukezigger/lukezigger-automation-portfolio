# Canada B2B Data Automation Platform

## Problem

Build and validate a production-scale Canadian B2B data system capable of handling millions of establishment records while preserving data quality, provenance and operational reliability.

This public case study intentionally documents engineering outcomes rather than publishing the underlying dataset, private source details or proprietary matching logic.

## What was built

The system provides a structured data pipeline and API layer backed by PostgreSQL, with scheduled processing, validation and production health checks.

### Verified production checkpoint — 3 October 2026

| Metric | Verified state |
|---|---:|
| Live establishments | 2,743,454 |
| Organizations | 815,427 |
| Geographic coverage | 10 provinces + 3 territories |
| Database | PostgreSQL 16 |
| Schema | 0005 |
| API | 0.2.0 |
| Tests | 435 collected / 423 passed / 0 failed / 12 skipped |

A fresh-image migration from schema **0001 → 0005** was also verified in a disposable database.

## Architecture

```text
Source data
    ↓
Ingestion
    ↓
Validation / normalization
    ↓
Deduplication and entity handling
    ↓
Provenance-aware storage
    ↓
PostgreSQL
    ↓
API / scheduled processing
    ↓
Health checks and operational verification
```

## Engineering focus

The important part of this project was not simply collecting records. The production work required repeatable migrations, database/API health validation, regression testing, scheduled processing and provenance-aware data handling.

## Reliability evidence

The final development checkpoint reported **0 failed tests** across 435 collected tests, with 423 passing and 12 intentionally skipped. Production database and API health were verified at release time.

## Public-data boundary

This repository does **not** contain raw production records, credentials, private source configuration, personal information or proprietary matching rules. Any future runnable examples will use synthetic data.

## What this demonstrates

- production-scale data operations
- PostgreSQL and schema management
- API-backed systems
- testing and regression discipline
- scheduler/worker operations
- provenance and data-quality thinking
- ability to move from business requirement to production verification
