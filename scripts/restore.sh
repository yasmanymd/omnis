#!/bin/sh
./db/restore.sh $1
./keycloack/restore.sh $1
./documents/restore.sh $1