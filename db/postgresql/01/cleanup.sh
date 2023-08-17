#!/bin/bash

APPNAME=${PWD##*/}

echo ${APPNAME}

for LINE in `podman ps -a | grep "\s${APPNAME}" | awk '{print $1}'`
do
#  echo ${LINE}
  podman rm -f ${LINE}
done

sudo rm -fr ./db/data/
mkdir ./db/data

