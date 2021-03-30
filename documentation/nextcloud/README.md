# Nextcloud Documentation

## Manually adding files

Scan for new files and update the file cache:

```bash
docker exec -ti --user www-data nextcloud /var/www/html/occ files:scan --all
```

## Too many requests error

```bash
docker exec -it nextcloud-db bash
psql -U nextcloud -d nextcloud
SELECT * FROM oc_bruteforce_attempts;
DELETE FROM oc_bruteforce_attempts WHERE IP="xxx.xxx.xxx.xxx";
```