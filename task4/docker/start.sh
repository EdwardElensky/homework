#!/bin/bash
app="docker.flask-app"
docker build -t ${app} .
docker run --rm -d -p 1080:1080 \
--name=${app} \
-v $PWD:/app ${app}
