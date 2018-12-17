#!/usr/bin/env bash
ROOT_PATH=gcr.io/poc-cdc
LATEST=latest
VERSION=`cat VERSION`

# ============= MySQL ==================
DB_NAME=databases/sample.mysql
IMAGE_DB_NAME=${ROOT_PATH}/${DB_NAME}
IMAGE_DB_NAME_WITH_LATEST=${IMAGE_DB_NAME}:${LATEST}
IMAGE_DB_NAME_WITH_VERSION=${IMAGE_DB_NAME}:${VERSION}
