#!/bin/bash
echo Clone started...
cd "$(dirname "$0")" && cd ../src

declare -A dirs=(
  [bitcoind]="https://github.com/ruimarinho/docker-bitcoin-core ba147b689b9a78c60cf7d9fd5b20d8dfd2407e30"
  [lnd]="https://github.com/lightningnetwork/lnd 909ba573ea49387171c143cb8c6759bc54fc82e4"
  [lndinit]="https://github.com/lightninglabs/lndinit 67e363ea8ab562609017f6946b2832c380c811e2"
)

function custom() {
  case $1 in
  
  "bitcoind")
    mkdir ../tmp && mv * ../tmp && mv ../tmp/23/* . && rm -rf ../tmp
  ;;
  
  esac
}

for dir in "${!dirs[@]}"; do 
  if [ -d $dir ]; then
    echo Directory $dir already exists, skipping
    continue
  fi
    echo Processing $dir
    repo_hash=(${dirs[$dir]});
    repo=${repo_hash[0]};
    hash=${repo_hash[1]};
    echo hash $hash
    git clone $repo $dir
    cd $dir
    git checkout $hash
    custom $dir
    cd ..
done