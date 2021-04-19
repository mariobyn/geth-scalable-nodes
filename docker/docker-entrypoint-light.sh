#!/bin/bash

/usr/sbin/sshd -e


if [[ -z $ADDITIONAL_PARAMS ]]; then
    additionalParams=()
else
    additionalParams+=($ADDITIONAL_PARAMS)
fi

additionalParams+=(--ropsten)

ipcpath=/root/.ethereum/geth.ipc

echo "additionalParams: ${additionalParams[@]}"
echo "ipcpath: ${ipcpath}"

/usr/local/bin/geth \
    --cache 3072 \
    --syncmode "light" \
    --http \
    --http.corsdomain "*" \
    --http.api "web3,eth,net,personal,admin" \
    --http.port 50505 \
    --http.addr "0.0.0.0" \
    --ipcpath ${ipcpath} \
    --http.vhosts=* \
    --verbosity 10 \
    "${additionalParams[@]}"

