#!/bin/bash
ALPINE_VERSION="3.18.6"
UBUNTU_VERISON="jammy"
ODIN_VERSION="dev-2024-04a"

mkdir -p $ODIN_VERSION

# generate Dockerfiles
sed \
  -e "s/\^ALPINE_VERSION/$ALPINE_VERSION/g" \
  -e "s/\^ODIN_VERSION/$ODIN_VERSION/g" \
  alpine.Dockerfile.template > $ODIN_VERSION/alpine.Dockerfile 
sed \
  -e "s/\^UBUNTU_VERISON/$UBUNTU_VERISON/g" \
  -e "s/\^ODIN_VERSION/$ODIN_VERSION/g" \
  ubuntu.Dockerfile.template > $ODIN_VERSION/ubuntu.Dockerfile

# alpine image build
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag yeongjukang/odin:alpine-$ALPINE_VERSION-$ODIN_VERSION \
  --tag yeongjukang/odin:alpine-$ODIN_VERSION \
  --tag yeongjukang/odin:alpine \
  --tag yeongjukang/odin:latest \
  --file $ODIN_VERSION/alpine.Dockerfile \
  --push .

# ubuntu image build
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag yeongjukang/odin:ubuntu-$UBUNTU_VERISON-$ODIN_VERSION \
  --tag yeongjukang/odin:ubuntu-$ODIN_VERSION \
  --tag yeongjukang/odin:ubuntu \
  --file $ODIN_VERSION/ubuntu.Dockerfile \
  --push .

