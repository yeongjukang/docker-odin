#!/bin/sh
set -x

ALPINE_VERSION="3.16"
DEBIAN_VERSION="bullseye"
ODIN_VERSION="dev-2022-08"

mkdir -p $ODIN_VERSION/alpine
mkdir -p $ODIN_VERSION/debian

sed "s/\^ALPINE_VERSION/$ALPINE_VERSION/g" Dockerfile-alpine.template > $ODIN_VERSION/alpine/Dockerfile
sed "s/\^DEBIAN_VERSION/$DEBIAN_VERSION/g" Dockerfile-debian.template > $ODIN_VERSION/debian/Dockerfile
sed -i "s/\^ODIN_VERSION/$ODIN_VERSION/g" $ODIN_VERSION/alpine/Dockerfile
sed -i "s/\^ODIN_VERSION/$ODIN_VERSION/g" $ODIN_VERSION/debian/Dockerfile