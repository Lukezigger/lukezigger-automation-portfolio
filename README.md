# Syed Mazhar Ul Islam — Workflow & Business Process Automation

I design, build and test business-process automation: n8n workflows, API integrations, and Python/PostgreSQL data pipelines. Before automation I worked in business operations at Tata Consultancy Services, so I start from the process and its failure points, not the tool. **LukeZigger AI** is my automation practice.

**Jobs / recruiters:** syed.mazhar1432.sm@gmail.com · [LinkedIn](https://www.linkedin.com/in/syed-mazhar-ul-islam-4321931b7/)
**Client projects:** [lukezigger.com](https://www.lukezigger.com)

## Proof you can check in this repository

| Work | What you can inspect | Evidence status |
|---|---|---|
| [AI consultation endpoint (n8n + Gemini)](n8n-workflows/ai-consultation-engine/) | Workflow JSON, test script, test-double source, 10-case test log, screenshots of executions, before/after comparison | **Tested** on a clean n8n 2.41.6 instance: 10/10 cases pass (auth, input validation, retries, upstream failure, empty/invalid model output). Model calls went to a local test double, not live Gemini |
| [WhatsApp lead qualification & routing (n8n)](n8n-workflows/whatsapp-lead-qualification/) | Workflow JSON, test log, screenshots, the original version's defects | **Tested**, 5 cases. Demo workflow: no real WhatsApp, calendar or CRM connected |
| [AI call outcome → CRM → follow-up (n8n)](n8n-workflows/calling-agent-crm-followup/) | Workflow JSON, test script, mock CRM, test log, screenshots, the original version's defects | **Tested**, 6 cases, against a mock CRM. Demo workflow |
| [Canadian B2B data platform (client project)](projects/canada-b2b-data-platform.md) | Anonymized engineering case study and architecture | **Privately verified project checkpoint**: the client's code, data and logs are confidential and not published |
| [Multi-agent control plane](architecture/multi-agent-control-plane.md) | Design note | Design only, no runtime claim |

## What I build

- **Workflow automation:** lead intake, qualification and routing; CRM updates; follow-up and alerting (n8n, webhooks, REST APIs)
- **AI inside workflows:** LLM calls with input validation, structured-output checks, retries and controlled failure responses
- **Data pipelines:** ingestion, normalization, deduplication, provenance tracking, PostgreSQL schema migrations, scheduled jobs
- **Operational controls:** authentication on entry points, error paths, run logs, test cases written before handover

Tools I have used in the work above: n8n, Python, FastAPI, PostgreSQL, Alembic, Docker Compose, JavaScript/Node.js, REST/webhook APIs, Gemini API, pytest.

## How I use AI tools

I use AI assistants for drafting, coding, review and testing, and I decide what is built and published. To be specific about this repository:

- The three n8n workflows started as my own exports (July and September 2026). An AI assistant (Claude) made the October 2026 hardening changes and wrote the test harness and these documents, working under my direction. Each workflow folder lists exactly what changed from the original.
- The test runs in this repository were executed on 4 October 2026 during that session. The scripts are included, so anyone can rerun them.
- Nothing is described as tested unless its output is in this repository or, for client work, in the client's private project records.

## Working with LukeZigger AI

Engagements usually run: map the current process → agree what success and failure look like → build → test the failure paths → hand over with a runbook. Enquiries: [lukezigger.com](https://www.lukezigger.com).
