# Joplin Server

## Info:

Pre-release announcement: https://discourse.joplinapp.org/t/joplin-server-pre-release-is-now-available/13605

Official GitHub Repo: https://github.com/laurent22/joplin/tree/dev/packages/server

Docker images:
- https://hub.docker.com/r/joplin/server
- https://hub.docker.com/r/florider89/joplin-server

## Variables:

List of required variables for Joplin Server:

|Variable|Description|Required?|
|--------|-----------|---------|
| `FQDN` | Fully qualified domain name | Yes |
| `VOLUME_DIR` | Location to store persistent data | Yes |
| `JOPLIN_DB_PASS` | The password for the PostgreSQL Joplin Database | Yes |