# This script is used to stop and down the Ollama WebUI using Docker Compose.
#!/bin/bash

cCloudflared="cloudflared" # container name for Cloudflare Tunnel

set -eux

# Podman compatibility
# alias docker=podman

# Stop ollama-webui
echo "---"
echo "Stopping and tearing down Ollama WebUI services..."

docker compose down
echo "Ollama WebUI services have been stopped and removed."

# Stop Cloudflare Tunnel
echo "---"
echo "Stopping and removing Cloudflare Tunnel container..."

# Use docker stop and docker rm for the standalone cloudflared container
docker stop "$cCloudflared" &> /dev/null || true # '|| true' prevents script from exiting if container doesn't exist
docker rm "$cCloudflared" &> /dev/null || true

echo "Cloudflare Tunnel container has been stopped and removed."

echo "---"
echo "All services have been stopped and removed."
