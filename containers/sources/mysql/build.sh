#!/usr/bin/env bash
source ../../settings.sh

TAG=latest
DB_NAME=databases/sample.mysql
IMAGE_NAME=${ROOT_PATH}/${DB_NAME}
IMAGE_NAME_WITH_TAG=${IMAGE_NAME}:${TAG}

docker build -t ${IMAGE_NAME_WITH_TAG} .