#!/bin/sh
folder=$1/keycloack
configsFolder=$folder/configs
dbFolder=$folder/db
sudo docker cp $configsFolder/standalone.xml omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone.xml
sudo docker cp $configsFolder/standalone-ha.xml omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml
sudo docker exec -it omnis-postgres-1 dropdb -f -U keycloak keycloak
sudo docker exec -it omnis-postgres-1 createdb -U keycloak keycloak
sudo docker exec -i omnis-postgres-1 psql -U keycloak keycloak < $dbFolder/keycloak_backup.sql