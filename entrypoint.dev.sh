#!/bin/bash

COMPOSE_FILE="compose-dev.yaml"

# Check if a command is provided as an argument
if [ "$#" -eq 0 ]; then
  # Run Docker Compose in development mode.
  docker compose -f "$COMPOSE_FILE" watch
  # Trap the EXIT and INT signals and execute the cleanup and update function
  trap cleanup_and_update EXIT INT
fi

# Validate that the provided command is "build"
if [ "$1" == "build" ]; then
  echo "Building fresh image..."
  docker compose -f "$COMPOSE_FILE" build --no-cache
  echo "Running container in develop mode..."
  docker compose -f "$COMPOSE_FILE" watch
  # Trap the EXIT and INT signals and execute the cleanup and update function
  trap cleanup_and_update EXIT INT
else
  echo "Only 'build' command is allowed."
fi

# Function to be executed on exit or interrupt
cleanup_and_update() {
  echo "Running cleanup command..."
  docker compose -f "$COMPOSE_FILE" down
  echo "Updating Docker image..."
  docker compose -f "$COMPOSE_FILE" build --no-cache
  echo "Script completed cleanup."
}

# Exiting the script
exit 0
