#!/bin/zsh

#LOCAL_UID=$(id -u)
#LOCAL_GID=$(id -g)
LOCAL_UID=1001
LOCAL_GID=1000

IMAGE="transmail"

DOCKER="docker"
if type finch &>/dev/null; then
    DOCKER="finch"
fi

$DOCKER build \
    --build-arg UID=$LOCAL_UID \
    --build-arg GID=$LOCAL_GID \
    -t $IMAGE \
    .
