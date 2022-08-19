# cryptocompose

**A set of scripts that allows to set up curated crypto services in a couple of commands.**

This repository contains scripts that will set up services in a strictly predefined way with chosen configuration. In order to change something you will have to edit the scripts. Moreover, it does not create a new layer of abstraction, so that user is as close to the underlying software as possible.

> If you want more user-friendly and easily customizable solution, please see [Umbrel](https://umbrel.com).


### Includes:

* [bitcoind](https://github.com/bitcoin/bitcoin) (full node)
* [lnd](https://github.com/lightningnetwork/lnd)
* [lndhub](https://github.com/BlueWallet/LndHub)
* [lndhub-tg](https://github.com/yrzam/lndhub-tg)
* [torproxy](https://github.com/dperson/torproxy)
* [nginx](https://github.com/nginxinc/docker-nginx)


### Principles

* Minimal modification of the original code
* Minimal trust
* Ease to customize or extend


### How it works

When you run `install.sh`:

1. Dynamic configuration is generated
2. Source repositories are downloaded (some of them just point to binaries, todo improve)
3. Data is inited (wallet seed, etc.)

When you run `start.sh`

1. Docker images are build if needed
2. Docker-compose file is used to start all services