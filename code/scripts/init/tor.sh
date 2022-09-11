#!/bin/bash
echo Tor init started
cd "$base/code/dynamic_config"

envsubst < ../config/torrc > torrc

read -p "Use meek bridge? (y/n) " decision
if [ "$decision" == "y" ]; then
  read -p "Bridge url: " meek_url
  echo "
UseBridges 1
ClientTransportPlugin meek exec /usr/bin/meek-client
Bridge meek 0.0.2.0:2 url=$meek_url
  " >> torrc
fi