#!/bin/bash

# Check if the environment file is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_env_file>"
  exit 1
fi

# Load environment variables from the specified file
ENV_FILE="$1"
if [ ! -f "$ENV_FILE" ]; then
  echo "Error: Environment file '$ENV_FILE' not found."
  exit 1
fi

# Extract the container name from the environment file name
CONTAINER_NAME=$(basename "$ENV_FILE" .env)

# Run the Docker container with the specified environment variables
docker run --name "$CONTAINER_NAME" -d --restart unless-stopped --env-file "$ENV_FILE" linuxshots/namecheap-ddns

# Check if the container started successfully
if [ $? -eq 0 ]; then
  echo "Docker container '$CONTAINER_NAME' started successfully."
else
  echo "Error: Failed to start Docker container '$CONTAINER_NAME'."
  exit 1
fi
