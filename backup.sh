#!/bin/bash
cd "$(dirname "$0")"

base="$(pwd)"
echo Stopping containers...
. stop.sh 2>/dev/null
cd "$base"

echo Creating backup...
sudo tar -czf backup.tar.gz \
  --exclude=data/bitcoind \
  --exclude=data/mongodb/journal \
  --exclude=data/mongodb/diagnostic.data \
  --exclude=data/.gitkeep \
  --exclude=dynamic_config/.gitkeep \
  data code/dynamic_config

echo Done
