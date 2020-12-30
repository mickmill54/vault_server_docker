# Start vault using docker-compose option -d "detach"
# mkdir -p $HOME/volumes/{config,file,logs}

# Start vault docker instance
docker-compose up -d
cp ./config/vault.json $HOME/volumes/config
sleep 10

# Vault init, if needed
./vault_init.sh

# Vault unseal
./unseal.sh

# Login with token
./vault_login.sh

# Run terraform 
cd terraform
terraform apply -auto-approve
terraform apply -auto-approve
