#!/bin/bash
echo Mongodb init started...
cd "$base/code/dynamic_config"

export MONGODB_PWD=$MONGODB_ROOT_PWD
envsubst < ../config/mongodb.env > mongodb.env
unset MONGODB_PWD

echo ''