#!/bin/bash
set -e
echo "ENVIRONMENT: $RAILS_ENV"

# Remove a potentially pre-existing server.pid for Rails.
rm -f $APP_PATH/tmp/pids/server.pid

database_config_path="$APP_PATH/config/database.yml"

rm -f database_config_path
cp $APP_PATH/database.yml.docker "$database_config_path"

cp config/connect_settings.yml.example config/connect_settings.yml
cp config/fedena.yml.example config/fedena.yml
cp config/gps_settings.yml.example config/gps_settings.yml

rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
