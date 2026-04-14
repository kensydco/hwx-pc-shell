# HOTWORX Agent Factory — Shell Deployment Checklist

This checklist defines the exact steps required to deploy the `hwx-pc-shell` repository into the live Hostinger environment and validate its operation.

## Phase 1: Environment Preparation (Kenny / Admin)
- [ ] SSH into Hostinger VPS
- [ ] Verify Docker is running (`docker ps`)
- [ ] Verify Traefik routing is active
- [ ] Verify Paperclip and OpenClaw containers are healthy
- [ ] Pull latest `hwx-pc-shell` repository to the VPS

## Phase 2: GHL Shell Setup (Manus via Browser/API)
- [ ] **Requires:** GHL Agency API Key or Sub-Account Admin Access
- [ ] Create sub-account `hotworx-[city-slug]`
- [ ] Build pipelines and stages per `HX-SHELL-GHL-Build-Package.md`
- [ ] Create custom fields
- [ ] Create tags
- [ ] Build shell forms
- [ ] Build shell calendars
- [ ] Build funnel/page shells
- [ ] Configure GHL native shell workflows

## Phase 3: n8n Workflow Import (Manus via Browser/API)
- [ ] **Requires:** n8n Admin Credentials
- [ ] Create new project/folder in n8n for `hotworx-[city-slug]`
- [ ] Import all 8 JSON workflow files from `n8n-workflows/` directory
- [ ] Update webhook URLs in GHL to point to the new n8n webhook triggers
- [ ] Update `{{placeholders}}` in n8n HTTP Request nodes with live API keys
- [ ] Activate all 8 workflows

## Phase 4: Paperclip Registration (Manus via CLI/API)
- [ ] **Requires:** Paperclip API Key
- [ ] Sync the `hwx-pc-shell/paperclip-import/.paperclip.yaml` to the live Paperclip instance
- [ ] Register all 10 agents via Paperclip API
- [ ] Verify agent skills are accessible in the Paperclip environment

## Phase 5: Acceptance Testing
- [ ] Submit test lead via GHL shell form
- [ ] Verify GHL `HX-SHELL-Lead-Ack` workflow fires
- [ ] Verify n8n `HXN8N-01` workflow catches webhook and transports to Paperclip
- [ ] Verify Paperclip creates a task and assigns it correctly without n8n forcing the assignment
- [ ] Verify OpenClaw model routing matches `gpt-4o-mini` for execution and `claude-sonnet-4-6` for reasoning
- [ ] **CRITICAL:** Force a stale session in Paperclip and verify the auto-recovery rule successfully clears the session and restarts fresh

---

# Pre-Launch Data Collection Checklist (Client Onboarding)

Before this shell can be converted into a live production system for a specific HOTWORX location, the following data must be collected during the client onboarding session:

## Location Details
- [ ] Official Location Name
- [ ] City Slug (for URL routing)
- [ ] Physical Address
- [ ] Business Phone Number
- [ ] Business Email Address
- [ ] General Manager Name
- [ ] General Manager Email
- [ ] General Manager Phone
- [ ] Franchise Owner Name
- [ ] Franchise Owner Email
- [ ] Franchise Owner Phone

## System Credentials & Integrations
- [ ] GHL Sub-Account ID
- [ ] GHL API Key
- [ ] Twilio Account SID (if using custom SMS)
- [ ] Twilio Phone Number
- [ ] Preferred EOD Cutoff Time (e.g., 8:00 PM CST)
- [ ] Preferred Owner Briefing Time (e.g., 7:00 AM CST)
- [ ] Target New Leads per Week
- [ ] Target At-Risk Member Threshold

## Business Logic
- [ ] Current Trial Offer Details
- [ ] Brand Voice Guidelines
- [ ] After-Hours Contact Rules
- [ ] Custom Escalation Triggers (if any)
