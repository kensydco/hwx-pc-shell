# Firecrawl Integration Skill

## Base URL
https://api.firecrawl.dev/v1

## Authentication
Authorization: Bearer [FIRECRAWL_API_KEY from environment]

## Scrape a Single URL
POST /scrape
Body: { "url": "[target URL]", "formats": ["markdown", "extract"], "extract": { "schema": { "business_name": "string", "phone": "string", "email": "string", "address": "string", "services": "array" } } }

## Crawl a Website
POST /crawl
Body: { "url": "[root URL]", "limit": 50, "scrapeOptions": { "formats": ["markdown", "extract"] } }

## Batch Scrape Multiple URLs
POST /batch/scrape
Body: { "urls": ["url1", "url2", "url3"], "formats": ["extract"] }

## Lead Scraping Workflow
1. Identify target vertical and geography from task brief
2. Use Google search via web_search to find directories and review sites (Yelp, Angi, HomeAdvisor, Google Maps embeds)
3. Extract business URLs from search results
4. Batch scrape URLs using Firecrawl to extract: business name, phone, email, address, service categories, review count, rating
5. Score leads based on: low review count (<20 = high-opportunity), no visible chat widget, slow response indicators
6. Format output as CSV: Name, Phone, Email, Address, Services, Review Count, Rating, Opportunity Score
7. Save to /tasks/[task-id]/leads_output.csv
8. Report count and quality summary to CEO

## Credit Management
Standard plan: 100,000 credits/month
1 page scrape = 1 credit
1 batch scrape = 1 credit per URL
Monitor usage: GET /usage — flag to CEO if monthly usage exceeds 80,000 credits
