#!/usr/bin/env bash

SERVICE=connect
COMMAND="start"

# Check if service is running
if [ -z "$(docker-compose ps -q $SERVICE)" ] \
     || docker ps -q --no-trunc | grep "$(docker-compose ps -q $SERVICE)"; then
  COMMAND="up -d"
fi

# Starting service
# shellcheck disable=SC2086
docker-compose \
  -f docker-compose.yml \
  -f docker-compose.production.yml \
  $COMMAND
