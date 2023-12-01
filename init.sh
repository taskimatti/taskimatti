#!/bin/bash

# Change the following variables to match your repository
REPO_URL="$1"
REPO_DIR="$2"

# Check if the repository exists
if [ -d "$REPO_DIR" ]; then
  # If it does, pull the latest changes
  cd "$REPO_DIR"
  git pull
else
  # If it doesn't, clone the repository
  git clone "$REPO_URL" "$REPO_DIR"
fi
