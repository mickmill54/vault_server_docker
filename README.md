# my_vault_server_docker
### vault in docker for testing vault_migrator, vault_renamer, and vault_deleter

*Note*: This project start becuase I wanted to have a local instance of vault to test a few vault utilities.  The second goal was to see if I could automate as much of the install as possible.

This is all done in bash and terraform.  

| script | description |
| ------------- | -------------------------- |
| start_vault.sh | main script to start and configure vault.  This script call a few other scripts and then terraform |
| vault_init.out | test to see if vault has need initialized.  If not, it run the vault operator init command and output to json format and piped to a file |
| vault_unseal.sh | reads the output file using cat and jq and passes the keys into vault unseal in a for loop |
| vault_login.sh | logs in to vault using the root token |
| cleanup.sh | destroies all the terraform state objects, then shutsdown dockers, and finally deletes the ~/volumes directory.  This does destroy the vault instance |

| terraform file | description |
| -------------- | -----------------------------|
| main.tf | the main terraform control file |
| auth.tf | configures auth/userpass and auth users |
| policies.tf | configure the policies |
| secrets | creates a few secrets for the tests |

#### Reference: 
https://blog.ruanbekker.com/blog/2019/05/06/setup-hashicorp-vault-server-on-docker-and-cli-guide/

#### Getting Hashi Vault running in Docker

```
# clone this repo
git clone https://github.com/mickmill54/vault_server_docker.git
cd vault_server_docker

# Make sure the following are installed.
- docker
- vault
- terraform
- jq

# Note: I only tested this on macOS

# startup
./start_vault.sh

# shutdown and cleanup
./cleanup.sh

```

# 