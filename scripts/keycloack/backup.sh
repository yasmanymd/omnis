#!/bin/sh
folder=$1/keycloack
configsFolder=$folder/configs
dbFolder=$folder/db
mkdir -p $configsFolder
mkdir -p $dbFolder
sudo docker cp omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone.xml $configsFolder
sudo docker cp omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml $configsFolder
sudo docker exec -t omnis-postgres-1 pg_dump -U keycloak -d keycloak > $dbFolder/keycloak_backup.sql