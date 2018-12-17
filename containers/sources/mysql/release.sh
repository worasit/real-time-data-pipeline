#!/usr/bin/env bash
source ../../settings.sh

echo "version: $VERSION"

git pull

docker build -t ${IMAGE_DB_NAME_WITH_LATEST} .
docker tag ${IMAGE_DB_NAME_WITH_LATEST} ${IMAGE_DB_NAME_WITH_VERSION}

docker push ${IMAGE_DB_NAME_WITH_LATEST}
docker push ${IMAGE_DB_NAME_WITH_VERSION}

git add -A
git commit -m "version $VERSION"
git tag -a "$VERSION" -m "version $VERSION"
git push
git push --tags

