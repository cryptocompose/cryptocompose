#!/bin/bash
echo Nginx init started...
cd "$base/code/dynamic_config"

envsubst '${DOMAIN} ${LNDHUB_BASE_PATH} ${THUNDERHUB_BASE_PATH}' < ../config/nginx.conf > nginx.conf

echo ''