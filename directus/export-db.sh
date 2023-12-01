#!/bin/bash
# Description: Export database from docker container to host machine

echo "Exporting database from docker container to host machine..."
docker exec default-postgresql bash -c "pg_dump -U default -d directus_prod > /home/backup.sql"

echo "Copying database from docker container to host machine..."
docker cp default-postgresql:/home/backup.sql /home/www/backup.sql

echo "Done!"
