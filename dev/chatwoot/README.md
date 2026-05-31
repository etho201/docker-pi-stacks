# Chatwoot

## Initial Setup:

```bash
docker compose run --rm rails bundle exec rails db:setup
docker compose up -d --force-recreate


# To enable 2FA
docker compose exec rails bundle exec rails db:encryption:init
```


## Deleting records

Use this command to delete conversations and messages from a specific ID onward, while automatically recalculating and resetting the database sequence counters to prevent duplicate ID conflicts. Adjust the FROM_ID variable to set the starting range for deletion.

```bash
printf "Enter the starting range for deletion: " && read -r FROM_ID
ssh -o StrictHostKeyChecking=no erik@192.168.1.10 "docker exec chatwoot-db psql -U postgres -d chatwoot -c \"DELETE FROM messages WHERE conversation_id >= $FROM_ID; DELETE FROM conversations WHERE id >= $FROM_ID; SELECT setval('conv_dpid_seq_1', COALESCE((SELECT max(display_id) FROM conversations), 0) + 1, false); SELECT setval('conversations_id_seq', COALESCE((SELECT max(id) FROM conversations), 0) + 1, false); SELECT setval('messages_id_seq', COALESCE((SELECT max(id) FROM messages), 0) + 1, false);\" 2>&1 | grep -E 'DELETE|setval'"
```