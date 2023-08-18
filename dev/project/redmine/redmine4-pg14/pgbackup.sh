#!/bin/bash

podman build ./db/backup/ -t pgbackup

d=`date +%Y%m%d_%H%M%S`
POSTGRES_DB=redmine
POSTGRES_USER=redmine_user
POSTGRES_PASSWORD=redmine_passwd
NETWORK=redmine4-pg14_default

podman run \
  --rm  \
  -v ./db/backup/data:/backup \
  --network ${NETWORK} \
  -e PGPASSWORD=${POSTGRES_PASSWORD} \
  localhost/pgbackup \
  pg_dump -h redmine-db  -U ${POSTGRES_USER} --file=/backup/backup_${d}.sql ${POSTGRES_DB} 

  

# podman run  \
#   -it --rm  \
#   -v ./db/backup/data:/backup \
#   --network 01_default \
#   localhost/pgbackup \
#   /bin/sh
