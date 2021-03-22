### Scaling Light Geth clients to process multiple transactions using Full/Fast nodes as peers.

Dockerfiles for fast/light/full geth clients

StatefulSet file for full geth nodes used as peers for light clients

StatefulSet file for fast geth nodes that can be used as peers for light clients

Check the differences between `full` and `fast`:

- full sync downloads all blocks of the blockchain and replays all transactions that ever happened. While doing so, it stores the receipts of transactions and continuously updates the state database.

- fast sync does not replay transactions. Instead of processing the entire block-chain one link at a time, and replay all transactions that ever happened in history, fast syncing downloads the transaction receipts along the blocks, and pulls an entire recent state database.

Encrypted Keystore gp2 volume using AWS

Make sure you understand the geth parameters from [here]: https://geth.ethereum.org/docs/interface/command-line-options. Especially `--light.serv` and `--cache`

---
### Requirements

- `docker` installed

- `kubectl` installed and linked to your cluster (inside install.sh we use kubectl with default config file, if you use another config file maybe do a local alias `alias kubectl=kubectl --kubeconfig=...`
- `geth` namespace not created on your cluster. If it is and you can not delete it then comment first line in the install.sh (`kubectl create namespace geth`)

 
---
### Usage 

`chmod +x install.sh`

`./install.sh`

You can open as many Light clients as you want, and connect them to the full/fast clients for peering. Just follow the steps:

- Exec into the full/fast node and run `geth attach` then `admin.nodeInfo`. This will return a json where you need to get the value of `enode`. You also need to replace 127.0.0.1 with the pod IP of the full node, this can be enhanced by creating a service and just put the service dns instead of the ip. Full or Fast nodes are created via statefulsets so the ip won't change between restarts/upgrades. Be aware of the StatefulSet delete constraints.  
- Exec into the light node and run `geth attach` then `admin.addTrustedPeer(ENODE_VALUE_FROM_ABOVE)`  where ENODE_VALUE_FROM_ABOVE is the enode value you got from the full/fast node from the above step.
- To check if the node has been added to the peer list, run `admin.peers` and you should see the above node 

### Improvements
Helm implementation it will get rid of lots of hardcoded stuff
