# AI Consultation Engine

## Business problem

A backend needs structured AI analysis without storing the model API credential itself.

## Flow

```text
POST webhook
  → shared-secret check
      → authorized → Gemini request → extract response → return analysis
      → unauthorized → HTTP 401
```

## Engineering decisions

- A shared-secret gate rejects unauthorized webhook calls.
- The model credential belongs in n8n's credential store rather than in the workflow JSON.
- The model is asked for JSON output, while the consuming application should still validate the returned structure independently.
- The HTTP request has a bounded timeout.
- Unauthorized requests take a separate response path.

## Files

- [Sanitized workflow JSON](workflow.json)

## Security / publication notes

This is a sanitized portfolio copy derived from a real LukeZigger workflow. Production credential IDs, secrets, webhook identifiers and private configuration have been removed.

The public copy is **not claimed as import-tested** against a clean live n8n instance. Attach your own credential and validate it in your environment before use.

## What this demonstrates

Webhook integration · authorization gates · LLM API integration · structured responses · separation of credentials from application code · explicit failure path
