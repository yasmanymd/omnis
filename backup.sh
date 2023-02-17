docker exec -i omnis-omnisdb-1 /usr/bin/mongodump --username root --password secret --authenticationDatabase admin --out /dump
docker cp omnis-omnisdb-1:/dump ~/Downloads/dump/$(date +'%y-%m-%d')

docker exec -it omnis-omnisdb-1 /bin/bash
rm -rf /dump