# This script is used to set up and run the Ollama WebUI using Docker Compose.
#!/bin/bash

cOllama="ollama"           # container name for Ollama
pOllama="11434"            # port for Ollama API
cOpenWebUI="open-webui"    # container name for Open WebUI
pOpenWebUI="8080"          # port for Open WebUI
pOpenWebUIHost="3000"      # port for Open WebUI exposed to the host
cCloudflared="cloudflared" # container name for Cloudflare Tunnel

set -eux

# Podman compatibility
# alias docker=podman

# Start ollama-webui ------------------------------------
docker compose pull
docker compose up -d

# Wait for the Ollama to start
echo "Waiting for Ollama to start..."
set +eux
while ! curl -s http://localhost:$pOllama/ > /dev/null; do
    sleep 1
done
set -eux
echo "Ollama is up and running at http://localhost:$pOllama"

# Wait for Open WebUI to start
echo "Waiting for Open WebUI to start..."
set +eux
while ! curl -s http://localhost:$pOpenWebUIHost/ > /dev/null; do
    sleep 1
done
set -eux
echo "Open WebUI is up and running at http://localhost:$pOpenWebUIHost"

# Start Cloudflare Tunnel ------------------------------------
docker pull docker.io/cloudflare/cloudflared:latest
docker run -d \
  --name $cCloudflared \
  --network ollama_server_my_ollama_network \
  --restart always \
  docker.io/cloudflare/cloudflared:latest \
  tunnel --no-autoupdate --url http://$cOpenWebUI:$pOpenWebUI # Binding Quick Tunnel to Open WebUI service in the same network
# tunnel --no-autoupdate run --url http://$cOpenWebUI:$pOpenWebUI --token xxxxx

# Wait for Cloudflare Tunnel to start and extract the URL
echo "---"
echo "Waiting for and retrieving the tunnel URL from the $cCloudflared container logs..."
echo "This might take a moment for the URL to appear..."

urls=()
set +eux
while [ ${#urls[@]} -eq 0 ]; do
    # Use 'docker logs' to get the logs from the specified container
    # Use grep with a regular expression to extract the URL, then sort for unique entries
    mapfile -t urls < <(docker logs "$cCloudflared" 2>&1 | grep -Eo 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' | sort -u)
    
    if [ ${#urls[@]} -eq 0 ]; then
        sleep 1
    fi
done
set -eux

echo "---"
echo "Retrieved Tunnel URL(s):"
for url in "${urls[@]}"; do
    echo "$url"
done
echo "---"

# Save the retrieved URL to a file
# This example saves only the first URL if multiple are found
# You can modify it to save all URLs (e.g., using '>>' for appending) if needed
echo "${urls[0]}" > ./urls.txt

echo "The URL has been saved to ./urls.txt."
echo "All services are up and running."
