#!/bin/bash

/usr/sbin/sshd -e


if [[ -z $ADDITIONAL_PARAMS ]]; then
    additionalParams=()
else
    additionalParams+=($ADDITIONAL_PARAMS)
fi

ipcpath=/root/.ethereum/geth.ipc

echo "additionalParams: ${additionalParams[@]}"
echo "ipcpath: ${ipcpath}"

/usr/local/bin/geth \
   --datadir "./db" \
   --networkid 123456 \
   --nodiscover \
   --rpc \
   --rpcport 50505 \
   --rpccorsdomain "*" \
   --port 30303 \
   --rpcapi="admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
   --light.serve 70 \
   "${additionalParams[@]}"

