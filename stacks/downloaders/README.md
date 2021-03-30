# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that Transmission is inaccessible, it will automatically rebuild the containers for Wireguard, Transmission, and qBittorrent and a notification will be sent via Gotify.

Example of Cron job:

```bash
*/5 * * * * bash /path/to/healthcheck.sh -t GOTIFY_TOKEN >/dev/null 2>&1
```

| Option | Description | Required? |
|--------|-------------|-----------|
|`-t`|Gotify **T**oken|`True`|

> **Example:** This will run the health check **every 5 minutes**. See [https://crontab.guru](https://crontab.guru/#*/5_*_*_*_*) for help creating cron expressions.