#!/usr/bin/env bash
set -euo pipefail

# ensure we’re in ~/docker
cd "$(dirname "$0")"

# stop & remove all containers
/usr/bin/docker stop "$(/usr/bin/docker ps -aq)" || true
/usr/bin/docker rm   "$(/usr/bin/docker ps -aq)" || true

# bring up your stacks
/usr/local/bin/docker-compose -f ./docker/portainer-compose.yml up -d --remove-orphans
/usr/local/bin/docker-compose -f ./docker/VPN_compose.yml      up -d --remove-orphans
/usr/local/bin/docker-compose -f ./docker/Services-compose.yml up -d --remove-orphans