# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that Transmission is down, it will automatically restart the Wireguard, Transmission, and qBitTorrnet containers.

Example of Cron job:

```bash
*/1 * * * * bash /path/to/healthcheck.sh -d EXAMPLE.DOMAIN.COM -g GOTIFY_TOKEN >/dev/null 2>&1
```