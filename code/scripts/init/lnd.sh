#!/bin/bash
echo LND init started
cd $base/code

envsubst < config/lnd.conf > dynamic_config/lnd.conf

chbuild lnd:$LND_VERSION src/lnd "--build-arg checkout=$CORE_LND_VERSION"
chbuild lndinit:$LNDINIT_VERSION src/lndinit "--build-arg checkout=$CORE_LNDINIT_VERSION --build-arg BASE_IMAGE=lnd --build-arg BASE_IMAGE_VERSION=$LND_VERSION"

read -p "New seed (1), existing one(2) or skip(3)? " new_or_existing

if [ $new_or_existing == 1 ]; then
echo "===== SEED ====="
docker run --rm -v $base/data/lnd:/root/.lnd:rw --entrypoint /bin/bash lndinit:$LNDINIT_VERSION -c "
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
read -p "Mode: existing. Please input seed: " seed
docker run --rm -v $base/data/lnd:/root/.lnd:rw --entrypoint /bin/bash lndinit:$LNDINIT_VERSION -c "
  lndinit gen-password > /root/.lnd/wallet.password &&
  echo $seed > /root/.lnd/seed &&
  lndinit init-wallet \
    --secret-source=file \
    --file.seed=/root/.lnd/seed \
    --file.wallet-password=/root/.lnd/wallet.password \
    --init-file.output-wallet-dir=/root/.lnd/data/chain/bitcoin/mainnet && 
    rm /root/.lnd/seed"
fi

echo ''