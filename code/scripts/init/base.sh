#!/bin/bash
echo Base init started...
cd "$base/code/dynamic_config"

find . ! -name persistent.conf ! -name .gitkeep ! -name versions.conf -type f -delete

echo Important: please make the following ports accessible:
echo 80, 443, 8333, 9735
read -p "Press enter to continue"

read -p "Domain: " domain
export DOMAIN=$domain

read -p "LndHub url path (no trailing slash): /" LNDHUB_BASE_PATH
LNDHUB_BASE_PATH=/$LNDHUB_BASE_PATH
export LNDHUB_BASE_PATH=$LNDHUB_BASE_PATH

# gen persistent
if [ ! -f persistent.conf ]; then
    echo LNDHUBTG_DB_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) >> persistent.conf
    echo MONGODB_ROOT_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) >> persistent.conf
fi

. ../scripts/args.sh
. persistent.conf

function crmongouser() { #svc, pwd
  echo "db = db.getSiblingDB('$1');
  db.dropUser('$1');
  db.createUser({ user: '$1', pwd: '$2', roles: ['readWrite'] });" >> mongo-auth.js
}

function chbuild() { #image, src extra args
if [[ "$(docker images -q $1 2> /dev/null)" == "" ]]; then
  echo $1 not build. Building...
  docker build $3 -t $1 $2
fi
}

echo ''