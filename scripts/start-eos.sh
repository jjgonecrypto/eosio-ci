#!/bin/bash

set -eox pipefail

docker run \
  --rm \
  --publish 127.0.0.1:5555:5555 \
  --detach \
  justinjmoses/eosio-ci \
  /start-keosd.sh

docker run \
  --rm \
  --publish 7777:7777 \
  --detach \
  justinjmoses/eosio-ci \
  /start-nodeos.sh

# now lets wait for nodeos to be ready
set +e

exit_code=
while true
do
  curl http://localhost:7777/v1/chain/get_info | json_pp
  exit_code=$?
  if [[ $exit_code == 0 ]]
    then
  break
  fi
  echo "Waiting for nodeos to awake..."
  sleep 1
done
