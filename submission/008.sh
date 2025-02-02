# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`


RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"

TXID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
TX_JSON=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$TXID" 1)

if [ "$(echo "$TX_JSON" | jq -r '.vin[0].txinwitness')" != "null" ]; then
    witness=$(echo "$TX_JSON" | jq -r '.vin[0].txinwitness[2]')
    PUBKEY=${witness:4:66}
else
    INPUT0_ASM=$(echo "$TX_JSON" | jq -r '.vin[0].scriptSig.asm')
    PUBKEY=$(echo "$INPUT0_ASM" | awk '{print $2}')
fi

echo "The public key that signed input 0 is: $PUBKEY"