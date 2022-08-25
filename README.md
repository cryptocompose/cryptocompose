# cryptocompose

**A set of scripts that allows to set up curated crypto services in a couple of commands. Created primarily for dev purposes**

This repository contains scripts that will set up services in a strictly predefined way with chosen configuration. In order to change something you will have to edit the scripts. It does not create a new layer of abstraction, so that user is as close to the underlying software as possible.

> If you want more user-friendly and easily customizable solution, please see [Umbrel](https://umbrel.com).


### Includes:

* [bitcoind](https://github.com/bitcoin/bitcoin) (full node)
* [lnd](https://github.com/lightningnetwork/lnd)
* [lndhub](https://github.com/BlueWallet/LndHub)
* [lndhub-tg](https://github.com/yrzam/lndhub-tg)
* [torproxy](https://github.com/dperson/torproxy)
* [nginx](https://github.com/nginxinc/docker-nginx)
* [mongodb](https://github.com/mongodb/mongo)

### Requirements

* AMD64/ARM64
* Linux
* Enough storage for the full Bitcoin node
* Dedicated IP address. Static IP or domain recommended
* Docker, docker-compose, user in docker group

### Principles

* Minimal modification of the original code
* Balance between security and complexity
* Ease to customize, extend and backup
* Ease to backup

### How it works

When you run `install.sh`:

1. Dynamic configuration is generated
2. Source repositories are downloaded or upgraded (some of them just point to binaries, todo improve)
3. Data is initialized (wallet seed, etc.)

When you run `start.sh`

1. Docker images are build if needed
2. Docker-compose file is used to start all services