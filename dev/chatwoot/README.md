# Chatwoot

## Initial Setup:

```bash
docker compose run --rm rails bundle exec rails db:setup
docker compose up -d --force-recreate


# To enable 2FA
docker compose exec rails bundle exec rails db:encryption:init
```

docker compose run --rm rails bundle exec rails db:migrate:status

docker compose run --rm rails bundle exec rails db:migrate


## Deleting records

Use this command to delete conversations and messages from a specific ID onward, while automatically recalculating and resetting the database sequence counters to prevent duplicate ID conflicts. Adjust the FROM_ID variable to set the starting range for deletion.

```bash
printf "Enter the starting range for convesation deletion: " && read -r FROM_ID
ssh -o StrictHostKeyChecking=no erik@192.168.1.10 "docker exec chatwoot-db psql -U postgres -d chatwoot -c \"DELETE FROM messages WHERE conversation_id >= $FROM_ID; DELETE FROM conversations WHERE id >= $FROM_ID; SELECT setval('conv_dpid_seq_1', COALESCE((SELECT max(display_id) FROM conversations), 0) + 1, false); SELECT setval('conversations_id_seq', COALESCE((SELECT max(id) FROM conversations), 0) + 1, false); SELECT setval('messages_id_seq', COALESCE((SELECT max(id) FROM messages), 0) + 1, false);\" 2>&1 | grep -E 'DELETE|setval'"
```

## Deleting contacts

Use this command to delete contacts and their inbox links from a specific ID onward, while automatically resetting the database sequence counters to prevent duplicate ID conflicts. Adjust the FROM_ID variable to set the starting range for deletion.

```bash
printf "Enter the starting range for contact deletion: " && read -r FROM_ID
ssh -o StrictHostKeyChecking=no erik@192.168.1.10 "docker exec chatwoot-db psql -U postgres -d chatwoot -c \"DELETE FROM contact_inboxes WHERE contact_id >= $FROM_ID; DELETE FROM contacts WHERE id >= $FROM_ID; SELECT setval('contacts_id_seq', COALESCE((SELECT max(id) FROM contacts), 0) + 1, false);\" 2>&1 | grep -E 'DELETE|setval'"
````

## Change reporter:

```bash
printf "Enter the Conversation ID: " && read -r CONV_ID
printf "Enter the Target Contact ID (New Reporter): " && read -r TARGET_CONTACT_ID

ssh -o StrictHostKeyChecking=no erik@192.168.1.10 "docker exec chatwoot-rails bundle exec rails runner \"
conv = Conversation.find($CONV_ID)
contact = Contact.find($TARGET_CONTACT_ID)
contact_inbox = contact.contact_inboxes.find_by(inbox_id: conv.inbox_id) || contact.contact_inboxes.create!(inbox_id: conv.inbox_id, source_id: SecureRandom.uuid)

conv.update!(contact_id: contact.id, contact_inbox_id: contact_inbox.id)
conv.messages.where(sender_type: 'Contact').update_all(sender_id: contact.id)
\""
```

---

# Troubleshooting

## 2FA stopped working?

```bash
docker compose run --rm rails bundle exec rails db:migrate:status
docker compose run --rm rails bundle exec rails db:migrate
```