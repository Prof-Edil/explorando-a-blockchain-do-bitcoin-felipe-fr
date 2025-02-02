# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"


TXID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"


TX_JSON=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$TXID" 1)


PUBKEY1=$(echo "$TX_JSON" | jq -r '.vin[0].txinwitness[1]')
PUBKEY2=$(echo "$TX_JSON" | jq -r '.vin[1].txinwitness[1]')
PUBKEY3=$(echo "$TX_JSON" | jq -r '.vin[2].txinwitness[1]')
PUBKEY4=$(echo "$TX_JSON" | jq -r '.vin[3].txinwitness[1]')




MULTISIG_JSON=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD createmultisig 1 '["'"$PUBKEY1"'","'"$PUBKEY2"'","'"$PUBKEY3"'","'"$PUBKEY4"'"]' "legacy")


MULTISIG_ADDRESS=$(echo "$MULTISIG_JSON" | jq -r '.address')

echo "$MULTISIG_ADDRESS"