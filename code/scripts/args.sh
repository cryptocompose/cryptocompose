#!/bin/bash

. "$base/code/config/core-versions.conf"

if [ -f "$base/code/dynamic_config/versions.conf" ]; then
  . "$base/code/dynamic_config/versions.conf"
fi

if [ -f "$base/code/dynamic_config/build-args.sh" ]; then
  . "$base/code/dynamic_config/build-args.sh"
fi