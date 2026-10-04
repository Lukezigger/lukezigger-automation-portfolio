# Canadian B2B data platform — anonymized case study

> **Client project.** Published as an anonymized engineering case study. Client-owned source code, data, logs and infrastructure are not included.

## Problem

A B2B sales client needed a refreshable database of Canadian businesses: collected from public-sector open data, de-duplicated across sources, with a record of where every value came from, and exported as scored, callable leads with an internal Do-Not-Call list.

## My role

I built the system end to end: the schema and migrations, source collectors, ingestion and provenance logic, entity resolution, scoring, the API and dashboard, the scheduler, the tests, and the operational runbooks. AI coding assistants were used throughout. I directed the work, ran the system and checked the results.

## Architecture

Python · FastAPI · PostgreSQL 16 · Alembic · Docker Compose. [Diagram](../architecture/canada-b2b-platform.md)

```text
collectors (polite HTTP client: robots.txt, rate limit, retry/backoff)
  → raw records, versioned (payload changes keep history)
  → normalization → field-level observations with source trust and confidence
  → value selection (priority / recency / agreement) → entity resolution (match candidates → merges)
  → lead scoring → Do-Not-Call suppression → API, dashboard, CSV export
scheduler: per-source cron in the worker; n8n optional, never required
```

## Technical decisions

- **Field-level provenance.** Every observed value is stored with its source, trust rank and confidence, and the selected value is recomputed by one SQL rule. Conflicting sources are resolved by a stated rule, not by whichever source loaded last.
- **Safe ingestion.** One advisory lock per source; bad records are logged and skipped (the run is marked `partial`); a failed fetch keeps what was already processed; a run is never left in the `running` state.
- **Do-Not-Call is permanent.** Phone numbers are normalized to E.164; a suppression at organization level covers all of that organization's locations; entries cannot be edited or deleted.
- **Least exposure.** The database is never exposed outside the service network, the orchestration layer can reach only the API, and each service receives only its own secrets.
- **Standalone first.** n8n workflows are optional. The Python worker owns every schedule, so the system runs without n8n.

## Failure handling

Scheduled jobs record success or failure in a job-run table, and errors go to an error log. Ingestion runs end as `succeeded`, `partial` or `failed`, never stuck. Release checks: the full test suite, a fresh-database migration of every schema version, and an API/database health check.

## Evidence

**Privately verified project checkpoint; the underlying client evidence is confidential and not publicly reproduced.** You cannot verify these figures from this repository. They are copied from the project's own release records, and were checked against those records on 4 Oct 2026:

| Item | Recorded value (2–3 Oct 2026) |
|---|---|
| Test suite (release run, Docker test container) | 423 passed, 12 skipped, 0 failed (435 collected) |
| Skipped tests | All 12 are Docker Compose / n8n-file checks that cannot run inside the application image |
| Fresh-database migration | Schema 0001 → 0005 applied in order on an empty database |
| API health after migration | HTTP 200; database ok; schema 0005; API version 0.2.0 |
| Scale | About 2.74 million live establishment records; more than 815,000 organization records |
| Coverage | Records in all 10 provinces and 3 territories |
| First fully automatic daily cycle | 26 Sep 2026: 7 of 7 scheduled jobs ran on time and succeeded, with no manual step |

What evidence exists privately: the pytest output, the migration log, the health-check output, table-count snapshots, the scheduled-run audit and the release notes. These can be shown in an interview on screen if the client agrees. They will not be published here.

## Result

A working, tested system that refreshes on its own schedule, delivered to the client with deployment and demo documentation.

## Limitations (stated honestly)

- **It ran on a single developer machine under Docker, not on a production server.** A server deployment procedure was written but not executed.
- Callable leads came mainly from municipal licence data in a few cities. Coverage of website, email, employee size and decision-maker details was limited.
- It was not connected to a CRM or dialer. National Do-Not-Call list scrubbing and other telemarketing and consent obligations stayed with the client.
