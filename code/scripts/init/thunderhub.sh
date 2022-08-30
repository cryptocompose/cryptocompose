#!/bin/bash
echo Thunderhub init started
cd "$base/code/dynamic_config"

envsubst < ../config/thunderhub.env > thunderhub.env

read -p "Thunderhub password: " thunderhub_pwd
export THUNDERHUB_PWD=$thunderhub_pwd
envsubst < ../config/thunderhub-accounts.yaml > thunderhub-accounts.yaml
unset THUNDERHUB_PWD

echo "# thunderhub
THUNDERHUB_BASE_PATH=$thunderhub_base_path" >> build-args.sh

echo ''