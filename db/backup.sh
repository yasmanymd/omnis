#!/bin/sh
mkdir ~/backup
docker exec -i omnis-omnisdb-1 /usr/bin/mongodump --username root --password secret --authenticationDatabase admin --out /dump
docker cp omnis-omnisdb-1:/dump ~/backup/$(date +'%y-%m-%d %H-%M')
docker exec -it omnis-omnisdb-1 rm -rf /dump