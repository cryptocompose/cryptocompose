#!/bin/bash
echo Base init started...
cd "$(dirname "$0")" && cd ../dynamic_config

find . ! -name persistent.conf ! -name .gitkeep -type f -delete

echo -n 'Domain: '
read domain
cp ../config/bitcoind.conf bitcoind.conf
echo externalip=$domain >> bitcoind.conf
cp ../config/lnd.conf lnd.conf
echo externalhosts=$domain >> lnd.conf
echo DEFAULT_HUB_URL=https://$domain/ln/hub > lndhub-tg.env

# gen persistent
if [ ! -f persistent.conf ]; then
    echo LNDHUBTG_DB_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16) >> persistent.conf
fi