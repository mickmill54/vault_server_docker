#!/bin/bash

# Start vault using docker-compose option -d "detach"
# mkdir -p $HOME/volumes/{config,file,logs}

# Start vault docker instance
docker-compose up -d
cp ./config/vault.json $HOME/volumes/config
sleep 10

unset VAULT_TOKEN
unset VAULT_ADDR
export VAULT_ADDR=http://localhost:8200

# Vault init, if needed
./vault_init.sh

# Vault unseal
./vault_unseal.sh

# Login with token
./vault_login.sh

# Run terraform 
cd terraform
terraform init
terraform apply -auto-approve
terraform apply -auto-approve
