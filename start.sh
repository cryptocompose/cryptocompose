#!/bin/bash
cd "$(dirname "$0")"

# bitcoind builder
if [ "$(arch)" == aarch64 ]; then export TARGETPLATFORM=linux/arm64
elif [ "$(arch)" == x86_64 ];  then export TARGETPLATFORM=linux/amd64
fi

docker-compose -f code/docker-compose.yaml up -d