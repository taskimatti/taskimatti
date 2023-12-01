#!/bin/bash
# Description: Import database from host machine to docker container
# WARNING: This will overwrite the database in the container

echo "Importing database from host machine to docker container..."

echo "Stopping docker containers..."
docker compose -f ../compose.yaml down

docker volume rm fuksipassi_directus_data_prod
echo "Removing old database volume..."

echo "Starting db container..."
docker compose -f ../compose.yaml up -d db
sleep 5
echo "PostgreSQL has started."

echo "Copying database from host machine to docker container..."
docker cp ./data/example.sql Fuksipassi-PostgreSQL:/home/import.sql

echo "Executing database import in docker container..."
docker exec Fuksipassi-PostgreSQL bash -c "psql -U default directus_prod < /home/import.sql"

echo "PostgreSQL has started on $HOST:$PORT."

echo "Starting other containers..."
docker compose -f ../compose.yaml up -d

echo "Done!"
