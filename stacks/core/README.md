To launch all the containers:
```
docker compose up -d
```

To launch an individual container, specify the service (for example: Lidarr):
```
docker compose up -d gotify
```

To launch multiple containers, separate the services with spaces (for example: db1 and nextcloud):
```
docker compose up -d nextcloud nextcloud-db
```

---

## Troubleshooting:

- If trying to put Plex behind a reverse proxy and you're using Cloudflare, you'll need to either disable the proxy in Cloudflare (DNS only routing) for `plex.${FQDN}`, or create a Configuration Rule for `https://plex.${FQDN}/web/index.html` that turns off the Cloudflare Rocket Loader. See [here](https://www.reddit.com/r/PleX/comments/n4l2fu/web_client_stuck_on_the_plex_logo_when_accessing/?utm_source=share&utm_medium=ios_app&utm_name=iossmf) for more info.