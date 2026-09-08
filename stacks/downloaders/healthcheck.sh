#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Directory containing this script (and the downloaders compose.yaml + .env).
COMPOSE_DIR="$(dirname "$0")"

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

if [[ $(docker inspect wireguard -f '{{.State.Running}}' 2>/dev/null) == "false" || $(docker inspect wireguard -f '{{.State.Health.Status}}') == "unhealthy" ]]; then
    # Recreate from the service's own compose file + env so custom settings
    # (volumes, network_mode, labels, PUID/CONFIG_DIR/EXTHDD_DIR, ...) are honored.
    docker compose -f "$COMPOSE_DIR/compose.yaml" --env-file "$COMPOSE_DIR/.env" \
        up -d --force-recreate wireguard transmission sabnzbd qbittorrent soulseek nzbget
    docker run --network=traefik --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Wireguard" -F "message=Wireguard container found to be unhealthy. Successfully restarted the container!" -F "priority=5"
fi
