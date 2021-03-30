# Check if Transmission is working
*/1 * * * * FQDN=etho201.duckdns.org; GOTIFY_TOKEN=APrH9XJORPIm0Qq; if [[ "$(curl -L -s -o /dev/null -w "%{http_code}" transmission.${FQDN})" == "404" ]]; then docker restart wireguard transmission qbittorrent && curl "https://gotify.${FQDN}/message?token=${GOTIFY_TOKEN}" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"; fi




*/1 * * * *
FQDN=etho201.duckdns.org
GOTIFY_TOKEN=APrH9XJORPIm0Qq

```
*/1 * * * * sh test.sh -d etho201.duckdns.org -g APrH9XJORPIm0Qq
```

```bash
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
```


# Gotify

FQDN=etho201.duckdns.org; GOTIFY_TOKEN=APrH9XJORPIm0Qq; curl "https://gotify.$FQDN/message?token=$GOTIFY_TOKEN" -F "title=Transmission" -F "message=Restarted Transmission" -F "priority=5"