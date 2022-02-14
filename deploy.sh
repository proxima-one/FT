#!/bin/bash

TOKEN_NAME=Proxima
TOKEN_SYMBOL=PXT
DECIMALS=8

case $1 in
dev)
    echo "Deploying to Dev Account"
    near dev-deploy --wasmFile res/fungible_token.wasm --helperUrl https://near-contract-helper.onrender.com
    source neardev/dev-account.env
    echo $CONTRACT_NAME
    near call $CONTRACT_NAME new '{"owner_id": "'$CONTRACT_NAME'", "total_supply": "1000000000000000", "metadata": { "spec": "ft-1.0.0", "name": "'$TOKEN_NAME'", "symbol": "'$TOKEN_SYMBOL'", "decimals": '$DECIMALS' }}' --accountId $CONTRACT_NAME
    near view $CONTRACT_NAME ft_metadata
    ;;
testnet)
    echo "Deploying to Testnet"
    export NEAR_ENV=testnet
    near login
    near deploy --wasmFile res/fungible_token.wasm --accountId $ID
    near call $ID new '{"owner_id": "'$ID'", "total_supply": "1000000000000000", "metadata": { "spec": "ft-1.0.0", "name": "'$TOKEN_NAME'", "symbol": "'$TOKEN_SYMBOL'", "decimals": '$DECIMALS' }}' --accountId $ID
    near view $ID ft_metadata
    ;;
mainnet)
    echo "Deploying to Mainnet"
    export NEAR_ENV=mainnet
    near login
    near deploy --wasmFile res/fungible_token.wasm --accountId $ID
    near call $ID new '{"owner_id": "'$ID'", "total_supply": "1000000000000000", "metadata": { "spec": "ft-1.0.0", "name": "'$TOKEN_NAME'", "symbol": "'$TOKEN_SYMBOL'", "decimals": '$DECIMALS' }}' --accountId $ID
    near view $ID ft_metadata
    ;;
*)
 echo "No Specificications"
 ;;
esac