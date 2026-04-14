# HOTWORX Shell Deployment: CLI Prompt Guide

This guide contains the exact, copy-paste commands and prompts required to complete the three outstanding deployment tasks. These are designed to be executed directly by the owner.

## Task 1: VPS Container Deployment

This script pulls the shell code from GitHub, sets up the environment variables, and starts the n8n orchestration container. It must be run directly in the Hostinger hPanel console to bypass SSH firewall restrictions.

**Where to run this:**
1. Log into `hpanel.hostinger.com`
2. Navigate to **VPS** → select your server → **Console**
3. Paste the following command exactly as written and press Enter:

```bash
curl -s https://raw.githubusercontent.com/kensydco/hwx-pc-shell/main/deploy-vps.sh | bash
```

**Expected outcome:** The console will output "Deployment complete! n8n is running on port 5678." You can then access n8n at `http://<YOUR_VPS_IP>:5678`.

---

## Task 2: n8n Webhook Configuration

After importing the 8 workflow JSON files into n8n, you must update the webhook URLs in GoHighLevel to point to your live VPS.

**Where to run this:**
In your GoHighLevel sub-account, go to **Automation → Workflows**.

**The mapping:**
Replace `<YOUR_VPS_IP>` with your actual server IP address (e.g., `185.69.5.184`).

| GHL Workflow Trigger | Webhook Action URL to Paste in GHL |
|---|---|
| Form Submitted (New Lead) | `http://<YOUR_VPS_IP>:5678/webhook/hotworx/new-lead` |
| Approval Request (Paperclip) | `http://<YOUR_VPS_IP>:5678/webhook/hotworx/approval-request` |
| System Failure Alert | `http://<YOUR_VPS_IP>:5678/webhook/hxn8n-failure-alert` |

*Note: The other 5 workflows are triggered by cron schedules and do not require external webhook URLs.*

---

## Task 3: GHL Manual Build Prompts

Because the GHL Starter plan restricts API write access, you must build the pipelines and custom fields manually. You can use these exact prompts in ChatGPT or Claude to guide you through the manual UI build.

**Where to run this:**
Paste these directly into ChatGPT or Claude.

### Prompt A: Pipeline Builder
> "I need to manually build a GoHighLevel pipeline for a HOTWORX studio. The pipeline name is 'HOTWORX Lead Flow'. Please give me the exact step-by-step UI clicks to create this pipeline with the following stages in order: 1. New Lead, 2. Attempted Contact, 3. Trial Booked, 4. Trial Completed, 5. Membership Sold, 6. Lost/Archived. Keep the instructions strictly focused on the GHL user interface."

### Prompt B: Custom Fields Builder
> "I need to manually create four custom fields in GoHighLevel for a HOTWORX studio. Please give me the exact UI steps to create:
> 1. 'HX_Preferred_Workout' (Dropdown type, options: Iso, Yoga, Cycle, Row, Blast, Core, Bands, Buns)
> 2. 'HX_Membership_Goal' (Text type)
> 3. 'HX_Last_Visit_Date' (Date type)
> 4. 'HX_Paperclip_Status' (Text type)
> Keep the instructions brief and focused on the Settings > Custom Fields menu."

### Prompt C: Form Builder
> "I need to build the 'HOTWORX Initial Intake' form in GoHighLevel. It needs to include First Name, Last Name, Phone, Email, and the two custom fields HX_Preferred_Workout and HX_Membership_Goal. Please provide the step-by-step UI instructions to build this form and configure the submit button."
