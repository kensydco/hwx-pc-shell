# GoHighLevel Integration Skill

## Base URL
https://services.leadconnectorhq.com

## Authentication
All GHL API calls use:
Authorization: Bearer [GHL_API_KEY from environment]
Version: 2021-07-28

## Common Operations

### Create Contact
POST /contacts/
Body: { "firstName": "", "lastName": "", "email": "", "phone": "", "tags": [], "source": "Agent Factory" }

### Add to Pipeline
POST /opportunities/
Body: { "pipelineId": "", "stageId": "", "contactId": "", "name": "", "status": "open" }

### Send SMS
POST /conversations/messages
Body: { "type": "SMS", "contactId": "", "message": "" }

### Create Task
POST /contacts/{contactId}/tasks
Body: { "title": "", "dueDate": "", "assignedTo": "" }

## Pipeline Stage IDs (populate after GHL setup)
- New Lead: [REQUIRES_INPUT after GHL config]
- Qualified: [REQUIRES_INPUT after GHL config]
- Proposal Sent: [REQUIRES_INPUT after GHL config]
- Contract Signed: [REQUIRES_INPUT after GHL config]
- Onboarding: [REQUIRES_INPUT after GHL config]
- Active Client: [REQUIRES_INPUT after GHL config]

## Tags Used
- source:organic, source:referral, source:linkedin, source:youtube
- vertical:home-services, vertical:dental, vertical:real-estate, vertical:legal
- service:staffing, service:lead-gen, service:research, service:workforce-build
- status:hot-lead, status:nurture, status:not-qualified
