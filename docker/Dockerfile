FROM ubuntu:18.04

ARG VCS_REF

LABEL author="Justin J. Moses <justinjmoses@gmail.com>" version=$version \
  description="This is a base image for CI tooling to test EOS smart contracts" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="e.g. https://github.com/justinjmoses/eosio-ci"

ARG version=1.4.4
ARG version_suffix=-1
ARG cdt_version=1.4.1

# prepare the package manager
RUN apt-get update
RUN apt-get install -y wget

# get requirements for EOS itself (libssl) and CircleCI (https://circleci.com/docs/2.0/custom-images/#required-tools-for-primary-containers)
RUN apt-get -y install openssl ca-certificates git ssh

# install EOS to get nodeos and keosd
ARG eosio_package=eosio_${version}${version_suffix}-ubuntu-18.04_amd64.deb
RUN wget https://github.com/eosio/eos/releases/download/v${version}/${eosio_package}
RUN apt-get install -y ./${eosio_package}

# install eosio.cdt to get the eosio-cpp compiler
ARG eosiocdt_package=eosio.cdt-${cdt_version}.x86_64.deb
RUN wget https://github.com/eosio/eosio.cdt/releases/download/v${cdt_version}/${eosiocdt_package}
RUN apt-get install -y ./${eosiocdt_package}

# copy local startup config files
COPY start-keosd.sh /start-keosd.sh
COPY start-nodeos.sh /start-nodeos.sh
