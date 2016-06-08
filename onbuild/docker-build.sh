#!/bin/bash

cp /$1/Dockerfile /app

cd /app

docker build -t $2 .
