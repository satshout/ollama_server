# This script is used to stop and down the Ollama WebUI using Docker Compose.
#!/bin/bash

set -eux

# Podman compatibility
# alias docker=podman

# Stop ollama-webui
cd ./ollama_webui
docker compose down
# Wait for the Ollama to stop
echo "Ollama WebUI has been stopped."

# Stop Cloudflare Tunnel
cd ./cloudflare-tunnel
docker compose down
# Wait for Cloudflare Tunnel to stop
echo "Cloudflare Tunnel has been stopped."
cd ../

# Display the URLs for the services
echo "All services have been stopped and removed."
