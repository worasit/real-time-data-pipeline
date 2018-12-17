#!/usr/bin/env bash
git pull

# bump version
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