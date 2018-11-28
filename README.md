# eosio-ci

[![](https://images.microbadger.com/badges/version/justinjmoses/eosio-ci.svg)](https://microbadger.com/images/justinjmoses/eosio-ci "Get your own version badge on microbadger.com")

Docker image and helper scripts for Docker container with EOS and EOSIO.CDT.

Built via

```bash
docker build --build-arg VCS_REF=`git rev-parse --short HEAD` -t justinjmoses/eosio-ci docker
```

Deployed images are in https://hub.docker.com/r/justinjmoses/eosio-ci/

Usage example is here: https://github.com/justinjmoses/eos-token-ci-example/blob/master/.circleci/config.yml

Coming soon... circle-ci integration.
