# HOTWORX Agent Factory — GHL Shell Build Package

This document serves as the exact implementation guide for the GoHighLevel (GHL) shell snapshot. It is designed to be executed by a human operator or a deployment agent during Phase 3 of the shell build.

**CRITICAL RULE:** Do not invent fields, tags, stages, workflows, pages, or logic beyond what is listed here. Preserve all `{{placeholders}}`. Keep workflows lightweight and native to GHL.

## 1. Sub-Account Configuration

The sub-account name must follow the shell naming convention: `hotworx-{{city_slug}}`.

The following custom values must be initialized but left as placeholders for later customization:
- `{{location_name}}`
- `{{city_slug}}`
- `{{gm_name}}`
- `{{owner_name}}`
- `{{business_phone}}`
- `{{business_email}}`
- `{{location_address}}`
- `{{booking_url}}`
- `{{trial_offer}}`
- `{{brand_voice}}`
- `{{after_hours_rule}}`

## 2. Pipelines & Stages

The following pipelines and exact stages must be created to manage the lead and member lifecycle.

| Pipeline Name | Stages |
|---|---|
| `HX-SHELL-New-Lead-Pipeline` | 1. New Lead<br>2. Contact Attempted<br>3. Responded<br>4. Trial Requested<br>5. Trial Booked<br>6. Trial Confirmed<br>7. Trial No-Show<br>8. Trial Rescheduled<br>9. Trial Attended<br>10. Converted<br>11. Closed Lost |
| `HX-SHELL-At-Risk-Member-Pipeline` | 1. At Risk Identified<br>2. Outreach Started<br>3. Contacted<br>4. Save Conversation<br>5. Offer Presented<br>6. Retained<br>7. Lost Member<br>8. Win-Back Future |
| `HX-SHELL-WinBack-Pipeline` | 1. Win-Back Target<br>2. Outreach Started<br>3. Responded<br>4. Re-Booked<br>5. Re-Activated<br>6. Not Interested<br>7. Unreachable |
| `HX-SHELL-Partnership-Pipeline` | 1. Prospect Identified<br>2. Initial Outreach<br>3. Contacted<br>4. Interest Shown<br>5. Meeting Booked<br>6. Proposal Sent<br>7. Partnership Won<br>8. Partnership Lost |

## 3. Custom Fields

The following contact-level custom fields must be created. Use the specified field types to ensure data consistency.

| Field Name | Field Type |
|---|---|
| Location Name | Text |
| Assigned GM | Text |
| Lead Source | Dropdown |
| Preferred Contact Method | Dropdown |
| Trial Interest Type | Dropdown |
| Membership Interest | Dropdown |
| Current Fitness Goal | Text |
| Corporate Partner | Yes/No |
| Risk Status | Dropdown |
| Last Visit Date | Date |
| Last Contact Attempt Date | Date |
| Escalation Needed | Yes/No |
| Escalation Reason | Text |
| Partner Type | Dropdown |
| Source Campaign | Text |
| Referral Source | Text |
| Current Member Status | Dropdown |

## 4. Tags

The following tags must be created exactly as written to categorize contacts and trigger workflows.

| Tag Category | Tags |
|---|---|
| Lifecycle Tags | `HX-SHELL-New-Lead`, `HX-SHELL-Trial-Requested`, `HX-SHELL-Trial-Booked`, `HX-SHELL-Trial-NoShow`, `HX-SHELL-Trial-Attended`, `HX-SHELL-Converted`, `HX-SHELL-At-Risk`, `HX-SHELL-WinBack`, `HX-SHELL-Partner-Lead` |
| Channel / Source Tags | `HX-SHELL-Source-Meta`, `HX-SHELL-Source-Google`, `HX-SHELL-Source-Referral`, `HX-SHELL-Source-Organic`, `HX-SHELL-Source-Local-Event`, `HX-SHELL-Source-Partnership` |
| Internal Tags | `HX-SHELL-Escalation-Needed`, `HX-SHELL-Manual-Review`, `HX-SHELL-AI-Handled`, `HX-SHELL-Needs-GM-Followup` |

## 5. Forms

The following forms must be created to capture lead and inquiry data.

