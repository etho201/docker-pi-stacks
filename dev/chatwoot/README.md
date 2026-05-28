

Initial Setup:

```bash
docker compose run --rm rails bundle exec rails db:setup
docker compose up -d --force-recreate


# To enable 2FA
docker compose exec rails bundle exec rails db:encryption:init
```
