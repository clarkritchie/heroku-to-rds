#!/usr/bin/env bash

source /restore/env_vars

env

dropdb --if-exists -h $PGHOST -U postgres blueboard
createdb -h ${PGHOST} -U ${PGUSER} blueboard

pg_restore --host ${PGHOST} \
	--username ${PGUSER} \
	--jobs=20 \
	--disable-triggers \
	--dbname ${DB_NAME} /data/blueboard_data*

tail -f /dev/null
