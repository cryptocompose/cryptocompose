#!/bin/bash
echo lndhub-tg init started
cd "$(dirname "$0")" && cd ../dynamic_config
. persistent.conf

function crmongouser() { #svc, pwd
  echo "db = db.getSiblingDB('$1');
  db.dropUser('$1');
  db.createUser({ user: '$1', pwd: '$2', roles: ['readWrite'] });" >> mongo-auth.js
}

crmongouser lndhub-tg $LNDHUBTG_DB_PWD

echo -n "Telegram bot token: "
read token
echo BOT_TOKEN=$token >> lndhub-tg.env
mongostr=mongodb://lndhub-tg:$LNDHUBTG_DB_PWD@mongodb:27017/lndhub-tg
echo SESSIONS_MONGO_URL=$mongostr >> lndhub-tg.env
echo MODEL_MONGO_URL=$mongostr >> lndhub-tg.env