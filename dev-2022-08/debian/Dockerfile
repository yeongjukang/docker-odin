# https://github.com/nodejs/docker-node/
# build stage
FROM debian:bullseye as builder
RUN apt-get update -y
RUN apt-get install -y \
        llvm-dev \
        clang \
        git 
RUN git clone https://github.com/odin-lang/Odin
WORKDIR /Odin
RUN git checkout dev-2022-08
RUN ./build_odin.sh

# actual odin image
FROM debian:bullseye as odin_debian
RUN apt-get update -y
RUN apt-get install clang -y
RUN mkdir /Odin
COPY --from=builder /Odin/vendor /Odin/vendor
COPY --from=builder /Odin/shared /Odin/shared
COPY --from=builder /Odin/odin /Odin/odin
COPY --from=builder /Odin/examples /Odin/examples
COPY --from=builder /Odin/core /Odin/core
ENV PATH $PATH:/Odin