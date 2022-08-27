#!/bin/bash
echo Bitcoind init started...
cd "$base/code/dynamic_config"

envsubst < ../config/bitcoind.conf > bitcoind.conf

echo '# bitcoind
if [ "$(arch)" == aarch64 ]; then TARGETPLATFORM=linux/arm64
elif [ "$(arch)" == x86_64 ];  then TARGETPLATFORM=linux/amd64
fi' >> build-args.sh

echo ''