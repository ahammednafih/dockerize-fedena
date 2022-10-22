#!/bin/bash
set -e
echo "ENVIRONMENT: $RAILS_ENV"

# Remove a potentially pre-existing server.pid for Rails.
rm -f $APP_PATH/tmp/pids/server.pid

database_config_path="$APP_PATH/config/database.yml"
flux_config_path="$APP_PATH/config/flux.yml"
secrets_config_path="$APP_PATH/config/secrets.yml"

rm -f database_config_path
cp $APP_PATH/database.yml.docker "$database_config_path"

rm -f flux_config_path
cp $APP_PATH/flux.yml.docker "$flux_config_path"

rm -f secrets_config_path
cp $APP_PATH/secrets.yml.docker "$secrets_config_path"

bundle exec rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
