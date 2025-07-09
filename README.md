# ollama_server

ollama + webui + cloudflared

with 

- Dify: <https://github.com/langgenius/dify>

## When cloning this project,

after you've cloned the main repository, you'll need additional commands to get the contents of its submodules.

```bash
git clone -b with_dify https://github.com/satshout/ollama_server.git
cd ollama_server
git submodule update --init --recursive
cd dify/docker/
cp .env.example .env # Prepare environment file before first run
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

## How to update Dify

```bash
cd ./dify/docker

docker compose down

git reset --hard origin/main
git pull origin main

docker compose pull
cp .env.example .env
docker compose up -d
```

## How to remove and initiate the volumes of Dify

```bash
cd ./dify/docker
docker compose down -v # This will remove the named volumes
docker compose up -d
```

## How to compose down

```bash
sudo bash down.sh
```
