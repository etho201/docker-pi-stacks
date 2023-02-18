# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that Transmission is inaccessible, it will automatically rebuild the containers for Wireguard, Transmission, and qBittorrent and a notification will be sent via Gotify.

> **Important:** Ensure `docker` can be found in one of the paths specified in the script. Example: `/usr/bin/docker`

Example of Cron job:

```bash
*/5 * * * * bash /path/to/healthcheck.sh -t GOTIFY_TOKEN >/dev/null 2>&1
```

| Option | Description | Required? |
|--------|-------------|-----------|
|`-t`|Gotify **T**oken|`True`|

> **Example:** This will run the health check **every 5 minutes**. See [https://crontab.guru](https://crontab.guru/#*/5_*_*_*_*) for help creating cron expressions.

---

# TorGuard &ndash; Check My IP Torrent

Get link from here: https://torguard.net/checkmytorrentipaddress.php

In the magnet URL, replace `checkmyiptorrent+Tracking+Link` with `TorGuard%20<--->%20checkmyiptorrent`.

---

# Troubleshooting

## UUID/GUID

If you launch the Transmission container and cannot find any settings or download history, check the file/directory permissions of the Transmission directory `${config_dir}/transmission` on the host. It could be that you set your local username to be the owner of everything in that directory (a logical choice), but Transmission (especially when using Podman) expects the ownership to be `100999`. If that is the case, you may need to run `sudo chown -R 100999:100999 ${config_dir}/transmission` to fix the issue.