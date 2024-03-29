#!/usr/bin/env bash
#
# run this with nohup:
#
# nohup /restore/restore.sh > /restore/restore.log 2>&1 &
#

# SELECT pg_terminate_backend(pid) 
# FROM pg_stat_activity 
# WHERE  pid <> pg_backend_pid() AND datname = 'blueboard';

set -e
source /restore/env_vars
name="restore" && export PS1="\u@${name} \w> "

dropdb --if-exists -h $PGHOST -U postgres blueboard
createdb -h ${PGHOST} -U ${PGUSER} blueboard

pg_restore --host ${PGHOST} \
  --username ${PGUSER} \
  --jobs=20 \
  --disable-triggers \
  --no-owner \
  --role=postgres \
  --verbose \
  --dbname ${DB_NAME} /data/blueboard*


