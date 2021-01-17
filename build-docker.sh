#!/bin/bash

###
## How to run this:
## ./build-docker.sh will build image with the SHA of the git repo.
## ./build-docker.sh v1.0.0:
##    will build docker image with the SHA the git repo and the specified tag
##    do a git tag and push a tag on the specified semver

set -e
set -o pipefail

SEMVER_TAG="${1:-}"

SHA=$(git rev-parse HEAD)
SHA_IMAGE="roadtrippers/php-checks:${SHA}"

export DOCKER_BUILDKIT=1

docker build --tag "${SHA_IMAGE}" . --file Dockerfile
docker push "${SHA_IMAGE}"

if [[ -n "${SEMVER_TAG}" ]]; then
    SEMVER_IMAGE="roadtrippers/php-checks:${SEMVER_TAG}"
    git tag "${SEMVER_IMAGE}"
    git push origin "${SEMVER_IMAGE}"
    docker tag "${SHA_IMAGE}" "${SEMVER_IMAGE}"
    docker push "${SEMVER_IMAGE}"
fi
