#!/usr/bin/env bash
docker rm -f mysql

docker run -d -t --name mysql \
        -p 3306:3306 -p 33060:33060 \
        -e MYSQL_ROOT_PASSWORD=password \
        gcr.io/poc-cdc/databases/sample.mysql:latest