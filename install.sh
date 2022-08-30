#!/bin/bash
cd "$(dirname "$0")"

base="$(pwd)"
scripts="$base/code/scripts"

set -e

. "$scripts/args.sh"
. "$scripts/clone.sh"
. "$scripts/init/base.sh"
. "$scripts/init/bitcoind.sh"
. "$scripts/init/lnd.sh"
. "$scripts/init/lndhub.sh"
. "$scripts/init/lndhub-tg.sh"
. "$scripts/init/thunderhub.sh"
. "$scripts/init/nginx.sh"
. "$scripts/init/certbot.sh"
. "$scripts/init/mongodb.sh"

set +e