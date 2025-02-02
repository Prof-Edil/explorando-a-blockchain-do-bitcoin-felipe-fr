# Which tx in block 257,343 spends the coinbase output of block 256,128?

RPC_USER="user_221"
RPC_PASSWORD="e0JwYMztCoZK"
RPC_HOST="84.247.182.145"


BLOCK256128_HASH=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 256128)
COINBASE_TXID=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock "$BLOCK256128_HASH" | jq -r '.tx[0]')



BLOCK257343_HASH=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblockhash 257343)
BLOCK257343_JSON=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getblock "$BLOCK257343_HASH")
TXIDS=$(echo "$BLOCK257343_JSON" | jq -r '.tx[]')


for tx in $TXIDS; do
    if [ "$tx" == "$(echo "$BLOCK257343_JSON" | jq -r '.tx[0]')" ]; then
        continue
    fi

    TX_JSON=$(bitcoin-cli -rpcconnect=$RPC_HOST -rpcuser=$RPC_USER -rpcpassword=$RPC_PASSWORD getrawtransaction "$tx" 1)
    
    MATCH=$(echo "$TX_JSON" | jq --arg coinbase "$COINBASE_TXID" '[.vin[] | select(.txid == $coinbase)] | length')
    
    if [ "$MATCH" -gt 0 ]; then
        echo "A transação que gasta a saída coinbase do bloco 256128 é: $tx"
        exit 0
    fi
done

