#!/bin/bash
echo Certbot init started
cd $base

certbot_data_path=$(pwd)/data/certbot

if [ -d "$certbot_data_path" ]; then
  read -p "Existing cettificate found. Continue and replace certificate? (y/n) " decision
  if [ "$decision" != "y" ]; then
    return
  fi
fi

read -p "Email: " email

chbuild nginx:$NGINX_VERSION code/src/nginx
chbuild certbot:$CERTBOT_VERSION code/src/certbot

if [ ! -e "$certbot_data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$certbot_data_path/conf/ssl-dhparams.pem" ]; then
  echo Downloading recommended TLS parameters
  mkdir -p "$certbot_data_path/conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$certbot_data_path/conf/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$certbot_data_path/conf/ssl-dhparams.pem"
fi

certbot_volumes="-v $certbot_data_path/conf/:/etc/letsencrypt:rw -v $certbot_data_path/www:/var/www/certbot:rw"

echo Creating temp certificate
path="/etc/letsencrypt/live/$domain"
mkdir -p "$certbot_data_path/conf/live/$domain"
docker run $certbot_volumes --rm --entrypoint /bin/bash certbot:$CERTBOT_VERSION -c " \
  openssl req -x509 -nodes -newkey rsa:4096 -days 1 \
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'"

echo Starting nginx
envsubst < code/config/nginx-init-certbot.conf > code/dynamic_config/nginx-init-certbot.conf
docker run \
  -v $base/code/dynamic_config/nginx-init-certbot.conf:/etc/nginx/conf.d/default.conf:ro \
  -v $base/data/certbot/www:/var/www/certbot/:ro \
  -v $base/data/certbot/conf/:/etc/nginx/ssl/:ro \
  --name nginx-certbot -p 80:80 -d nginx:$NGINX_VERSION

docker run $certbot_volumes --rm --entrypoint /bin/bash certbot:$CERTBOT_VERSION -c " \
  rm -rf /etc/letsencrypt/live/$domain && \
  rm -rf /etc/letsencrypt/archive/$domain && \
  rm -rf /etc/letsencrypt/renewal/$domain.conf"

echo Requesting Lets Encrypt certificate...
docker run $certbot_volumes --rm --entrypoint /bin/bash certbot:$CERTBOT_VERSION -c " \
  certbot certonly --webroot -w /var/www/certbot \
    --email $email \
    -d $domain \
    --rsa-key-size 4096 \
    --agree-tos \
    --force-renewal"

echo Stopping nginx
docker stop nginx-certbot && docker rm nginx-certbot 
echo ''