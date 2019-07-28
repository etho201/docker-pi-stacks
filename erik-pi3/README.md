Create a .env file and place in the same directory as the docker-compose.yml file. Paste the following content into the .env file.
Sensitive information is stored in BitWarden.

PUID=1000

PGID=1000

TZ=America/Los_Angeles

USERDIR=/home/pi

DOCKER_DIR=/home/pi/containers/config

VOLUME_DIR=/mnt/hdd/docker

HTTP_USERNAME=

HTTP_PASSWORD=

TRANSMISSION_USERNAME=

TRANSMISSION_PASSWORD=

FQDN=

POSTGRES_PASSWORD=

NEXTCLOUD_PASSWORD=

OPENVPN_USERNAME=

OPENVPN_PASSWORD=

EMAIL_PASSWORD=

DUCKDNS_TOKEN=

GITHUB_ORG=

GITHUB_OAUTH_CLIENT_ID=

GITHUB_OAUTH_CLIENT_SECRET=

OAUTH2_PROXY_COOKIE_SECRET=
