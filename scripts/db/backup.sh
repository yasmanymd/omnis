#!/bin/sh
folder=$1/db
mkdir -p $folder
sudo docker exec -i omnis-omnisdb-1 /usr/bin/mongodump --username root --password secret --authenticationDatabase admin --out /dump
sudo docker cp omnis-omnisdb-1:/dump/. $folder
sudo docker exec -it omnis-omnisdb-1 rm -rf /dump