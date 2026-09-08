#!/bin/sh

# Overrides the image's docker/entrypoints/rails.sh (bind-mounted read-only).
# Identical to the upstream script EXCEPT for the extra "bundle exec rails
# db:migrate" step just before the app starts, so the DB schema is always kept
# in sync with whatever image is running. Idempotent (no-op when up to date).
#
# Used by both chatwoot-rails and chatwoot-sidekiq. Safe when they boot
# together: Postgres serializes the DDL via advisory locks on schema_migrations.

set -x

# Remove a potentially pre-existing server.pid for Rails.
rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

echo "Waiting for postgres to become ready...."

# Let DATABASE_URL env take presedence over individual connection params.
# This is done to avoid printing the DATABASE_URL in the logs
$(docker/entrypoints/helpers/pg_database_url.rb)
PG_READY="pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USERNAME"

until $PG_READY
do
  sleep 2;
done

echo "Database ready to accept connections."

#install missing gems for local dev as we are using base image compiled for production
bundle install

BUNDLE="bundle check"

until $BUNDLE
do
  sleep 2;
done

# Apply any pending schema migrations so the DB matches the running image.
bundle exec rails db:migrate

# Execute the main process of the container
exec "$@"
