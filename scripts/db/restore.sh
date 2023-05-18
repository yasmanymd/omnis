#!/bin/sh
folder = $1/db
docker cp $folder omnis-omnisdb-1:/dump 
docker exec -i omnis-omnisdb-1 /usr/bin/mongorestore --username root --password secret --drop --preserveUUID --authenticationDatabase admin /dump
docker exec -it omnis-omnisdb-1 rm -rf /dump