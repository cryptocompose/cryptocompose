#!/bin/bash
echo -e "Clone started...\n"
cd "$base/code/src"

declare -A dirs=(
  [bitcoind]="https://github.com/ruimarinho/docker-bitcoin-core ba147b689b9a78c60cf7d9fd5b20d8dfd2407e30"
  [lnd]="https://github.com/lightningnetwork/lnd 909ba573ea49387171c143cb8c6759bc54fc82e4"
  [lndinit]="https://github.com/lightninglabs/lndinit 67e363ea8ab562609017f6946b2832c380c811e2"
  [lndhub]="https://github.com/yrzam/lndhub f0e2c873895dd2790ae2abb1041be7d6f520032d"
  [lndhub-tg]="https://github.com/yrzam/lndhub-tg dab3f6e93ee682c145326a2f1a03efd5e4c756c5"
  [nginx]="https://github.com/nginxinc/docker-nginx f3d86e99ba2db5d9918ede7b094fcad7b9128cd8"
  [certbot]="https://github.com/certbot/certbot cb632c376f17dfd75306020a17248f3c33c1ab2f"
  [redis]="https://github.com/docker-library/redis 5c0bbb5dfce3d4999649cbc3ba8bf7c123bcadff"
  [mongodb]="https://github.com/docker-library/mongo 52c402d3744a806411b65e5fc843c65a87d8012c"
)

function copysubd() {
  mkdir ../tmp && mv * ../tmp && mv ../tmp/$1/* . && rm -rf ../tmp
}

function custom() {
  case $1 in
  
  "bitcoind")
    copysubd $CORE_BITCOIND_VERSION
  ;;

  "nginx")
    copysubd $CORE_NGINX_VERSION
  ;;

  "redis")
    copysubd $CORE_REDIS_VERSION
  ;;

  "mongodb")
    copysubd $CORE_MONGODB_VERSION
  ;;
  
  esac
}

if [ -f ../dynamic_config/versions.conf ]; then
  rm ../dynamic_config/versions.conf
fi

for dir in "${!dirs[@]}"; do 

  repo_hash=(${dirs[$dir]});
  repo=${repo_hash[0]};
  hash=${repo_hash[1]};

  verkey=$(echo $dir | tr - _ | tr '[:lower:]' '[:upper:]')_VERSION
  ver=$(echo $hash | cut -c1-8)
  crverkey=CORE_$verkey
  crver=$(echo ${!crverkey} | tr / -)
  if [ ! -z "$crver" ]; then 
    ver="$ver"_"$crver" 
  fi
  echo $verkey=$ver >> ../dynamic_config/versions.conf

  if [ -d $dir ]; then

    echo Directory $dir already exists, has version changed?
    echo Current $ver, prev ${!verkey}
    if [ $ver != "${!verkey}" ]; then
      echo Yes, cloning again
      rm -rf $dir
    else
      echo -e "No, skipping\n"
      continue;
    fi

  fi

  echo Processing new $dir
  git clone $repo $dir -q
  cd $dir
  git checkout $hash -q
  custom $dir
  cd ..
  echo ''

done

