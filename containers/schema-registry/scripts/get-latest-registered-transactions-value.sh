#!/usr/bin/env bash
curl --silent -X GET http://localhost:8081/subjects/transactions-value/versions/latest | jq .