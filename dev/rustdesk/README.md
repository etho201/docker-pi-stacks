# Troubleshooting

If you get a "peer uuid mismatch" message in the `rustdesk-id` container logs:

You will need to manage the peer database directly.

1. Stop the `rustdesk-id` and `rustdesk-relay` containers.
2. Edit the `db_v2.sqlite3` database file using an SQLite editor to delete complete peer entries or change IDs with SQL queries.
3. Restart the `rustdesk-id` and `rustdesk-relay` containers.

> **Note:** May need to move the `*-wal` and `*-shm` files to a backup directory for the changes to persist. Delete these files after verifying everything is running as expected.