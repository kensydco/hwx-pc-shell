# Token Optimization — Agent Behavior Rules

## Why This Matters
Every token is a cost. Poorly written prompts, bloated context, and unnecessary reasoning loops are the most common causes of runaway API bills. These rules apply to ALL agents regardless of model.

## Rule 1 — Read Before You Reason
Before reasoning about a task, read the task brief completely. Do not start generating output until you have read:
- The task title and description
- The relevant skill file for this task type
- Any referenced files (mission.md, team_roster.md, etc.)
Reading is cheap (input tokens). Generating wrong output and then correcting it is expensive (multiple output token cycles).

## Rule 2 — Write Short, Structured Outputs
Prefer structured markdown over flowing prose in agent outputs:
- Use bullet points and tables instead of paragraphs in internal task files
- Internal notes: 200 words maximum unless the task explicitly requires more
- Status updates to CEO: 3 bullet points maximum (what I did, what I found, what I need)
- Proposals and client content are the ONLY exception — they should be full prose

## Rule 3 — Prune Before You Continue
At each heartbeat, the CEO agent prunes its heartbeat file if it exceeds 50 lines.
All agents should delete task files for completed tasks after archiving the key outputs.
Old completed task files accumulate as context weight and increase token cost on every subsequent call.

## Rule 4 — Don't Re-Read What You Already Have
If a document was read in the current session, do not re-read it unless the task explicitly requires a fresh read.
Reference it by name in your reasoning: "Per the brand voice skill I read at session start..."

## Rule 5 — Model Selection Is Token Optimization
Using Opus 4.6 for a task that GPT-4o mini can handle is not just expensive — it is wasteful.
Before executing any task, confirm: am I using the cheapest model that produces acceptable quality for this job?
The routing hierarchy:
- Simple classification, CRM entry, template execution → GPT-4o mini
- Bulk document processing, data extraction → Gemini Flash-Lite (batch mode when possible)
- Brand voice, reasoning, client content, judgment calls → Claude (Haiku for simple, Sonnet for complex, Opus for CEO only)

## Rule 6 — Batch When Possible
If you have 5+ similar tasks to execute (e.g., score 50 leads, summarize 10 research documents):
- Group them into a single Gemini batch API call
- Do not process them one-by-one with individual API calls
- One batch call = fraction of the cost of N individual calls

## Rule 7 — Use Caching for Repeated Context
System prompts, mission.md, brand voice guidelines, and GHL integration specs are read on almost every call.
These are ideal for prompt caching (90% cost reduction on repeat reads).
When calling Anthropic API directly, include cache_control: {"type": "ephemeral"} on static context blocks.

## Rule 8 — Stop and Flag Rather Than Guess
If a task is ambiguous and you're not sure of the right output, stop and create a [BOARD_APPROVAL_REQUIRED] issue.
Generating 500 tokens of wrong output and then correcting it costs more than asking a 50-token clarifying question.
Uncertainty is cheaper than confident errors.

## Rule 9 — Context Window Hygiene
Keep task files under 2,000 words. If a task requires more context than that, split it into subtasks.
Never include raw HTML or raw API responses in task context — always extract and summarize the relevant data only.
Raw API responses can be 50–200K tokens. A 200-word summary of the same data costs 0.1% as much.

## Rule 10 — Log and Flag Token Anomalies
If any single agent session consumes more than $5 in tokens: stop, log the anomaly, and flag to CEO.
This pattern almost always indicates a reasoning loop, context accumulation error, or incorrect model routing.
