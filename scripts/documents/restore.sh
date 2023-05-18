#!/bin/sh
folder=$1/documents
docker cp $folder/. omnis-portal-1:/usr/src/app/public/docs