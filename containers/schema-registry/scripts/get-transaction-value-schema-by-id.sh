#!/usr/bin/env bash
VERSION=1
if [[ -z "$1" ]]
   then echo "version argument is empty, default is 1 ✅"
else
    VERSION=$1
    echo "version is set to $1 ✅"
fi

curl --silent -X GET http://localhost:8081/subjects/transactions-value/versions/${VERSION}/schema | jq .