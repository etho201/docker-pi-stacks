# Troubleshooting

If you get a "peer uuid mismatch" message in the rustdesk-server logs:

If you are using a self-hosted RustDesk server and issues persist, you can manage the peer database directly.

1. Stop the hbbs service.
2. Edit the `db_v2.sqlite3` database file using an SQLite editor to delete complete peer entries or change IDs with SQL queries.
3. Restart the hbbs service. 