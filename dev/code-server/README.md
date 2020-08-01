# Code-server (VS Code)

## Getting Started:
Clone this repo, then create a [.env file](.env) and place it in the same directory as the [docker-compose.yml](docker-compose.yml). Paste the following content into the .env file and input/change variables according to your preferences.

```bash
# General / common settings
PUID=1000
PGID=1000
TZ=America/New_York
CONFIG_DIR=/mnt/hdd/docker/config
```

This container runs on a pre-defined network called `backend`. If you don't already have it created, run this:
```bash
docker network create backend
```

Then simply run the docker-compose file to start the server:

```bash
docker-compose up -d
```
