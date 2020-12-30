# Login to vault with new token
vault login $(cat ./vault_init.out | jq -r .root_token)
