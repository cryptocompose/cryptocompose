#!/bin/bash
cd "$(dirname "$0")"

base=$(pwd)
echo Stopping containers...
. stop.sh 2>/dev/null
cd $base

echo Creating backup...
cp -r code/dynamic_config data/dynamic_config && rm data/dynamic_config/.gitkeep
sudo tar -czf backup.tar.gz \
  --exclude=data/bitcoind \
  --exclude=data/mongodb/journal \
  --exclude=data/mongodb/diagnostic.data \
  --exclude=data/.gitkeep \
  data
rm -rf data/dynamic_config

echo Done
