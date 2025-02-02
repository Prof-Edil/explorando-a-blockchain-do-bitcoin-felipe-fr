#!/bin/bash
RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"

bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 654321
