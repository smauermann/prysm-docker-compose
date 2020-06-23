#!/usr/bin/env bash

docker-compose -f create-account.yml run validator-create-account | tee -a deposit_data.txt
