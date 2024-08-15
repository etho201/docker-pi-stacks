#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

if [[ $(docker inspect wireguard -f '{{.State.Running}}' 2>/dev/null) == "false" || $(docker inspect wireguard -f '{{.State.Health.Status}}') == "unhealthy" ]]; then
    docker compose up -d --force-recreate wireguard transmission sabnzbd qbittorrent soulseek
    docker run --network=traefik --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Wireguard" -F "message=Wireguard container found to be unhealthy. Successfully restarted the container!" -F "priority=5"
fi
