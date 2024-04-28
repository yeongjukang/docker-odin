# build stage
FROM ubuntu:jammy as builder
RUN apt-get update -y
RUN apt-get install -y \
        llvm-14-dev \
        clang-14 \
        git
RUN ln -s /usr/bin/clang-14 /usr/bin/clang
RUN ln -s /usr/bin/clang++-14 /usr/bin/clang++
RUN git clone https://github.com/odin-lang/Odin
WORKDIR /Odin
RUN git checkout dev-2024-04a
RUN ./build_odin.sh

# actual odin image
FROM ubuntu:jammy as odin_ubuntu
RUN apt-get update -y
RUN apt-get install clang-14 -y
RUN ln -s /usr/bin/clang-14 /usr/bin/clang
RUN mkdir /Odin
COPY --from=builder /Odin/vendor /Odin/vendor
COPY --from=builder /Odin/shared /Odin/shared
COPY --from=builder /Odin/odin /Odin/odin
COPY --from=builder /Odin/examples /Odin/examples
COPY --from=builder /Odin/core /Odin/core
COPY --from=builder /Odin/base /Odin/base

ENV PATH $PATH:/Odin
ENV ODIN_ROOT /Odin