# docker-compose

## Getting Started
Create a .env file and place in the same directory as the docker-compose.yml file. Paste the following content into the .env file. Sensitive information is stored in BitWarden.

```bash
# General / common settings
PUID=1000
PGID=1000
TZ=America/Los_Angeles
USERDIR=/home/pi
EXTHDD_DIR=/mnt/hdd
CONFIG_DIR=/mnt/hdd/docker/config
VOLUME_DIR=/mnt/hdd/docker/volume

# Username you want to use for (nearly) everything
USERNAME=

# Duck DNS / Let's Encrypt
FQDN=example1.duckdns.org
DUCKDNS_SUBDOMAINS=example1,example2
DUCKDNS_TOKEN=

# Nextcloud and database config
POSTGRES_USER=
POSTGRES_PASSWORD=
NEXTCLOUD_PASSWORD=

# Transmission-VPN
OPENVPN_USERNAME=
OPENVPN_PASSWORD=

# Used for oauth2 authentication
GITHUB_ORG=
GITHUB_OAUTH_CLIENT_ID=
GITHUB_OAUTH_CLIENT_SECRET=
OAUTH2_PROXY_COOKIE_SECRET=



# Not currently used
#EMAIL_FROM=
#EMAIL_TO=
#EMAIL_PASSWORD=
#HTTP_USERNAME=
#HTTP_PASSWORD=
#TRANSMISSION_USERNAME=
#TRANSMISSION_PASSWORD=
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
