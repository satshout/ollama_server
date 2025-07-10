# This script is used to stop and down the Ollama WebUI using Docker Compose.
#!/bin/bash

cCloudflared="cloudflared" # container name for Cloudflare Tunnel

set -eux

# Podman compatibility
# alias docker=podman

echo "---"
echo "Stopping and tearing down Ollama WebUI services..."

# Stop ollama-webui
cd ./ollama_webui
docker compose down
echo "Ollama WebUI services have been stopped and removed."
cd ../

echo "---"
echo "Stopping and removing Cloudflare Tunnel container..."

# Stop Cloudflare Tunnel
# Use docker stop and docker rm for the standalone cloudflared container
docker stop "$cCloudflared" &> /dev/null || true # '|| true' prevents script from exiting if container doesn't exist
docker rm "$cCloudflared" &> /dev/null || true

echo "Cloudflare Tunnel container has been stopped and removed."

echo "---"
echo "All services have been stopped and removed."
