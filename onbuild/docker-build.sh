#!/bin/bash

cp /$(</tmp/project_name)/Dockerfile /app

cd /app

docker rmi -f $(</tmp/image_name)

docker build -t $(</tmp/image_name) .
