#!/bin/bash
# Description: Import uploads folder from host machine to docker container

echo "Importing uploads folder from host machine to docker container..."
docker cp ./uploads/ Directus:/directus/

echo "Done!"
