#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

if [[ $(docker run --network=traefik --rm curlimages/curl -L -s -o /dev/null -w "%{http_code}" http://wireguard:9091) != "200" ]]; then
    cd "$( dirname "${BASH_SOURCE[0]}" )"
    docker compose up -d --force-recreate
    docker run --network=traefik --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"
fi
