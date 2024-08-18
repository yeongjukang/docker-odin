#!/bin/bash
DEBIAN_DOCKER_IMAGE_VERSION="bookworm-slim"
ODIN_VERSION="dev-2024-08"

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg DEBIAN_DOCKER_IMAGE_VERSION=$DEBIAN_DOCKER_IMAGE_VERSION \
  --build-arg ODIN_VERSION=$ODIN_VERSION \
  --tag yeongjukang/odin:$ODIN_VERSION \
  --tag yeongjukang/odin:latest \
  --push .
