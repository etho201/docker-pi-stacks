#!/bin/bash

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $(docker run --network=backend --rm curlimages/curl -L -s -o /dev/null -w "%{http_code}" http://wireguard:9091) != "200" ]]
    then cd ${DIR} && docker-compose -f docker-compose.yml up -d && docker run --network=backend --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"
fi