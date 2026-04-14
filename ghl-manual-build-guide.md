# HOTWORX GHL Shell: Manual Build Guide

This guide contains the exact steps and copy-paste AI prompts to build the GoHighLevel (GHL) shell for the HOTWORX Paperclip integration.

Because the GHL Starter plan ($97/mo) restricts API access to read-only for most configuration objects, these items must be built manually in the GHL UI or by using an AI assistant (like ChatGPT or Claude) with the provided prompts.

## 1. Tags

Create these tags in **Settings → Tags**:

*   `HX-Lead-New`
*   `HX-Lead-Contacted`
*   `HX-Member-Active`
*   `HX-Member-Churned`
*   `HX-Requires-Attention`

## 2. Custom Fields

Create these custom fields in **Settings → Custom Fields** (all as Text fields unless noted):

*   `HX_Preferred_Workout` (Dropdown: Iso, Yoga, Cycle, Row, Blast, Core, Bands, Buns)
*   `HX_Membership_Goal` (Text)
*   `HX_Last_Visit_Date` (Date)
*   `HX_Paperclip_Status` (Text)

## 3. Pipelines

Create this pipeline in **Opportunities → Pipelines**:

**Pipeline Name:** `HOTWORX Lead Flow`
**Stages:**
1.  New Lead
2.  Attempted Contact
3.  Trial Booked
4.  Trial Completed
5.  Membership Sold
6.  Lost/Archived

## 4. Calendars

Create this calendar in **Calendars → Calendar Settings**:

**Calendar Name:** `HOTWORX Trial Booking`
**Settings:**
*   Duration: 30 mins
*   Buffer: 15 mins
*   Sync with Google/Outlook calendar if applicable.

## 5. Forms

Create this form in **Sites → Forms → Builder**:

**Form Name:** `HOTWORX Initial Intake`
**Fields:**
*   First Name
*   Last Name
*   Phone
*   Email
*   Custom Field: `HX_Preferred_Workout`
*   Custom Field: `HX_Membership_Goal`

## 6. Workflows (Automations)

Create these workflows in **Automation → Workflows**:

### Workflow 1: New Lead to n8n Webhook

**Trigger:** Form Submitted (`HOTWORX Initial Intake`)
**Action 1:** Add Tag `HX-Lead-New`
**Action 2:** Create Opportunity in `HOTWORX Lead Flow` (Stage: New Lead)
**Action 3:** Webhook (POST to your n8n URL: `https://<YOUR_N8N_DOMAIN>/webhook/ghl-new-lead`)

---

## AI Prompts for Faster Building

If you are using an AI assistant to help you build or verify these settings, you can copy and paste the following prompts:

**Prompt 1: Pipeline Strategy**
> "I am setting up a GoHighLevel pipeline for a HOTWORX fitness studio. The stages are: New Lead, Attempted Contact, Trial Booked, Trial Completed, Membership Sold, Lost/Archived. Can you suggest any automated follow-up emails or SMS messages I should attach to each stage transition?"

**Prompt 2: Form Optimization**
> "I have a GHL form for HOTWORX with Name, Phone, Email, Preferred Workout, and Membership Goal. How can I optimize this form for better conversion rates on a mobile landing page?"

**Prompt 3: Webhook Troubleshooting**
> "I am sending a webhook from GoHighLevel to n8n when a new lead submits a form. What payload structure should I expect from GHL, and how can I map the custom fields (like HX_Preferred_Workout) in n8n?"
