#!/bin/zsh

LINUX_UID=10001
LINUX_GID=10000
IMAGE="transmail"

DOCKER_BUILDX="docker buildx"
if type finch &>/dev/null; then
    DOCKER_BUILDX="finch"
fi

$DOCKER_BUILDX build \
    --platform linux/amd64 \
    --build-arg UID=$LINUX_UID \
    --build-arg GID=$LINUX_GID \
    -t $IMAGE \
    --output type=docker,dest=$IMAGE.tar \
    .
