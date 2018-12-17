#!/usr/bin/env bash
source build.sh

git pull

# bump version
docker run --rm -v "$PWD":/app ${IMAGE_NAME_WITH_TAG} patch
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