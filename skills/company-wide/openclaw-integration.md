# OpenClaw Integration Skill

## What OpenClaw Does
OpenClaw is the computer-use layer. Use it when a task requires clicking through a screen,
filling a form, navigating a portal, or interacting with any system that has no usable API.
It connects to Paperclip via heartbeat and receives tasks like any other agent.

## When to Invoke OpenClaw (vs Direct API)
Use OpenClaw for:
- Web portals with no API (contractor licensing databases, permit systems, insurance portals)
- Legacy admin interfaces (outdated CRM dashboards, older GHL subaccount UIs)
- Browser-based verification tasks (checking that a deployed page looks correct)
- Repetitive multi-click workflows where a human currently clicks through screens

Do NOT use OpenClaw for:
- Any task solvable with a direct API call (GHL, Firecrawl, Twilio all have APIs — use them)
- Simple data lookups or web searches
- Any task where the standard agent stack already works

## Model Routing Inside OpenClaw
OpenClaw's default model is GPT-4o mini. This handles 90% of execution tasks.
For sessions requiring complex judgment (e.g., navigating an unfamiliar portal with many decision points),
include this tag in the task description: [USE_CLAUDE_SONNET]
OpenClaw will escalate to claude-sonnet-4-6 for that session only.

## Creating an OpenClaw Task from Paperclip
Tag the task: openclaw-execution
Include in the task description:
- Target URL or system name
- Specific goal (what success looks like)
- Steps if known (otherwise OpenClaw reasons its own path)
- [USE_CLAUDE_SONNET] tag if reasoning escalation is needed

## Budget Awareness
OpenClaw has a $60/month hard budget cap. The n8n budget alert workflow monitors at 80% ($48).
GPT-4o mini: ~$0.15–$0.60 per typical browser session
Claude Sonnet escalation: ~$1–$3 per reasoning-heavy session
Use sparingly — OpenClaw is for edge cases the API layer cannot handle.
