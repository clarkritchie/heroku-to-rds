#!/usr/bin/env bash

set -e

export DATE=$(date '+%Y_%m_%d_at_%H_%M_%S')
export LOG="/data/pg_dump_${DATE}.log"
export SCHEMA_FILE="/data/blueboard_schema_${DATE}.dump"
export DATA_DIR="/data/blueboard_${DATE}"        # this is a directory
export DATA_FILE="/data/blueboard_${DATE}.sql"   # this is a file

source /dump/env_vars

# these must all be set in the env for pg_dump
# [ ! -z ${PGPASSWORD} ] || echo "Check that PGPASSWORD is set as an env var" && exit 1
# [ ! -z ${PGUSER} ] || echo "Check that PGUSER is set as an env var" && exit 1
# [ ! -z ${PGHOST} ] || echo "Check that PGHOST is set as an env var" && exit 1
# [ ! -z ${PGDATABASE} ] || echo "Check that PGDATABASE is set as an env var" && exit 1

# echo "Running pg_dump to capture schema to: ${SCHEMA_FILE}"
# pg_dump --format=p \
#   --no-acl \
#   --inserts \
#   --schema 'public' \
#   --schema 'heroku_ext' \
#   --schema-only \
#   --no-owner \
#   --dbname d1d8hj23766b5m \
#   --file ${SCHEMA_FILE}
# echo "Done"

# mv ${SCHEMA_FILE} ${SCHEMA_FILE}.bak
# cat ${SCHEMA_FILE}.bak | sed s/heroku_ext/public/g > ${SCHEMA_FILE}
# echo "Done"

# # can run this with nohup and fork it
# echo "Running pg_dump to capture data to: ${DATA_DIR}"
# pg_dump --format=c \
#     --no-acl \
#     --rows-per-insert=1000 \
#     --schema 'public' \
#     --schema 'heroku_ext' \
#     --data-only \
#     --exclude-table-data 'public.event_store_events' \
#     --exclude-table-data 'public.event_store_events_in_streams' \
#     --no-owner \
#     --jobs 40 \
#     --verbose \
#     --file ${DATA_DIR} >> ${LOG} 2>&1

echo "Running pg_dump to capture data to: ${DATA_DIR}"
pg_dump --format d --jobs 20 --no-acl --no-owner --verbose --rows-per-insert=500 -f ${DATA_DIR} --create

# echo "Running pg_dump to capture data to: ${DATA_FILE}"
# pg_dump --no-acl --no-owner --verbose --rows-per-insert=500 -f ${DATA_FILE} --create

echo "Done"