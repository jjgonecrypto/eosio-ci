#!/bin/bash

set -eo pipefail

contract=
source_path= # Use '$(cd $(pwd)/.. && pwd)' for example to pass the full path of the parent directory
output_path=
include_path=
include_statement=

while getopts ":hs:c:o:i:" opt; do
  case ${opt} in
    c )
      contract=$OPTARG
      ;;
    s )
      source_path=$OPTARG
      ;;
    o )
      output_path=$OPTARG
      ;;
    i )
      include_path=$OPTARG
      include_statement="-I $include_path"
      ;;
    h )
      cat << EOF
Compile EOS contract using eosio-cpp on docker.

OPTIONS:
    -c      Name of the contract
    -s      Source path - folder of the source code.
    -o      Output path - folder to put the WASM and ABI
    -i      Include path, if any
    -h      Show this message

EOF
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
    * )
      echo "- Invalid option $OPTARG" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

function generate_mount() {
  echo "--mount type=bind,source=$1,destination=$1"
}

source_mount=$(generate_mount "$source_path")

output_mount=
if [[ $source_path != "$output_path" ]]
  then output_mount=$(generate_mount "$output_path")
fi

include_mount=
if [[ ! -z $include_path ]]
  then include_mount=$(generate_mount "$include_path")
fi

COMPILER_COMMAND="eosio-cpp $source_path/$contract.cpp \
  -o $output_path/$contract.wasm \
  --abigen \
  -contract=$contract \
  $include_statement"

echo "Attempting to run the following on docker:"
echo "$COMPILER_COMMAND"

# Note below: duping the dirname call to prevent issues with bash escaping spaces in the source path
docker run \
--rm \
$source_mount \
$output_mount \
$include_mount \
 justinjmoses/eosio-ci \
 /bin/bash -c "$COMPILER_COMMAND"
