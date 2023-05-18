#!/bin/sh
folder = $1/keycloack
configsFolder=$folder/configs
dbFolder=$folder/db
docker cp $configsFolder/standalone.xml omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone.xml
docker cp $configsFolder/standalone-ha.xml omnis-keycloak-1:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml
docker exec -it omnis-postgres-1 createdb -U keycloak keycloak
docker exec -i omnis-postgres-1 psql -U keycloak keycloak < $dbFolder/keycloak_backup.sql