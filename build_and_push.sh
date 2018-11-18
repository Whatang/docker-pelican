#!/bin/bash
ARCH=${1:-arm32v6}
VERSION=${2:-latest}
docker build -t whatang/docker-pelican:${ARCH}-${VERSION} .
docker push whatang/docker-pelican:${ARCH}-${VERSION}
