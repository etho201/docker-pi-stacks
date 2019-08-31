# docker-compose

## Getting Started
Create a .env file and place in the same directory as the docker-compose.yml file. Paste the following content into the .env file. Sensitive information is stored in BitWarden.

```
PUID=1000
PGID=1000
TZ=America/Los_Angeles
USERDIR=/home/pi
EXTHDD_DIR=/mnt/hdd
CONFIG_DIR=/mnt/hdd/docker/config
VOLUME_DIR=/mnt/hdd/docker/volume
USERNAME=
EMAIL_FROM=
EMAIL_TO=
EMAIL_PASSWORD=
DUCKDNS_SUBDOMAINS=example1,example2
DUCKDNS_TOKEN=
HTTP_USERNAME=
HTTP_PASSWORD=
TRANSMISSION_USERNAME=
TRANSMISSION_PASSWORD=
FQDN=example1.duckdns.org
POSTGRES_USER=
POSTGRES_PASSWORD=
NEXTCLOUD_PASSWORD=
OPENVPN_USERNAME=
OPENVPN_PASSWORD=
DUCKDNS_TOKEN=
GITHUB_ORG=
GITHUB_OAUTH_CLIENT_ID=
GITHUB_OAUTH_CLIENT_SECRET=
OAUTH2_PROXY_COOKIE_SECRET=
```

---

## Launching containers:

1. To launch all the containers:
    ```
    docker-compose up -d
    ```

2. To launch an individual container, specify the service (for example: Radarr):
    ```
    docker-compose up -d radarr
    ```

3. To launch multiple containers, separate the services with spaces (for example: db1 and nextcloud):
    ```
    docker-compose up -d db1 nextcloud
    ```

---

> **_NOTE:_**  New containers are delevoped in the dev folder and evaluated before moving to the pi-stack.