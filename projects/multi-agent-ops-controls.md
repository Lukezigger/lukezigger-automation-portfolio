# Multi-Agent Operations — Design Note

> **Evidence status:** concept/design documentation. This file is not presented as public proof of a deployed multi-agent system.

## Design goal

Define a controlled pattern for delegating operational work across specialized agents while retaining permission boundaries, explicit human decisions for consequential actions, observable state and a termination path.

See the corrected [control-plane diagram](../architecture/multi-agent-control-plane.md).

## Intended controls

- specialized responsibilities rather than unrestricted agents;
- least-authority permission boundaries;
- explicit approve **and reject** paths for consequential actions;
- state and event history outside conversational memory;
- stop/recover/escalate handling for unhealthy execution;
- completion or operational/budget termination conditions.

## What is intentionally not claimed

This public repository currently does not provide sanitized runtime logs, test evidence or runnable multi-agent source code. Until that evidence can be safely published, this remains a design note.

Production prompts, credentials, prospect/customer information, private databases and proprietary operating rules are excluded.
