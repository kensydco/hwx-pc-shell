# HOTWORX Shell Deployment: CLI Prompt Guide

This guide contains the exact, copy-paste commands and prompts required to complete the outstanding deployment tasks. These are designed to be executed directly by the owner.

## Task 1: VPS Container Deployment

This script pulls the shell code from GitHub, sets up the environment variables, and starts the n8n orchestration container. It must be run directly in the Hostinger hPanel console to bypass SSH firewall restrictions.

**Where to run this:**
1. Log into `hpanel.hostinger.com`
2. Navigate to **VPS** → select your server → **Console**
3. Paste the following command exactly as written and press Enter:

```bash
curl -s -H "Authorization: token <YOUR_GITHUB_PAT>" https://raw.githubusercontent.com/kensydco/hwx-pc-shell/main/deploy-vps.sh | bash
```

**Expected outcome:** The console will output "Deployment complete! n8n is running on port 5678." You can then access n8n at `http://<YOUR_VPS_IP>:5678`.

---

## Task 2: n8n Workflow Import

After the VPS is deployed, you must import the 8 pre-built workflow shells into n8n.

**Where to run this:**
In your browser, go to `http://<YOUR_VPS_IP>:5678` (replace with your actual VPS IP).

**How to import:**
1. In n8n, click **Workflows** in the left menu, then click **Add Workflow**.
2. Click the **Options** menu (three dots in top right) and select **Import from File**.
3. You will need the JSON files from the `n8n-workflows/` directory in the `hwx-pc-shell` GitHub repository.
4. Import each of the 8 `HXN8N-*.json` files one by one.
5. Make sure to toggle each workflow to **Active** (top right corner of the canvas) after importing.

---

## Task 3: n8n Webhook Configuration in GHL

Once n8n is running and workflows are active, you must map the GHL triggers to the n8n webhook URLs.

**Where to run this:**
In your GoHighLevel sub-account, go to **Automation → Workflows**.

**The mapping:**
Replace `<YOUR_VPS_IP>` with your actual server IP address (e.g., `185.69.5.184`).

| GHL Workflow Trigger | Webhook Action URL to Paste in GHL |
|---|---|
| Form Submitted (New Lead) | `http://<YOUR_VPS_IP>:5678/webhook/hotworx/new-lead` |
| Approval Request (Paperclip) | `http://<YOUR_VPS_IP>:5678/webhook/hotworx/approval-request` |
| System Failure Alert | `http://<YOUR_VPS_IP>:5678/webhook/hxn8n-failure-alert` |

*Note: The other 5 n8n workflows are triggered by cron schedules and do not require external webhook URLs.*

---

## Task 4: GHL Manual Build Prompts

Because the GHL Starter plan restricts API write access, you must build the pipelines, custom fields, and workflows manually. You can use these exact prompts in ChatGPT or Claude to guide you through the manual UI build.

**Where to run this:**
Paste these directly into ChatGPT or Claude.

### Prompt A: Pipeline Builder
> "I need to manually build a GoHighLevel pipeline for a HOTWORX studio. The pipeline name is 'HX-SHELL-New-Lead-Pipeline'. Please give me the exact step-by-step UI clicks to create this pipeline with the following stages in order: 1. New Lead, 2. Contact Attempted, 3. Responded, 4. Trial Requested, 5. Trial Booked, 6. Trial Confirmed, 7. Trial No-Show, 8. Trial Rescheduled, 9. Trial Attended, 10. Converted, 11. Closed Lost. Keep the instructions strictly focused on the GHL user interface."

### Prompt B: Custom Fields Builder
> "I need to manually create four custom fields in GoHighLevel for a HOTWORX studio. Please give me the exact UI steps to create:
> 1. 'Location Name' (Text type)
> 2. 'Preferred Contact Method' (Dropdown type)
> 3. 'Current Fitness Goal' (Text type)
> 4. 'Last Visit Date' (Date type)
> Keep the instructions brief and focused on the Settings > Custom Fields menu."

### Prompt C: Form Builder
> "I need to build the 'HX-SHELL-Lead-Capture-Form' in GoHighLevel. It needs to include First Name, Last Name, Mobile Phone, Email, Preferred Contact Method (Custom Field), Location Name (Custom Field), and Trial Interest Type (Custom Field). Please provide the step-by-step UI instructions to build this form and configure the submit button."

### Prompt D: Workflow Builder
> "I need to build a native automation workflow in GoHighLevel called 'HX-SHELL-Lead-Ack'. 
> The Trigger is: Form Submitted (HX-SHELL-Lead-Capture-Form).
> The Actions are:
> 1. Send SMS: 'Thanks for reaching out to {{location_name}}. We’ll be in touch shortly.'
> 2. Add Tag: 'HX-SHELL-New-Lead'
> 3. Create/Update Opportunity in 'HX-SHELL-New-Lead-Pipeline' (Stage: New Lead)
> Please give me the exact, step-by-step UI clicks to build this workflow, add these three specific actions, publish it, and save it."
