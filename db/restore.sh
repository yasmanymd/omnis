#!/bin/sh
ls ~/backup 
echo "Folder to restore?"
read folder 
docker cp ~/backup/$folder omnis-omnisdb-1:/dump 
docker exec -i omnis-omnisdb-1 /usr/bin/mongorestore --username root --password secret --authenticationDatabase admin /dump
docker exec -it omnis-omnisdb-1 rm -rf /dump