# HOUSEKEEPING

This is an exercise. To install it, just clone the repo and then

1. Create env-api file with Twitter auth data. (There's an example on env-api.example.)
2. `docker-compose run --rm api rails db:create db:migrate db:seed`
3. `docker-compose up -d frontend`
