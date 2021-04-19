#!/bin/bash

/usr/sbin/sshd -e


if [[ -z $ADDITIONAL_PARAMS ]]; then
    additionalParams=()
else
    additionalParams+=($ADDITIONAL_PARAMS)
fi

additionalParams+=(--rinkeby)

ipcpath=/root/.ethereum/geth.ipc

echo "additionalParams: ${additionalParams[@]}"
echo "ipcpath: ${ipcpath}"

/usr/local/bin/geth \
    --cache 3072 \
    --syncmode fast \
    --rpc \
    --rpccorsdomain "*" \
    --rpcapi "web3,eth,net,personal,admin" \
    --rpcport 50505 \
    --rpcaddr "0.0.0.0" \
    --ipcpath ${ipcpath} \
    --rpcvhosts=* \
    --verbosity 5 \
    --light.serve 70 \
    "${additionalParams[@]}"

