# Syed Mazhar Ul Islam — Automation & Integration Portfolio

I build and validate business-process automation, data pipelines and API integrations. **LukeZigger AI** is the independent automation practice through which I develop and deliver this work.

## Public proof available now

### Canada B2B data platform — engineering case study
A large-scale Canadian B2B data platform with PostgreSQL, an API layer, scheduled processing and release verification.

The documented 3 October 2026 checkpoint recorded:
- 2,743,454 live establishments
- 815,427 organizations
- coverage across all 10 provinces and 3 territories
- PostgreSQL 16 · schema 0005 · API 0.2.0
- 435 tests collected · 423 passed · 0 failed · 12 skipped
- fresh-image migration 0001 → 0005 checked in a disposable database

These figures are **documented project checkpoint values**. This public portfolio does not yet include the underlying test log, database query output or migration log, so I do not present the repository itself as independent verification of those figures.

[Case study](projects/canada-b2b-data-platform.md) · [Public architecture](architecture/canada-b2b-platform.md)

### n8n — authenticated Gemini endpoint
The repository contains one sanitized n8n workflow derived from a real LukeZigger implementation.

[Workflow notes](n8n-workflows/ai-consultation-engine/README.md) · [Sanitized JSON](n8n-workflows/ai-consultation-engine/workflow.json)

The public copy is for inspection and is **not yet claimed as clean-instance import-tested**. Additional workflows will be published only after the original exports can be sanitized and validated.

### Multi-agent automation
The current public material is a **design note**, not runtime proof of a deployed system.

[Control-plane design note](architecture/multi-agent-control-plane.md)

## My role and use of AI tools

I translate operational requirements into automation designs, integration flows, controls and verification steps. AI assistants are part of my implementation workflow for research, drafting, coding and review. I remain responsible for deciding what is implemented, checking outputs, testing changes and not presenting generated material as evidence that has not been verified.

My background includes business operations at Tata Consultancy Services and building automation systems through LukeZigger AI.

## Tools represented in my work

Python · JavaScript · PostgreSQL · REST APIs · n8n · Playwright · Docker · AI/LLM integrations · workflow automation · data operations

## Work with LukeZigger

Typical engagements start with the manual process and its failure points, then move through **scope → build → test → handover/operation**. I focus on workflow automation, integrations, business operations automation and data-processing systems.

Website: https://www.lukezigger.com/

## Evidence policy

This repository intentionally separates **documented project facts**, **publicly inspectable artifacts**, and **design notes**. Client data, credentials, private prompts, raw datasets and proprietary production logic are not published.

See [PROJECTS.md](PROJECTS.md) for the current evidence index.
