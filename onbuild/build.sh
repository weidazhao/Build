#!/bin/bash

docker build -t weidazhao/buildaspnetcore:onbuild .

docker push weidazhao/buildaspnetcore:onbuild