#!/bin/bash
cd "$(dirname "$0")"

base=$(pwd)
echo Stopping containers...
. stop.sh 2>/dev/null
cd $base

echo Creating backup...
mkdir data/dynamic_config && cp code/dynamic_config/* data/dynamic_config
sudo tar -czf backup.tar.gz \
  --exclude=data/bitcoind \
  --exclude=data/mongodb/journal \
  --exclude=data/mongodb/diagnostic.data \
  --exclude=data/.gitkeep \
  data
rm -rf data/dynamic_config

echo Done
