#backup
docker exec -i omnis-omnisdb-1 /usr/bin/mongodump --username root --password secret --authenticationDatabase admin --out /dump
docker cp omnis-omnisdb-1:/dump ~/Downloads/dump/$(date +'%y-%m-%d')
docker exec -it omnis-omnisdb-1 /bin/bash
rm -rf /dump

#restore
docker cp ~/Downloads/dump/23-04-26 omnis-omnisdb-1:/dump 
docker exec -i omnis-omnisdb-1 /usr/bin/mongorestore --username root --password secret --authenticationDatabase admin /dump
docker exec -it omnis-omnisdb-1 /bin/bash
rm -rf /dump