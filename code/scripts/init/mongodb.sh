#!/bin/bash
echo Mongodb init started...
cd $base/code/dynamic_config

export MONGODB_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)
envsubst < ../config/mongodb.env > mongodb.env
unset MONGODB_PWD

echo ''