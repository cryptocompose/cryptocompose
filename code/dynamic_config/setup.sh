#!/bin/bash
cd "$(dirname "$0")"

find . -type f ! -name setup.sh -delete

echo -n 'Domain: '
read domain
cp ../config/bitcoind.conf bitcoind.conf
echo externalip=$domain >> bitcoind.conf
cp ../config/lnd.conf lnd.conf
echo externalhosts=$domain >> lnd.conf
