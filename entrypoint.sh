#!/bin/bash
set -e
echo "ENVIRONMENT: $RAILS_ENV"

# Remove a potentially pre-existing server.pid for Rails.
rm -f $APP_PATH/tmp/pids/server.pid

database_config_path="$APP_PATH/config/database.yml"
multischool_settings_path="$APP_PATH/vendor/plugins/acts_as_multi_school/config/multischool_settings.yml"

rm -f database_config_path
cp $APP_PATH/database.yml.docker "$database_config_path"

rm -rf multischool_settings_path
cp "$multischool_settings_path".example "$multischool_settings_path"

rake fedena:install_multischool
rake fedena:seed_schools

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
