# Implementing a health check

Create a Cron job that calls the `healthcheck.sh` file. If the health check determines that Transmission is down, it will automatically restart the Wireguard, Transmission, and qBitTorrnet containers.

Example of Cron job:

```bash
*/1 * * * * bash healthcheck.sh -d DOMAIN.EXAMPLE.COM -g GOTIFY_TOKEN
```