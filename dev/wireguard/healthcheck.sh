#!/bin/bash

while getopts t: flag
do
    case "${flag}" in
        t) GOTIFY_TOKEN=${OPTARG};;
    esac
done

if [[ $(docker run --network=backend --rm curlimages/curl -L -s -o /dev/null -w "%{http_code}" http://wireguard:9091) != "200" ]]
    then docker restart wireguard transmission qbittorrent && docker run --network=backend --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"
fi