#!/bin/bash

podman build ./db/backup/ -t pgbackup

# d=`date +%Y%m%d_%H%M%S`
RESTORE_FILE=backup_20230818_083910.sql

# テキスト形式のリストア

podman run \
  --rm  \
  -v ./db/backup/data:/backup \
  --network 01_default \
  -e PGPASSWORD=password \
  localhost/pgbackup \
  psql -h 01_pg_1 -U postgres -d testdb -f /backup/${RESTORE_FILE}

# 接続してのテスト用
# podman run \
#   --rm  \
#   -v ./db/backup/data:/backup \
#   --network 01_default \
#   -e PGPASSWORD=password \
#   -it \
#   localhost/pgbackup \
#   /bin/sh
