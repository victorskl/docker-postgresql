#!/usr/bin/env bash

docker rm dev_postgres_1
docker rmi dev_postgres
docker-compose -f docker-compose.yaml -f development.yaml --project-name=dev build
