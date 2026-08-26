#!/bin/sh
# Chatwoot DB-schema watchdog. Runs inside the Ofelia scheduler container.
#
# Detects when the running Chatwoot image's schema is out of sync with the
# database (pending / 'down' migrations). If found, it auto-applies them and
# restarts rails + sidekiq so the app reloads the schema, then notifies Gotify.
#
# This is the safety net for the auto-migrate-on-start entrypoint: if a
# container is ever recreated without that hook (e.g. Watchtower), this catches
# the drift within a few minutes and repairs it.
#
# Usage: sh check-migrations.sh -t <GOTIFY_TOKEN>

GOTIFY_TOKEN=""

while getopts t: flag; do
  case "${flag}" in
    t) GOTIFY_TOKEN=${OPTARG} ;;
  esac
done

log() { echo "$(date '+%F %T') $*"; }

# Skip if the app container isn't up (nothing to check against).
running=$(docker inspect -f '{{.State.Running}}' chatwoot-rails 2>/dev/null)
if [ "$running" != "true" ]; then
  log "chatwoot-rails not running; skipping"
  exit 0
fi

down=$(docker exec chatwoot-rails bundle exec rails db:migrate:status 2>/dev/null | grep -c '^  down' || true)

if [ "$down" -gt 0 ]; then
  log "WARN: $down pending migration(s) detected -> applying and restarting"
  if docker exec chatwoot-rails bundle exec rails db:migrate >/dev/null 2>&1; then
    docker restart chatwoot-rails chatwoot-sidekiq >/dev/null 2>&1
    log "INFO: migrations applied; rails+sidekiq restarted"
  else
    log "ERROR: db:migrate failed"
  fi

  if [ -n "$GOTIFY_TOKEN" ]; then
    docker run --network=traefik --rm curlimages/curl \
      "http://gotify/message?token=$GOTIFY_TOKEN" \
      -F "title=Chatwoot" \
      -F "message=DB schema was out of sync ($down pending migrations). Migrated and restarted rails+sidekiq." \
      -F "priority=5" >/dev/null 2>&1 && log "INFO: Gotify notified" || log "WARN: Gotify notify failed"
  fi
else
  log "OK: migrations in sync (down=0)"
fi
