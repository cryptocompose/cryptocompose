#!/bin/bash
cd "$(dirname "$0")"

base="$(pwd)"

set -ae
. "$base/code/scripts/args.sh"
set +ae

docker-compose -f "$base/code/docker-compose.yaml" up -d