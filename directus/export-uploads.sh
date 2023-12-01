#!/bin/bash
# Description: Export uploads folder from docker container to host machine

rm -r ./uploads/

echo "Exporting uploads folder from docker container to host machine..."
docker cp Directus:/directus/uploads/ ./uploads/

echo "Done!"
