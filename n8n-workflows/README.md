# n8n workflows

All three are LukeZigger workflows built by me. Their October 2026 versions were hardened and tested on a clean n8n 2.41.6 instance on 4 Oct 2026.

| Workflow | Integrations | Failure handling | Tests |
|---|---|---|---|
| [AI consultation endpoint](ai-consultation-engine/) | Webhook, Gemini REST API | Header auth, input validation, 3× retry, 502 on empty, blocked or invalid model output | 10/10 (mock model) |
| [WhatsApp lead qualification](whatsapp-lead-qualification/) | Webhook (demo: no external systems) | Header auth, required-field validation | 5/5 |
| [Call outcome → CRM → follow-up](calling-agent-crm-followup/) | Webhook, CRM REST API, notification API | Header auth, validation, 3× CRM retry, 502 when the CRM is down | 6/6 (mock CRM) |

Each folder has the workflow JSON, test evidence, screenshots and a table of what changed from my original export.

Before publishing, every export is checked with [`scan_exports.py`](scan_exports.py) for credential IDs, webhook IDs, URLs, emails, phone numbers and key-like strings. Result on 4 Oct 2026: clean. Credential references are placeholders (`REPLACE_WITH_YOUR_CREDENTIAL`); you attach your own after import.

Not published: other workflows I have built for clients. They contain client systems and data.
