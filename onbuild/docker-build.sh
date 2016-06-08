#!/bin/bash

pushd /app

docker build -t $(</args/DOCKER_IMAGE_REPOSITORY):$(</args/DOCKER_IMAGE_TAG) -f /args/Dockerfile .
