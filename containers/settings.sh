#!/usr/bin/env bash

# ===================== Utilities =========================
# Usage: increment_version <version> [<position>]
increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
    len=${#part[CNTR]}
    new=$((part[CNTR]+carry))
    [ ${#new} -gt $len ] && carry=1 || carry=0
    [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo -e "${new// /.}"
}



ROOT_PATH=gcr.io/poc-cdc
LATEST=latest
VERSION=`increment_version $(cat VERSION)`
${VERSION} > VERSION
DB_NAME=databases/sample.mysql
IMAGE_DB_NAME=${ROOT_PATH}/${DB_NAME}
IMAGE_DB_NAME_WITH_LATEST=${IMAGE_DB_NAME}:${LATEST}
IMAGE_DB_NAME_WITH_VERSION=${IMAGE_DB_NAME}:${VERSION}


