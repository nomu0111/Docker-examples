#!/bin/bash

podman build ./db/backup/ -t pgbackup

d=`date +%Y%m%d_%H%M%S`

podman run \
  --rm  \
  -v ./db/backup/data:/backup \
  --network 01_default \
  -e PGPASSWORD=password \
  localhost/pgbackup \
  pg_dump -h 01_pg_1  -U postgres --file=/backup/backup_${d}.sql testdb 

  

# podman run  \
#   -it --rm  \
#   -v ./db/backup/data:/backup \
#   --network 01_default \
#   localhost/pgbackup \
#   /bin/sh
