#!/usr/bin/env bash

# This script is used to backup the Directus database and uploads folder.
# It is intended to be run from the root of the Directus installation.
# It will create a backup folder in the home directory of the user running the script.
# The backup folder will be named "directus-backup-YYYY-MM-DD-HH-MM-SS".

sh ./export.sh

# Create a backup folder in the home directory of the user running the script.
BACKUP_FOLDER=~/directus-backup-$(date +%Y-%m-%d-%H-%M-%S)
mkdir $BACKUP_FOLDER

# Copy the exported files to the backup folder.
cp -r ./uploads/* $BACKUP_FOLDER
cp ./data/backup.sql $BACKUP_FOLDER/backup-$(date +%Y-%m-%d-%H-%M-%S).sql
