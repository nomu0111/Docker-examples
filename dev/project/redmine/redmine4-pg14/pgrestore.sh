#!/bin/bash

podman build ./db/backup/ -t pgbackup

d=`date +%Y%m%d_%H%M%S`
POSTGRES_DB=redmine
POSTGRES_USER=redmine_user
POSTGRES_PASSWORD=redmine_passwd
NETWORK=redmine4-pg14_default
RESTORE_FILE=backup_20230818_090658.sql

podman run \
  --rm  \
  -v ./db/backup/data:/backup \
  --network ${NETWORK} \
  -e PGPASSWORD=${POSTGRES_PASSWORD} \
  localhost/pgbackup \
  psql -h redmine-db -U ${POSTGRES_USER}  -d ${POSTGRES_DB} -f /backup/${RESTORE_FILE}


# podman run  \
#   -it --rm  \
#   -v ./db/backup/data:/backup \
#   --network 01_default \
#   localhost/pgbackup \
#   /bin/sh
