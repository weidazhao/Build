#!/bin/bash

cp /$(</tmp/project_name)/Dockerfile /app

cd /app

docker build -t $(</tmp/image_name) .
