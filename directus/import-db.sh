#!/bin/bash
# Description: Import database from host machine to docker container
# WARNING: This will overwrite the database in the container

# Variables
HOST="10.10.1.3"
PORT="5432"

# Function to check if PostgreSQL is running
check_postgres() {
    echo > /dev/tcp/$HOST/$PORT
    return $?
}

echo "Importing database from host machine to docker container..."

echo "Stopping docker containers..."
docker compose -f /home/www/compose.yml down

docker compose -f /home/www/compose.yml up -d db
echo "Starting db container..."

echo "Copying database from host machine to docker container..."
docker cp /home/www/backup.sql default-postgresql:/home/backup.sql

echo "Executing database import in docker container..."
docker exec default-postgresql bash -c "psql -U default directus_prod < /home/backup.sql"

echo "waiting for db to start..."

while ! check_postgres; do
    sleep 1
done

echo "PostgreSQL has started on $HOST:$PORT."

echo "Starting other containers..."
docker compose -f /home/www/compose.yml up -d

echo "Done!"
