#!/bin/bash
echo Mongodb init started...
cd "$(dirname "$0")" && cd ../dynamic_config

echo MONGO_INITDB_ROOT_USERNAME=admin >> mongodb.env
echo MONGO_INITDB_ROOT_PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) >> mongodb.env