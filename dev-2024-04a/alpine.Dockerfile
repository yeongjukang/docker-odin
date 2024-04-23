# build stage
FROM alpine:3.18.6 as builder
RUN apk add --no-cache clang14 llvm14-dev g++ \ 
        wget unzip bash libc6-compat git linux-headers
RUN ln -s /usr/bin/llvm14-config /usr/bin/llvm-config
RUN ln -s /usr/bin/clang-14 /usr/bin/clang
RUN ln -s /usr/bin/clang++-14 /usr/bin/clang++

RUN git clone https://github.com/odin-lang/Odin
WORKDIR /Odin
RUN git checkout dev-2024-04a
RUN bash build_odin.sh

# actual odin image
FROM alpine:3.18.6 as odin_alpine
RUN apk add clang14 g++
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