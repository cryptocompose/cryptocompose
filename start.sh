#!/bin/bash
cd "$(dirname "$0")"

base=$(pwd)
scripts=$base/code/scripts

set -a
. $scripts/args.sh
set +a

docker-compose -f $base/code/docker-compose.yaml up -d