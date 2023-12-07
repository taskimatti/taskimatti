#!/bin/bash
# Description: Export database from docker container to host machine

echo "Exporting database from docker container to host machine..."
docker exec taskimatti-PostgreSQL bash -c "pg_dump -U default -d directus_prod > /home/backup.sql"

echo "Copying database from docker container to host machine..."
docker cp taskimatti-PostgreSQL:/home/backup.sql data/backup.sql

echo "Done!"
