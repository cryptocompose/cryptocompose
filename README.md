# cryptocompose

**A set of scripts that allows to set up curated crypto services in a couple of commands. Created primarily for dev purposes.**

This repository contains scripts that will set up services in a strictly predefined way with chosen configuration. In order to change something you will have to edit the scripts. It does not create a new layer of abstraction, so that user is as close to the underlying software as possible.

> If you want more user-friendly and easily customizable solution, please see [Umbrel](https://umbrel.com).

### Includes:

* [bitcoind](https://github.com/bitcoin/bitcoin) (full node)
* [lnd](https://github.com/lightningnetwork/lnd)
* [lndhub](https://github.com/BlueWallet/LndHub)
* [lndhub-tg](https://github.com/yrzam/lndhub-tg)
* [nginx](https://github.com/nginxinc/docker-nginx)
* [mongodb](https://github.com/mongodb/mongo)
* [redis](https://github.com/redis/redis)
More coming soon...

### Requirements

* AMD64/ARM64
* Linux
* Enough storage for the full Bitcoin node
* Dedicated IP address. Static IP or domain recommended
* Accessible ports: `80`, `443`, `8333`, `9735`
* Docker, docker-compose, user in docker group

More coming soon...

### How to use
1. Clone
2. run `bash install.sh`, answer the questions
3. run `bash start.sh`
Use `bash stop.sh`, `bash backup.sh`, `bash restore-backup.sh` when needed

### Principles

* Minimal modification of the original code
* Balance between security and complexity
* Ease to customize or extend
* Ease to backup and migrate

### How it works

When you run `install.sh`:

1. Dynamic configuration is generated
2. Source repositories are downloaded or upgraded (some of them just point to binaries, todo improve)
3. Data is initialized (wallet seed, letsencrypt cert, etc.)

When you run `start.sh`

1. Docker images are build if needed
2. Docker-compose file is used to start all services