| Form Name | Required Fields |
|---|---|
| `HX-SHELL-Lead-Capture-Form` | First Name, Last Name, Mobile Phone, Email, Preferred Contact Method (Custom Field), Location Name (Custom Field), Trial Interest Type (Custom Field), Notes (Standard additional info field) |
| `HX-SHELL-Trial-Request-Form` | First Name, Last Name, Mobile Phone, Email, Location Name (Custom Field), Current Fitness Goal (Custom Field), Consent Checkbox |
| `HX-SHELL-Contact-Us-Form` | Full Name, Phone, Email, Location Name (Custom Field), Message |
| `HX-SHELL-Partnership-Inquiry-Form` | Full Name, Organization (Company Name), Title, Phone, Email, Partner Type (Custom Field), Notes |

## 6. Calendars

The following shell calendars must be created. Use placeholder hours (e.g., 9 AM - 5 PM) and generic settings.

- `HX-SHELL-Trial-Booking-Calendar`
- `HX-SHELL-Callback-Calendar`
- `HX-SHELL-Partnership-Call-Calendar`

## 7. Funnel and Page Shells

The following page shells must be created. Do not finalize copy; use placeholder blocks to outline the page structure.

| Page Name | Required Elements |
|---|---|
| `HX-SHELL-Lead-Capture-Page` | Headline, Subheadline, Form Embed, Trust Badges |
| `HX-SHELL-Trial-Booking-Page` | Headline, Calendar Embed |
| `HX-SHELL-Contact-Page` | Form Embed, Location Info |
| `HX-SHELL-Partnership-Page` | Form Embed, Value Prop block |
| `HX-SHELL-Thank-You-Page` | Confirmation Message, Next Steps |

## 8. Shell Workflows

The following native GHL workflows must be created. Keep them strictly contained within GHL, with no external webhooks except where explicitly noted for n8n logging.

| Workflow Name | Trigger | Actions |
|---|---|---|
| `HX-SHELL-Lead-Ack` | Form Submitted (`HX-SHELL-Lead-Capture-Form`) | 1. Send SMS: "Thanks for reaching out to {{location_name}}. We’ll be in touch shortly."<br>2. Add Tag: `HX-SHELL-New-Lead`<br>3. Create/Update Opportunity in `HX-SHELL-New-Lead-Pipeline` (Stage: New Lead) |
| `HX-SHELL-Missed-Call-TextBack` | Call Status = Missed | 1. Send SMS: "We noticed we missed your call. Reply here and our team will follow up."<br>2. Add Tag: `HX-SHELL-Needs-GM-Followup` |
| `HX-SHELL-Trial-Booking-Confirmation` | Appointment Booked (`HX-SHELL-Trial-Booking-Calendar`) | 1. Send SMS/Email: "Your trial request at {{location_name}} has been received."<br>2. Add Tag: `HX-SHELL-Trial-Booked`<br>3. Update Opportunity Stage: Trial Booked |
| `HX-SHELL-Trial-Reminder` | Appointment Status = Confirmed (Wait 24h before) | 1. Send SMS: "Reminder: Your session at {{location_name}} is tomorrow." |
| `HX-SHELL-Trial-NoShow-Followup` | Appointment Status = No Show | 1. Send SMS: "We missed you at {{location_name}} today. Let's reschedule."<br>2. Update Opportunity Stage: Trial No-Show<br>3. Add Tag: `HX-SHELL-Trial-NoShow` |
| `HX-SHELL-Post-Trial-Followup` | Appointment Status = Showed | 1. Send SMS: "Great job today! How was your session?"<br>2. Update Opportunity Stage: Trial Attended<br>3. Add Tag: `HX-SHELL-Trial-Attended` |
| `HX-SHELL-AtRisk-Reactivation` | Tag Added (`HX-SHELL-At-Risk`) | 1. Send SMS: "We haven't seen you in a while! Reply to this message to book your next session."<br>2. Create/Update Opportunity in `HX-SHELL-At-Risk-Member-Pipeline` (Stage: At Risk Identified) |
| `HX-SHELL-Internal-Notification` | Custom Field `Escalation Needed` = Yes | 1. Send Internal Email to `{{gm_email}}`: "Escalation needed for contact. Reason: {{contact.custom_fields.escalation_reason}}"<br>2. Add Tag: `HX-SHELL-Escalation-Needed` |
