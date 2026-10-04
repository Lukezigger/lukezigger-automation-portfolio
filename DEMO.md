# Portfolio demo: recording script (about 3 minutes)

Record the screen with your voice. Show only what is in this repository and your own n8n instance. **Do not show the client project** (code, terminal, database or dashboard); it is confidential.

| Time | Screen | Say |
|---|---|---|
| 0:00–0:15 | This README | "I'm Syed. I build and test business-process automation in n8n and Python. Everything in this demo is in this repository." |
| 0:15–0:45 | `n8n-workflows/ai-consultation-engine/README.md`, the *What changed* table | "This is my original website workflow. Run on current n8n, it returned 500 on every request, and an empty model reply came back as a 200. Here is what I changed." |
| 0:45–1:30 | Your n8n with `workflow.json` imported (canvas) | Walk left to right: header auth → input validation → Gemini with 3 attempts → output validation → 200, 400 and 502 responses. |
| 1:30–2:10 | Terminal: `WEBHOOK_SECRET=… run_tests.sh` | Show 10/10 passing. Point at the upstream-500 case: three attempts, then a controlled 502. |
| 2:10–2:30 | n8n *Executions* tab, the 4-second upstream-failure run | "Every failure path ends in a response the caller can act on." |
| 2:30–2:50 | `calling-agent-crm-followup/README.md`, before/after table | "Same approach on a CRM workflow: the original sent invalid JSON when a summary had quotes. Now it is fixed and tested." |
| 2:50–3:00 | `projects/canada-b2b-data-platform.md` | "My largest project is confidential client work, so I describe it here without client data. Happy to walk through it in an interview." |

Before recording: use a throwaway webhook secret, close other tabs, hide bookmarks, and don't show any `.env` file or credential screen.
