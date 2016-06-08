#!/bin/bash

cp /$(</args/DOCKERFILE_PATH) /app/Dockerfile

cd /app

docker build -t $(</args/DOCKER_IMAGE_REPOSITORY):$(</args/DOCKER_IMAGE_TAG) .
