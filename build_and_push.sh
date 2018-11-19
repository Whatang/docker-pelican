#!/bin/bash
ARCH=${1:-arm32v6}
VERSION=${2:-latest}
./build.sh ${ARCH} ${VERSION}
docker push whatang/docker-pelican:${ARCH}-${VERSION}
