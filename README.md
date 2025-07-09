# ollama_server

ollama + webui + cloudflared

## When cloning this project,

```bash
git clone https://github.com/satshout/ollama_server.git
cd ollama_server
```

## How to compose up

```bash
sudo bash up.sh
```

## How to update Open WebUI and Ollama

```bash
cd ./ollama_webui
sudo docker compose down
sudo docker compose pull
sudo docker compose up -d
```

## How to remove and initiate the volumes of Open WebUI and Ollama

```bash
cd ./ollama_webui
sudo docker compose down -v # This will remove the named volumes
sudo docker compose up -d
```

## How to compose down

```bash
sudo bash down.sh
```
