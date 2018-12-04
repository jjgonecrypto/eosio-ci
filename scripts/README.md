# Scripts

1. `compile-contracts.sh` Starts a docker container to compile the given contract with `eosio-cpp`.

    Example:
    ```bash
    git clone git@github.com:EOSIO/eosio.contracts.git
    mkdir -p eosio.contracts/build
    compile-contracts.sh -c eosio.token \
    -s $(cd $(pwd)/eosio.contracts/eosio.token/src && pwd) \
    -o $(cd $(pwd)/eosio.contracts/build && pwd) \
    -i $(cd $(pwd)/eosio.contracts/eosio.token/include && pwd)
    ```s

1. `start-eos.sh` Start `nodeos` and `keosd` in a docker container on ports 7777 and 5555 respectively.

1. `stop-eos.sh` Stop those `nodeos` and `keosd` instances that were started (this also removes the containers from memory).
