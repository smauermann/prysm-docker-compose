# prysm-docker-compose

## Services
* beacon
* validator
* slasher

## Prepare your .env before running your node
Create a `.env` file in the same directory as your `docker-compose.yaml` with the following content:
```
IMAGE_VERSION_TAG=[prysm-version]
PUBLIC_IP=[your-public-ip4-address]
```

### prysm-version
This table gets updated every time a new release happens until prysm dev team adds a "stable" tag or something similar. https://github.com/prysmaticlabs/documentation/issues/103

Version | IMAGE_VERSION_TAG
--------|------------------
alpha.8 | HEAD-f831a7

### your-public-ip4-address
To gain a better connectivity for your beacon node you need to specifiy your public ip there and follow the guide [Improve Peer-to-Peer Connectivity](https://docs.prylabs.network/docs/prysm-usage/p2p-host-ip/).

## Validator accounts
Gain staking rewards by putting your validator account files in the directory `./validator`. See [Activating a Validator](https://docs.prylabs.network/docs/install/lin/activating-a-validator/) to guide you through the process of setting them up.

## Run your prysm Ethereum 2.0 staking node

### Start it up
Run with (as deamon with "-d")
```
docker-compose up -d
```
or run only certain services (in this case only beacon and validator)
```
docker-compose up -d beacon validator
```

### Stop it
Stop services (or everything) like this
```
docker-compose stop validator slasher
```

### Shut it down for good
Shut down your services (or everything) like this:
```
docker-compose down
```
Please note: This will also erase your logs, they are stored with your containers and will be deleted as well.

## Logging
Docker takes care of log files and log file rotation as well as limit (set to 10x100mb log files for each service).
View logs of a certain service (in this case beacon, only the last 100 lines)
```
docker-compose logs --tail=100 beacon
```