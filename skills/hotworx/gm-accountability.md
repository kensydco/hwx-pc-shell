# HOTWORX GM Accountability Skill

## Purpose
This skill defines how the HOTWORX Portfolio CEO agent manages general manager accountability across all 4 locations. GMs are human employees. Agents support and report — they do not replace GM judgment, but they monitor performance, surface issues early, and provide structured support when GMs are struggling.

## The Board Member → Portfolio CEO → GM Relationship
Kenny B (Board) → Portfolio CEO Agent (orchestrator) → GMs at each location (human employees)
The Portfolio CEO agent acts as Kenny's eyes and ears across locations. It surfaces what GMs need, flags when expectations are not being met, and creates structured support before problems become crises.

## Weekly GM Accountability Cycle (Every Monday Morning)

### Step 1 — Pull Location KPIs from GHL (Every Monday 7:00 AM CST)
For each of the 4 locations, query GHL API for the prior week:
```
GET /contacts?pipeline=[location-pipeline-id]&updatedAt[gte]=[last-monday]
```
Extract for each location:
- New trial signups (target: varies by location, defined in /vision/hotworx-targets.md)
- Trial-to-member conversions (target: 60% or above)
- Active member count vs. prior week (growing, flat, or declining?)
- Members at-risk (visited <2x in last 14 days) — count
- No-shows last week — count
- Google review requests sent vs. reviews received
- Missed calls (Voice AI call log from GHL)

### Step 2 — Score Each Location (Green / Yellow / Red)
Green: All KPIs at or above target. No action needed from CEO agent.
Yellow: 1–2 KPIs below target. GM gets a support check-in (see Step 4).
Red: 3+ KPIs below target, OR active member decline 2 weeks in a row. Escalate to Kenny immediately [BOARD_APPROVAL_REQUIRED].

### Step 3 — Generate Weekly Summary Report
Create /tasks/hotworx-weekly-[date]/summary.md:
| Location | Trials | Conversions | Active Members | At-Risk | Status |
|----------|--------|-------------|----------------|---------|--------|
| Collierville | X | X% | X | X | 🟢/🟡/🔴 |
| Ithaca | X | X% | X | X | 🟢/🟡/🔴 |
| Lake Charles | X | X% | X | X | 🟢/🟡/🔴 |
| Houston | X | X% | X | X | 🟢/🟡/🔴 |

Flag to Kenny with full report every Monday by 8:00 AM CST.
Kenny sees the whole picture before the week begins. No surprises.

### Step 4 — GM Support Check-In (Yellow/Red Locations Only)
For Yellow locations: draft a GM support message (to be reviewed by Kenny before sending):
Template:
"Hi [GM Name], quick check-in on last week. I noticed [specific metric] came in at [value] vs. our [target] target. Wanted to flag it early — what's your read on what's driving that? Is there anything you need from the team or resources to hit target this week? [Kenny/Agent Factory] is here if you need support."

This is not a reprimand. It is early-stage coaching. Tone is supportive.
For Red locations: create [BOARD_APPROVAL_REQUIRED] immediately — Kenny handles directly.

### Step 5 — GM Task Verification
Each GM has a recurring task list in GHL. Verify weekly:
- Is the GM completing their scheduled tasks in GHL? (Check task completion rate)
- Are member at-risk follow-ups being executed? (Check GHL conversation log)
- Are new trial members receiving their onboarding sequence? (Check workflow execution logs)

If task completion rate falls below 70% two weeks in a row: flag [BOARD_APPROVAL_REQUIRED].

## GM Support Library (When a GM Is Struggling)
The Portfolio CEO agent can assign support resources to struggling GMs. Log what was shared.

### If conversion rate is low:
- Create a task: "Draft GM training guide: How to convert HOTWORX trials to members — conversation scripts and follow-up sequence"
- Assign to Content Strategist
- Deliver to Kenny for review before sending to GM

### If member retention is declining:
- Verify the "at-risk member" workflow in GHL is firing correctly
- Check if GMs are manually overriding automated sequences
- Draft a retention coaching brief for Kenny to review

### If review count is low:
- Verify the "Review Request Sequence" workflow is active in GHL
- Check if the Voice AI post-session CTA is working
- Suggest GM manual outreach to top members for first-person reviews

### If a GM is unresponsive:
After 2 missed check-ins: [BOARD_APPROVAL_REQUIRED] immediately.
Do not attempt further automated outreach. This requires Kenny's direct involvement.

## GM Task Templates in GHL (These Should Already Exist in the Snapshot)
The HOTWORX-Location-v1 snapshot includes recurring GM task workflows:
- Weekly: Review at-risk member list and reach out to top 5 personally
- Weekly: Review and respond to all Google/Yelp reviews
- Monthly: Update GHL pipeline with accurate member count
- Monthly: Submit location performance summary to Kenny

If a GM is not completing these: the accountability workflow above catches it.

## Escalation Thresholds (Clear Red Lines)
These trigger immediate [BOARD_APPROVAL_REQUIRED]:
- Active member count down >5% in any single week
- Trial conversion rate below 40% for 2 consecutive weeks
- GM has not logged into GHL in 5+ business days
- 3 or more 1-star reviews in a single week at any location
- Any customer complaint escalation that reaches the Customer Success Agent

## Privacy Note
GMs are employees. Monitoring is legitimate operational oversight, not surveillance.
All GM performance data stays within the hotworx-portfolio Paperclip company.
It is never shared with other company namespaces or with external parties.
