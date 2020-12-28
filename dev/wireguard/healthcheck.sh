#!/bin/bash

while getopts d:g: flag
do
    case "${flag}" in
        d) FQDN=${OPTARG};;
        g) GOTIFY_TOKEN=${OPTARG};;
    esac
done

if [[ $(curl -L -s -o /dev/null -w "%{http_code}" transmission.${FQDN}) == "404" ]]
    then docker restart wireguard transmission qbittorrent && curl "https://gotify.${FQDN}/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"
fi