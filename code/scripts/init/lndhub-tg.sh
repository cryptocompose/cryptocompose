#!/bin/bash
echo lndhub-tg init started
cd "$base/code/dynamic_config"

crmongouser lndhub-tg $LNDHUBTG_DB_PWD

read -p "Telegram bot token: " bot_token

export BOT_TOKEN="$bot_token" LNDHUBTG_DB_PWD=$LNDHUBTG_DB_PWD
envsubst < ../config/lndhub-tg.env > lndhub-tg.env
unset BOT_TOKEN LNDHUBTG_DB_PWD

echo ''