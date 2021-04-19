#!/bin/bash

/usr/sbin/sshd -e


if [[ -z $ADDITIONAL_PARAMS ]]; then
    additionalParams=()
else
    additionalParams+=($ADDITIONAL_PARAMS)
fi

# use ropsten as testnet, delete this for main 
additionalParams+=(--ropsten)

ipcpath=/root/.ethereum/geth.ipc

echo "additionalParams: ${additionalParams[@]}"
echo "ipcpath: ${ipcpath}"

# set your --cache accordingly with your machine capacity. Check https://geth.ethereum.org/docs/interface/command-line-options
# also check --light.serve for better understanding how a geth node serves the light nodes 
/usr/local/bin/geth \
    --cache 3072 \
    --http \
    --http.corsdomain "*" \
    --http.api "web3,eth,net,personal,admin" \
    --http.port 50505 \
    --http.addr "0.0.0.0" \
    --ipcpath ${ipcpath} \
    --http.vhosts=* \
    --verbosity 5 \
    --light.serve 50 \
    "${additionalParams[@]}"

