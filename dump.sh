#!/usr/bin/env bash

set -e
source /dump/env_vars
name="dump" && export PS1="\u@${name} \w> "

export DATE=$(date '+%Y_%m_%d_at_%H_%M_%S')
export LOG="/data/pg_dump_${DATE}.log"
export SCHEMA_FILE="/data/blueboard_schema_${DATE}.dump"
export DATA_DIR="/data/blueboard_${DATE}"        # this is a directory
export DATA_FILE="/data/blueboard_${DATE}.sql"   # this is a file

echo "Running pg_dump to capture data to: ${DATA_DIR}"
pg_dump --format d \
  --jobs 20 \
  --no-acl \
  --no-owner \
  --verbose \
  --rows-per-insert=500 \
  -f ${DATA_DIR} \
  --create

echo "Done"