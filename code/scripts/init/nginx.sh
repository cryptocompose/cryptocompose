#!/bin/bash
echo Nginx init started...
cd $base/code/dynamic_config

envsubst < ../config/nginx.conf > nginx.conf

echo ''