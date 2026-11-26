#!/bin/sh
set -e

mkdir -p "$HOME/DockerConfs" "$HOME/DockerComps"

sudo apt update
if command -v docker >/dev/null 2>&1; then
    sudo apt upgrade -y
else
    sudo apt install -y docker.io docker-compose-v2
fi

if ! docker compose version >/dev/null 2>&1; then
    sudo apt install -y docker-compose-v2
fi

sudo apt install -y wget
cd "$HOME/DockerComps"
BASE=https://raw.githubusercontent.com/ortizmeraz/PublicFiles/refs/heads/main/Docker
wget -O Services-compose.yml "$BASE/Services-compose.yml"
wget -O VPN_compose.yml "$BASE/VPN_compose.yml"
wget -O portainer-compose.yml "$BASE/portainer-compose.yml"

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
echo 'Done. Run newgrp docker or log out and back in.'