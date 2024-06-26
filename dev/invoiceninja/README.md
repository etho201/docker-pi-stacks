# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that **Invoice Ninja** is inaccessible, it will automatically rebuild the container for invoiceninja-nginx and a notification will be sent via Gotify.

> **Important:** Ensure `docker` can be found in one of the paths specified in the script. Example: `/usr/bin/docker`

Example of Cron job:

```bash
*/5 * * * * bash /path/to/healthcheck.sh --invoiceninja-token=IN_API_TOKEN --gotify-token=GOTIFY_TOKEN >/dev/null 2>&1
```

| Option | Description | Required? |
|--------|-------------|-----------|
|`--invoiceninja-token`|Invoice Ninja API Token|`True`|
|`--gotify-token`|Gotify Token|`True`|

> **Example:** This will run the health check **every 5 minutes**. See [https://crontab.guru](https://crontab.guru/#*/5_*_*_*_*) for help creating cron expressions.
