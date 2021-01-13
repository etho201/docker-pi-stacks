#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $(docker run --network=backend --rm curlimages/curl -L -s -o /dev/null -w "%{http_code}" http://wireguard:9091) != "200" ]]; then
    docker-compose -f ${DIR}/docker-compose.yml up -d --force-recreate
    docker run --network=backend --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"
fi