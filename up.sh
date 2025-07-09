# This script is used to set up and run the Ollama WebUI using Docker Compose.
#!/bin/bash

pOllama="11434"
pOpenWebUI="7860"
pDify="80"

set -eux

# Podman compatibility
# alias docker=podman

# Start ollama-webui ------------------------------------
cd ./ollama_webui

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
while ! curl -s http://localhost:$pOpenWebUI/ > /dev/null; do
    sleep 1
done
set -eux
echo "Open WebUI is up and running at http://localhost:$pOpenWebUI"

cd ../

# Start Dify ------------------------------------
cd ./dify/docker

git reset --hard origin/main
git pull origin main

docker compose pull
cp .env.example .env
docker compose up -d

# Wait for Dify to start
echo "Waiting for Dify to start..."
set +eux
while ! curl -s http://localhost:$pDify/ > /dev/null; do
    sleep 1
done
set -eux
echo "Dify is up and running at http://localhost:$pDify"

cd ../../

# Start Cloudflare Tunnel ------------------------------------
cd ./cloudflare-tunnel

docker compose pull
docker compose up -d

# Display the URLs for the services
echo "The following URLs are available:"

# Wait for Cloudflare Tunnel to start
set +eux
urls=()
while [ ${#urls[@]} -eq 0 ]; do
    mapfile -t urls < <(docker compose logs | grep -Eo 'https://[a-zA-Z0-9.-]+\.trycloudflared\.com' | sort -u)
    sleep 5
done
set -eux

for url in "${urls[@]}"; do
    echo "$url"
done

cd ../

echo "$urls" > ./urls.txt

echo "All services are up and running."
