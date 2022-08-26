#!/bin/bash
cd "$(dirname "$0")"

base=$(pwd)
echo Stopping containers...
. stop.sh 2>/dev/null
cd $base/data

if [ ! -f ../backup.tar.gz ]; then
  echo No backup found.
  exit
fi
read -p "This will delete all existing data. Continue? (y/n) " decision
if [ "$decision" != "y" ]; then
  echo Cancelled.
  exit
fi

echo Removing existing data...
sudo find . -maxdepth 1 ! -name bitcoind -type d -not -path '.' -exec rm -rf {} +

#echo Unpacking archive...
#sudo tar -xf ../backup.tar --strip-components=1