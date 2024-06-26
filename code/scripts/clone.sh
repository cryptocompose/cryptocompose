#!/bin/bash
echo -e "Clone started...\n"
cd "$base/code/src"

declare -A dirs=(
  [bitcoind]="https://github.com/lightninglabs/docker-bitcoin-core 03b8411631cb29c842ad4afb8546dd327f96899e"
  [lnd]="https://github.com/lightningnetwork/lnd 376b8cedc481a874d67d5bc38f63808737739d4c"
  [lndinit]="https://github.com/lightninglabs/lndinit a5fa79d685bfa2570714723e61b72d6e00397370"
  [lndhub]="https://github.com/cryptocompose/lndhub f0e2c873895dd2790ae2abb1041be7d6f520032d"
  [lndhub-tg]="https://github.com/cryptocompose/lndhub-tg 158a8a0aa4c18a83f6da4c3a1bd2d513058d374a"
  [thunderhub]="https://github.com/apotdevin/thunderhub 0a9ae34eb3b5b076c245c5fa866d9c24caba7a4d"
  [nginx]="https://github.com/nginxinc/docker-nginx a6f7d140744f8b15ff4314b8718b3f022efc7f43"
  [certbot]="https://github.com/certbot/certbot cb632c376f17dfd75306020a17248f3c33c1ab2f"
  [tor]="https://github.com/cryptocompose/docker-tor-meek 535c1fae86da444f876899dc67bba8b7986f58c1"
  [redis]="https://github.com/docker-library/redis 845fcda9ba00c3dbc6ab8cd4b7e0efaa7be411f2"
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

