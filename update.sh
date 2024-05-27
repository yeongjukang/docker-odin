#!/bin/bash
UBUNTU_VERISON="noble-20240429"
ODIN_VERSION="dev-2024-05"

mkdir -p $ODIN_VERSION

# generate Dockerfile
sed \
  -e "s/\^UBUNTU_VERISON/$UBUNTU_VERISON/g" \
  -e "s/\^ODIN_VERSION/$ODIN_VERSION/g" \
  ubuntu.Dockerfile.template > $ODIN_VERSION/ubuntu.Dockerfile

# ubuntu image build
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag yeongjukang/odin:$ODIN_VERSION \
  --tag yeongjukang/odin:latest \
  --file $ODIN_VERSION/ubuntu.Dockerfile \
  --push .

