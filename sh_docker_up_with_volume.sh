#!/bin/bash
VOLUME_NAMES=("mimic-iv"
             "mimic-iv-cxr"
             "mimic-iv-ed"
             "mimic-iv-note")

########################
# Function declaration #
########################
# Start all databases.
check_and_create_volumes(){
 local VOLUME_NAMES=("$@")
  for VOLUME_NAME in "${VOLUME_NAMES[@]}"
  do
    # Check if the volume exists
    if ! docker volume ls | grep -q "$VOLUME_NAME-volume"; then
      echo "Creating external volume: $VOLUME_NAME"
      docker volume create "$VOLUME_NAME-volume"
    else
      echo "Volume $VOLUME_NAME already exists."
    fi
  done
}

########################
#    Start database    #
########################
# Start postgres container for all ltc-apis.
check_and_create_volumes "${VOLUME_NAMES[@]}"

# Start Docker Compose services
docker-compose up -d

