#!/bin/bash

/usr/sbin/sshd -e

geth --datadir /root/.ethereum init ./genesis.json

if [[ -z $ADDITIONAL_PARAMS ]]; then
    additionalParams=()
else
    additionalParams+=($ADDITIONAL_PARAMS)
fi

additionalParams+=(--networkid 123456)

ipcpath=/root/.ethereum/geth.ipc

echo "additionalParams: ${additionalParams[@]}"
echo "ipcpath: ${ipcpath}"

/usr/local/bin/geth \
    --cache 3072 \
    --datadir /root/.ethereum \
    --syncmode light \
    --rpc \
    --rpccorsdomain "*" \
    --rpcapi "web3,eth,net,personal,admin" \
    --rpcport 50505 \
    --rpcaddr "0.0.0.0" \
    --ipcpath ${ipcpath} \
    --rpcvhosts=* \
    --verbosity 4 \
    --networkid 123456

