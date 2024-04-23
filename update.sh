#!/bin/bash
ALPINE_VERSION="3.18.6"
DEBIAN_VERSION="12.5"
ODIN_VERSION="dev-2024-04a"

mkdir -p $ODIN_VERSION

# generate Dockerfiles
sed \
  -e "s/\^ALPINE_VERSION/$ALPINE_VERSION/g" \
  -e "s/\^ODIN_VERSION/$ODIN_VERSION/g" \
  alpine.Dockerfile.template > $ODIN_VERSION/alpine.Dockerfile 
sed \
  -e "s/\^DEBIAN_VERSION/$DEBIAN_VERSION/g" \
  -e "s/\^ODIN_VERSION/$ODIN_VERSION/g" \
  debian.Dockerfile.template > $ODIN_VERSION/debian.Dockerfile

# alpine image build
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag yeongjukang/odin:alpine-$ODIN_VERSION \
  --tag yeongjukang/odin:alpine \
  --tag yeongjukang/odin:latest \
  --file $ODIN_VERSION/alpine.Dockerfile \
  --push .

# debian image build
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag yeongjukang/odin:debian-$ODIN_VERSION \
  --tag yeongjukang/odin:debian \
  --file $ODIN_VERSION/debian.Dockerfile \
  --push .

