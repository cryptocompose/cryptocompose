#!/bin/bash
cd "$(dirname "$0")"

# lnd wallet, password
lndtag=v0.15.0-beta
lndinittag=v0.1.4-beta

if [[ "$(docker images -q lnd:$lndtag 2> /dev/null)" == "" ]]; then
  echo 'lnd not build. Building...'
  docker build --build-arg checkout=$lndtag -t lnd:$lndtag ../src/lnd
fi
if [[ "$(docker images -q lndinit:$lndinittag 2> /dev/null)" == "" ]]; then
  echo 'lndinit not build. Building...'
  docker build --build-arg checkout=$lndinittag --build-arg BASE_IMAGE_VERSION=$lndtag -t lndinit:$lndinittag ../src/lndinit
fi

tmppath=$(pwd) && cd ../.. && datapath=$(pwd)/data && cd $tmppath

echo "New seed (1), existing one(2) or skip(3)?"
read new_or_existing

if [ $new_or_existing == 1 ]; then
echo "===== SEED ====="
docker run --rm -v $datapath/lnd:/root/.lnd:rw --entrypoint /bin/bash lndinit:$lndinittag -c "
  lndinit gen-password > /root/.lnd/wallet.password &&
  lndinit gen-seed > /root/.lnd/seed &&
  lndinit init-wallet \
    --secret-source=file \
    --file.seed=/root/.lnd/seed \
    --file.wallet-password=/root/.lnd/wallet.password \
    --init-file.output-wallet-dir=/root/.lnd/data/chain/bitcoin/mainnet &&
    cat /root/.lnd/seed && rm /root/.lnd/seed
  "
echo -e "\n================"
read -p "Press enter to continue"

elif [ $new_or_existing == 2 ]; then
echo -n 'Mode: existing. Please input seed: '
read seed
docker run --rm -v $datapath/lnd:/root/.lnd:rw --entrypoint /bin/bash lndinit:$lndinittag -c "
  lndinit gen-password > /root/.lnd/wallet.password &&
  echo $seed > /root/.lnd/seed &&
  lndinit init-wallet \
    --secret-source=file \
    --file.seed=/root/.lnd/seed \
    --file.wallet-password=/root/.lnd/wallet.password \
    --init-file.output-wallet-dir=/root/.lnd/data/chain/bitcoin/mainnet && 
    rm /root/.lnd/seed"
fi