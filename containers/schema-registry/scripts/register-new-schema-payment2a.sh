#!/usr/bin/env bash
curl -X POST \
    -H "Content-Type: application/vnd.schemaregistry.v1+json" \
    http://localhost:8081/subjects/transactions-value/versions \
    --data '{"schema": "{\"type\":\"record\",\"name\":\"Payment\",\"namespace\":\"com.nongped.poc.avro\",\"fields\":[{\"name\":\"id\",\"type\":\"string\"},{\"name\":\"amount\",\"type\":\"double\"},{\"name\":\"region\",\"type\":\"string\"}]}"}'