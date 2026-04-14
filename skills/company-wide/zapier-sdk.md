# Zapier SDK Integration Skill

## What the Zapier SDK Is
The Zapier SDK is in open beta as of April 2026. It gives agents programmatic access to 9,000+ app integrations through a single authenticated interface. Zapier handles OAuth, token refresh, retries, and rate limits. Agents handle the logic. It is the tool to reach for when an integration is needed but no direct API exists or is practical.

## THE COST RULE — READ FIRST BEFORE EVERY USE
Every Zapier SDK action = 1 Zapier task.
Professional plan includes 750 tasks/month. Self-imposed budget cap: 500 tasks/month.
Overages charge at 1.25× base task rate. At 500 tasks/month the SDK is essentially free within plan.
At 2,000+ tasks/month it becomes a meaningful line item.

BEFORE using the Zapier SDK, always ask: Can this be done with a direct API call?
- GHL has a full API → use it directly
- Twilio has a full API → use it directly
- Firecrawl has a full API → use it directly
- n8n can handle most webhook/API workflows → use it directly

Use Zapier SDK ONLY when:
1. No direct API exists for the target app
2. The target app has an API but requires complex OAuth not worth building
3. A GHL sub-account needs to connect to an app that Zapier already has connected (saves OAuth setup)
4. The action is low-frequency enough that task cost is negligible

## Authentication
```javascript
import { createZapierSdk } from "@zapier/zapier-sdk";
const zapier = createZapierSdk();
// API key is loaded from ZAPIER_SDK_API_KEY environment variable
```

## Finding a Connection for a Specific App
```javascript
const { data: connection } = await zapier.findFirstConnection({
  appKey: "app-name-here",   // e.g. "google-sheets", "slack", "notion"
  owner: "me",
  isExpired: false,
});
// If no connection found, flag [BOARD_APPROVAL_REQUIRED] — Kenny must connect the app at zapier.com
```

## Executing a Pre-Built Action (Cheapest Path — 1 Task)
```javascript
const app = zapier.apps.slack({ connectionId: connection.id });
const result = await app.write.send_channel_message({
  inputs: { channel: "#general", text: "Your message here" }
});
```

## Raw API Call (When No Pre-Built Action Exists)
```javascript
const response = await zapier.apiCall({
  connectionId: connection.id,
  method: "POST",
  url: "https://api.someapp.com/endpoint",
  body: { key: "value" }
});
```

## Practical Use Cases in Agent Factory (Approved)
- Sending a Slack notification when no direct Slack API key is available in the sub-account
- Posting to a Google Sheet that a client uses for reporting (when GHL export isn't sufficient)
- Connecting to a client's existing Notion workspace for task handoffs
- Triggering a workflow in a platform that has no webhook support but is in Zapier's catalog

## Task Usage Logging (Required)
After every Zapier SDK call, log to /vision/zapier-usage.md:
- Date, agent name, action performed, app used, task count consumed
- Flag to CEO if cumulative monthly tasks exceed 400 (approaching self-imposed 500 cap)

## When to NOT Use (Always Prefer These Alternatives Instead)
| Situation | Use instead of Zapier SDK |
|-----------|--------------------------|
| Send SMS | Twilio direct API ($0 per call from existing account) |
| Create GHL contact | GHL API directly (0 task cost) |
| Send email via GHL | GHL API workflow trigger (0 task cost) |
| Scrape a website | Firecrawl API (counted against Firecrawl credits, not Zapier tasks) |
| HTTP webhook to n8n | n8n webhook URL directly (free) |
| Google Calendar check | Use GHL calendar API if client is on GHL |
