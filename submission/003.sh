#!/bin/bash

RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"


BLOCK_TARGET=123456


BLOCK_HASH=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash $BLOCK_TARGET)

TXIDS=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock $BLOCK_HASH | jq -r '.tx[]')


TOTAL_OUTPUTS=0

for TXID in $TXIDS; do
  OUTPUT_COUNT=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction $TXID 1 | jq '.vout | length')
  TOTAL_OUTPUTS=$((TOTAL_OUTPUTS + OUTPUT_COUNT))
done


echo $TOTAL_OUTPUTS
