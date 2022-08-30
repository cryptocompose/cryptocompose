#!/bin/bash
echo Thunderhub init started
cd "$base/code/dynamic_config"

read -p "Thunderhub password: " thunderhub_pwd

export THUNDERHUB_PWD=$thunderhub_pwd
envsubst < ../config/thunderhub.env > thunderhub.env
unset THUNDERHUB_PWD

echo ''