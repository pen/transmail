#!/bin/zsh

docker buildx build \
    --platform linux/amd64 \
    -t transmail \
    --output type=docker,dest=transmail.tar \
    .
