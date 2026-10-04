# Portfolio Index

## Flagship systems

| Project | Evidence available | Public boundary |
|---|---|---|
| [Canada B2B Data Automation Platform](projects/canada-b2b-data-platform.md) | Production-scale metrics, test checkpoint, migration verification, architecture | No raw data, private source configuration, credentials, or proprietary matching logic |
| [Multi-Agent Operations System](projects/multi-agent-ops-controls.md) | Control architecture and governance design | No production prompts, private databases, prospect/customer data, or credentials |
| [n8n Automation Library](n8n-workflows/README.md) | Sanitized workflow examples with documentation | No credential IDs, secrets, production webhook identifiers, or client data |

## Published n8n evidence

### [AI Consultation Engine](n8n-workflows/ai-consultation-engine/README.md)

A sanitized workflow derived from a real LukeZigger implementation:

```text
Webhook → Shared-secret gate → Gemini → Response extraction → Webhook response
                   ↘ unauthorized → HTTP 401
```

The public JSON is provided for technical inspection. It is deliberately labelled as not yet import-tested against a clean live n8n instance.

## Evidence policy

This portfolio follows a simple rule: **show what can be supported**.

A project is not presented as production-proven merely because a diagram or prototype exists. Likewise, client outcomes, revenue, performance gains, certifications, and workflow validation are not claimed unless evidence exists for them.
