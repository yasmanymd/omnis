#!/bin/sh
folder=$1/db
mkdir -p $folder
docker exec -i omnis-omnisdb-1 /usr/bin/mongodump --username root --password secret --authenticationDatabase admin --out /dump
docker cp omnis-omnisdb-1:/dump/. $folder
docker exec -it omnis-omnisdb-1 rm -rf /dump