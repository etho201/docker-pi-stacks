#!/bin/bash
# Checks that Chatwoot's ActionCable Redis pub/sub listener is alive.
# The listener subscribes to the '_action_cable_internal' channel once the first
# WebSocket client connects. If it dies (e.g. Redis is recreated), broadcasts stop
# reaching widgets while nothing errors — this restarts rails to recover.
# Only acts when clients ARE connecting to /cable (avoids false positives when the
# service is genuinely idle and the listener hasn't started yet).
STACK=/home/erik/documents/git/docker-pi-stacks/dev/chatwoot
PW=$(grep '^REDIS_PASSWORD=' $STACK/.env | cut -d= -f2-)
cable_recent=$(docker logs chatwoot-rails --since 15m 2>/dev/null | grep -c '/cable' || true)
subscribed=$(docker exec chatwoot-redis redis-cli -a "$PW" --no-auth-warning PUBSUB CHANNELS 2>/dev/null | grep -c '^_action_cable_internal$' || true)
if [ "$cable_recent" -gt 0 ] && [ "$subscribed" -eq 0 ]; then
  echo "$(date '+%F %T') ActionCable listener DOWN (cable_conns=$cable_recent sub=$subscribed) -> restarting chatwoot-rails"
  docker restart chatwoot-rails
else
  echo "$(date '+%F %T') OK sub=$subscribed cable_recent=$cable_recent"
fi
