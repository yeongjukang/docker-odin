ARG DEBIAN_DOCKER_IMAGE_VERSION="latest"
ARG ODIN_VERSION="master"

FROM debian:$DEBIAN_DOCKER_IMAGE_VERSION

RUN apt-get update -y
RUN apt-get install wget git gnupg lsb-release software-properties-common -y \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://apt.llvm.org/llvm.sh
RUN chmod +x llvm.sh
RUN ./llvm.sh 18 all \
  && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/clang-18 /usr/bin/clang

RUN git clone https://github.com/odin-lang/Odin
WORKDIR /Odin
RUN git checkout $ODIN_VERSION
RUN ./build_odin.sh

RUN apt-get clean 

ENV PATH=$PATH:/Odin
ENV ODIN_ROOT=/Odin