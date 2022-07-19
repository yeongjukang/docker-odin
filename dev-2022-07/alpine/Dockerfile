# build stage
FROM alpine:3.16 as builder
RUN apk add --no-cache clang llvm-dev g++ \ 
        wget unzip bash libc6-compat git 
RUN git clone https://github.com/odin-lang/Odin
WORKDIR /Odin
RUN git checkout dev-2022-07
RUN bash build_odin.sh

# actual odin image
FROM alpine:3.16 as odin_alpine
RUN apk add clang g++
RUN mkdir /Odin
COPY --from=builder /Odin/vendor /Odin/vendor
COPY --from=builder /Odin/shared /Odin/shared
COPY --from=builder /Odin/odin /Odin/odin
COPY --from=builder /Odin/examples /Odin/examples
COPY --from=builder /Odin/core /Odin/core
ENV PATH $PATH:/Odin