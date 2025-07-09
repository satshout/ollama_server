# ollama_server

ollama + webui + cloudflared

## When cloning this project,

after you've cloned the main repository, you'll need additional commands to get the contents of its submodules.

```bash
git clone https://github.com/satshout/ollama_server.git
cd ollama_server
git submodule update --init --recursive
```

## How to compose up

```bash
cd ollama_server
sudo bash up.sh
```

## How to compose down

```bash
cd ollama_server
sudo bash down.sh
```