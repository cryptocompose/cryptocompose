#!/bin/bash
cd "$(dirname "$0")"

base="$(pwd)"
echo Stopping containers...
. stop.sh 2>/dev/null
cd "$base"

if [ ! -f backup.tar.gz ]; then
  echo No backup found.
  exit
fi
read -p "This will delete all existing data. Continue? (y/n) " do_wipe
if [ "$do_wipe" != "y" ]; then
  echo Cancelled.
  exit
fi

echo Removing existing data...
sudo find data -maxdepth 1 ! -name bitcoind ! -name data -type d -exec rm -rf {} +
rm -rf code/dynamic_config/*

echo Unpacking archive...
sudo tar -xf backup.tar.gz data code/dynamic_config

read -p "Did versions change? (y/n) " do_clone_again
if [ "$do_clone_again" == "y" ]; then
  rm -rf code/src/*
  . code/scripts/clone.sh
  cd "$base"
fi

echo Done
