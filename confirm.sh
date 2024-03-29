#!/usr/bin/env bash

source env_vars

if [ -z "${DB_NAME}" ]; then
  # Heroku
  psql --command "SELECT pg_size_pretty( pg_database_size('"${PGDATABASE}"'));"
else
  # AWS
  psql --command "SELECT pg_size_pretty( pg_database_size('"${DB_NAME}"'));"
fi

psql --command "SELECT reltuples AS estimate FROM pg_class where relname = 'rewards';" --dbname ${DB_NAME}
psql --command "SELECT reltuples AS estimate FROM pg_class where relname = 'accounts';" --dbname ${DB_NAME}
psql --command "SELECT reltuples AS estimate FROM pg_class where relname = 'companies';" --dbname ${DB_NAME}