#!/bin/bash
echo LndHub init started
cd $base/code/dynamic_config

read -p "Reserve fee, non-zero (0.01 is 1%): " reserve_fee
export RESERVE_FEE=$reserve_fee
read -p "Intra fee, non-zero: " intra_fee
export INTRA_FEE=$intra_fee

envsubst < ../config/lndhub.env > lndhub.env

echo ''