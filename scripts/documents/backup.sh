#!/bin/sh
folder=$1/documents
mkdir -p $folder
sudo docker cp omnis-portal-1:/usr/src/app/public/docs/. $folder