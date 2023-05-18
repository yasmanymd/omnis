#!/bin/sh
folder=~/backup/$(date +'%y%m%d-%H%M')
mkdir -p $folder
./db/backup.sh $folder
./keycloack/backup.sh $folder
./documents/backup.sh $folder