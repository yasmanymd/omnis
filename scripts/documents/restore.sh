#!/bin/sh
folder=$1/documents
sudo docker exec omnis-portal-1 rm -rf /usr/src/app/public/docs
sudo docker exec omnis-portal-1 mkdir -p /usr/src/app/public/docs
sudo docker cp $folder/. omnis-portal-1:/usr/src/app/public/docs