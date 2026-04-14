#!/bin/bash
# HOTWORX Paperclip Shell Deployment Script
# Run this directly in the Hostinger VPS Console as root
# Safe to re-run — handles existing containers gracefully

set -e
echo "=== Starting HOTWORX Shell Deployment ==="

# 1. Ensure Docker is installed
if ! command -v docker &> /dev/null; then
    echo "[1/5] Installing Docker..."
    apt-get update -qq && apt-get install -y docker.io docker-compose
else
    echo "[1/5] Docker already installed — skipping."
fi

# 2. Clone or update the repository
if [ -d "/root/hwx-pc-shell/.git" ]; then
    echo "[2/5] Updating existing repository..."
    cd /root/hwx-pc-shell && git pull
else
    echo "[2/5] Cloning repository..."
    git clone https://github.com/kensydco/hwx-pc-shell.git /root/hwx-pc-shell
    cd /root/hwx-pc-shell
fi

# 3. Create .env file
echo "[3/5] Writing environment configuration..."
cat > /root/hwx-pc-shell/.env << 'EOF'
PAPERCLIP_NAMESPACE=HXPCL
N8N_PORT=5678
N8N_WEBHOOK_URL=http://187.124.219.148:5678
GHL_API_KEY=pit-fc064f50-8ea5-4c97-abed-0c1f397f1e5b
GHL_LOCATION_ID=uQEYHZuzEijgAK9h0EzP
EOF

# 4. Handle n8n container — stop and remove if already exists, then start fresh
echo "[4/5] Starting n8n container..."
if docker ps -a --format '{{.Names}}' | grep -q "^n8n$"; then
    echo "  → Existing n8n container found. Stopping and removing..."
    docker stop n8n 2>/dev/null || true
    docker rm n8n 2>/dev/null || true
fi

docker run -d \
  --name n8n \
  --restart unless-stopped \
  -p 5678:5678 \
  -v /root/.n8n:/home/node/.n8n \
  --env-file /root/hwx-pc-shell/.env \
  n8nio/n8n

# 5. Verify n8n is running
echo "[5/5] Verifying n8n is running..."
sleep 5
if docker ps --format '{{.Names}}' | grep -q "^n8n$"; then
    echo ""
    echo "=== Deployment Complete ==="
    echo "n8n is running at: http://187.124.219.148:5678"
    echo ""
    echo "Next steps:"
    echo "  1. Open http://187.124.219.148:5678 in your browser to access n8n"
    echo "  2. Import the 8 workflow JSON files from /root/hwx-pc-shell/n8n-workflows/"
    echo "  3. Activate each workflow after importing"
else
    echo "ERROR: n8n container failed to start. Check logs with: docker logs n8n"
    exit 1
fi
