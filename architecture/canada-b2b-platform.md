# Canadian B2B data platform — architecture (anonymized)

> Client project. This page shows the logical design only. It contains no client code, endpoints, credentials, source configuration, infrastructure details or data.

## Data flow and failure handling

```mermaid
flowchart TD
    S[Public-sector open-data sources] --> F[Polite HTTP client<br/>robots.txt · rate limit · retry/backoff]
    F -->|fetch fails| FX[run = failed<br/>processed records kept · error logged]
    F --> R[Raw records<br/>new payload = new version]
    R -->|bad record| BX[error_log · skip · run = partial]
    R --> O[Field observations<br/>source trust × confidence]
    O --> SEL[Value selection<br/>priority · recency · agreement]
    SEL --> ER[Entity resolution<br/>match candidates → merges]
    ER --> SC[Lead scoring]
    SC --> DNC[Do-Not-Call suppression<br/>E.164 · permanent entries]
    DNC --> OUT[API · dashboard · CSV export]
```

## Release gate

```mermaid
flowchart LR
    A[Change] --> B[pytest in test container]
    B -->|any failure| A
    B --> C[Fresh empty database:<br/>migrate 0001 → head]
    C --> D[API + DB health check<br/>schema revision and version]
    D --> E[Release notes + evidence folder]
```
