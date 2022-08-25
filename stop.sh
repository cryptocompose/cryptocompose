#!/bin/bash
cd "$(dirname "$0")"

base=$(pwd)

set -a
. $base/code/scripts/args.sh
set +a

docker-compose -f $base/code/docker-compose.yaml down