# Nextcloud Documentation

## When you have trouble logging in from the Android App:
1. Login to the Nextcloud desktop interface.
1. Click the `User Icon` &rarr; `Settings` &rarr; `Personal` &rarr; `Security`.
1. Click on `Create new app password`
1. Click on `Show QR code for mobile apps`
1. From the Android app, click on `Alternative log in using app token`.

---
## Manually adding files

Scan for new files and update the file cache:

```bash
docker exec -ti --user www-data nextcloud /var/www/html/occ files:scan --all
```
---
## Too many requests error

```bash
docker exec -it nextcloud-db bash
psql -U nextcloud -d nextcloud
SELECT * FROM oc_bruteforce_attempts;
DELETE FROM oc_bruteforce_attempts WHERE IP="xxx.xxx.xxx.xxx";
```
---