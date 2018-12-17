#!/usr/bin/env bash
git pull

# bump version
docker run --rm -v "$PWD":/app gcr.io/poc-cdc/databases/sample.mysql:latest patch
version=`cat VERSION`
echo "version: $version"

# run build
bash build.sh

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags