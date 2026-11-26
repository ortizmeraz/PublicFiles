as_root true

CONFS="$TARGET_HOME/DockerConfs"
COMPS="$TARGET_HOME/DockerComps"
BASE_URL='https://raw.githubusercontent.com/ortizmeraz/PublicFiles/refs/heads/main/Docker'

log "Creating directories for $TARGET_USER (if missing)"
as_user mkdir -p "$CONFS" "$COMPS"

if command -v docker >/dev/null 2>&1 || installed docker.io || installed docker-ce; then
    HAD_DOCKER=yes
else
    HAD_DOCKER=no
fi

log 'Refreshing APT package lists'
as_root apt-get update
if [ "$HAD_DOCKER" = yes ]; then
    log 'Docker already installed: upgrading installed APT packages'
    as_root apt-get upgrade -y
fi

log 'Ensuring wget and CA certificates are installed'
as_root apt-get install -y wget ca-certificates

# Download to a temporary file in the same directory. Preserve the existing
# Compose file if the download fails; back up an existing file if it changes.
log 'Downloading Compose files'
for filename in Services-compose.yml VPN_compose.yml portainer-compose.yml; do
    as_user sh -eu -c '
        url=$1; dest=$2
        tmp=$(mktemp "${dest}.download.XXXXXX")
        trap '\''rm -f -- "$tmp"'\'' EXIT
        trap '\''exit 1'\'' HUP INT TERM
        wget -nv -O "$tmp" "$url"
        [ -s "$tmp" ] || { echo "Empty download: $url" >&2; exit 1; }
        if [ -e "$dest" ]; then
            if cmp -s "$tmp" "$dest"; then
                printf "Unchanged: %s\n" "$dest"
                exit 0
            fi
            backup=$(mktemp "${dest}.bak.XXXXXX")
            cp -p -- "$dest" "$backup"
            printf "Backup: %s\n" "$backup"
        fi
        mv -f -- "$tmp" "$dest"
        printf "Saved: %s\n" "$dest"
    ' sh "$BASE_URL/$filename" "$COMPS/$filename"
done

if [ "$HAD_DOCKER" = no ]; then
    log 'Installing Docker Engine and Compose from Ubuntu APT repositories'
    as_root apt-get install -y docker.io docker-compose-v2
elif ! as_user docker compose version >/dev/null 2>&1; then
    log 'Installing the missing Docker Compose plugin'
    if installed docker-ce || installed docker-ce-cli; then
        as_root apt-get install -y docker-compose-plugin
    elif installed docker.io; then
        as_root apt-get install -y docker-compose-v2
    else
        fail 'Existing Docker installation is not a recognized APT package. Install its matching Compose plugin manually.'
    fi
fi

log 'Enabling and starting the Docker service (APT installations)'
if installed docker.io || installed docker-ce; then
    as_root systemctl enable --now docker.service
fi

log "Adding $TARGET_USER to the docker group"
if ! getent group docker >/dev/null; then
    as_root groupadd docker
fi
as_root usermod -aG docker "$TARGET_USER"

log 'Checking Docker and Compose versions'
as_user docker --version
as_user docker compose version

# A fresh process receives the updated supplementary group membership.
log 'Testing Docker access as the regular user with refreshed group membership'
if as_root runuser -u "$TARGET_USER" -- env HOME="$TARGET_HOME" docker ps; then
    printf '\nSetup completed successfully.\n'
else
    fail 'Docker access test failed. Check the Docker service and socket permissions.'
fi

printf '\nConfiguration directory: %s\nCompose directory:       %s\n' "$CONFS" "$COMPS"
printf '\nRun this in your current shell to activate the new group, or log out and back in:\n  newgrp docker\n'
printf '\nThen test: docker ps\nNo containers were deployed by this script.\n'