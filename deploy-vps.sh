#!/bin/bash
# HOTWORX Paperclip Shell Deployment Script
# Run this directly in the Hostinger VPS Console as root

echo "Starting HOTWORX Shell Deployment..."

# 1. Ensure Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    apt-get update && apt-get install -y docker.io docker-compose
fi

# 2. Clone or update the repository
if [ -d "/home/ubuntu/hwx-pc-shell" ]; then
    echo "Updating existing repository..."
    cd /home/ubuntu/hwx-pc-shell && git pull
else
    echo "Cloning repository..."
    git clone https://github.com/kensydco/hwx-pc-shell.git /home/ubuntu/hwx-pc-shell
    cd /home/ubuntu/hwx-pc-shell
fi

# 3. Create .env file for n8n and Paperclip
echo "Creating environment configuration..."
cat > /home/ubuntu/hwx-pc-shell/.env << 'EOF'
PAPERCLIP_NAMESPACE=HXPCL
N8N_PORT=5678
N8N_WEBHOOK_URL=https://n8n.yourdomain.com
GHL_API_KEY=pit-fc064f50-8ea5-4c97-abed-0c1f397f1e5b
GHL_LOCATION_ID=uQEYHZuzEijgAK9h0EzP
EOF

# 4. Start n8n container
echo "Starting n8n container..."
cd /home/ubuntu/hwx-pc-shell
# Assuming a docker-compose.yml exists or we run it directly
docker run -d --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n --env-file .env n8nio/n8n

# 5. Register Paperclip Agents
echo "Registering Paperclip agents..."
# Placeholder for actual Paperclip registration commands
# e.g., paperclip register ./agents/ceo/config.yaml

echo "Deployment complete! n8n is running on port 5678."
echo "Next steps: Access n8n at http://<VPS_IP>:5678 to import the workflow JSON files."
