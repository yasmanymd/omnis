#!/bin/sh
folder=$1/db
sudo docker cp $folder omnis-omnisdb-1:/dump 
sudo docker exec -i omnis-omnisdb-1 /usr/bin/mongorestore --username root --password secret --drop --preserveUUID --authenticationDatabase admin /dump
sudo docker exec -it omnis-omnisdb-1 rm -rf /dump