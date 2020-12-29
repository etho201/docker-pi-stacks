# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that Transmission is inaccessible, it will automatically restart the containers for Wireguard, Transmission, and qBittorrent and a notification will be sent via Gotify.

Example of Cron job:

```bash
*/1 * * * * bash /path/to/healthcheck.sh -t GOTIFY_TOKEN >/dev/null 2>&1
```

| Option | Description | Required? |
|--------|-------------|-----------|
|`-t`|Gotify **T**oken|`True`|