#!/bin/bash
VERSION=${1:-latest}
export DOCKER_CLI_EXPERIMENTAL=enabled
docker manifest create --amend whatang/docker-pelican:${VERSION} whatang/docker-pelican:arm32v6-${VERSION} whatang/docker-pelican:amd64-${VERSION}
docker manifest annotate whatang/docker-pelican:latest whatang/docker-pelican:arm32v6-${VERSION} --arch arm
docker manifest push whatang/docker-pelican:${VERSION}
