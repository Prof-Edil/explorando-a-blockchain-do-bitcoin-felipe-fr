# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

#!/bin/bash

RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"




XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"


INDEX=100


TAPROOT_DESCRIPTOR="tr(${XPUB}/${INDEX})"


DESCRIPTOR=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getdescriptorinfo "$TAPROOT_DESCRIPTOR" | jq -r '.descriptor')


TAPROOT_ADDRESS=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD deriveaddresses "$DESCRIPTOR" | jq -r '.[0]')


echo $TAPROOT_ADDRESS