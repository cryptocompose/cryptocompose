#!/bin/bash
echo Generic init started...
cd "$(dirname "$0")" && cd ../dynamic_config
rm -rf *

echo -n 'Domain: '
read domain
cp ../config/bitcoind.conf bitcoind.conf
echo externalip=$domain >> bitcoind.conf
cp ../config/lnd.conf lnd.conf
echo externalhosts=$domain >> lnd.conf