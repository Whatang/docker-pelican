#!/bin/bash
set -x
ARCH=${1:-arm32v6}
VERSION=${2:-latest}
docker build --build-arg IMAGE_TAG=whatang/docker-pelican:${ARCH}-${VERSION} -t whatang/docker-pelican:${ARCH}-${VERSION} .
