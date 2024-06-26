#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Parse Command Line Arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -gt*|--gotify-token*)
            if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
            GOTIFY_TOKEN="${1#*=}"
            ;;
        -in*|--invoiceninja-token*)
            if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
            IN_API_TOKEN="${1#*=}"
            ;;
        --help|-h)
            printf "Options:\n"
            printf "%-30s%-s\n" "  -gt, --gotify-token" "Specify the application token for Gotify"
            printf "%-30s%-s\n" "  -in, --invoiceninja-token" "Specify the API token for Invoice Ninja"
            exit 0
            ;;
        *)
            printf "Error: Invalid argument, run --help for valid options.\n"
            exit 1
    esac
    shift
done

if [[ $(docker run --network=traefik --rm curlimages/curl -Lso /dev/null -w "%{http_code}" -X GET http://invoiceninja-nginx/api/v1/health_check -H "X-API-TOKEN: ${IN_API_TOKEN}") != "200" ]]; then
    cd "$( dirname "${BASH_SOURCE[0]}" )"
    docker compose up -d --force-recreate invoiceninja-nginx
    docker run --network=traefik --rm curlimages/curl "http://gotify/message?token=${GOTIFY_TOKEN}" -F "title=Invoice Ninja" -F "message=Restarted Invoice Ninja" -F "priority=5"
fi

