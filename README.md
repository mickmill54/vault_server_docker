# my_vault_server_docker
### vault in docker for testing vault_migrator, vault_renamer, and vault_deleter

*Note*: All the keys and tokens are examples and are no longer in use.

#### Reference: 
https://blog.ruanbekker.com/blog/2019/05/06/setup-hashicorp-vault-server-on-docker-and-cli-guide/

#### Getting Hashi Vault running in Docker
```
# clone this repo
git clone https://github.com/mickmill54/vault_server_docker.git
cd vault_server_docker


```

##### Get the token and keys
```
vault operator init -key-shares=6 -key-threshold=3

Initial root token
s.LwyIsILu0qR0I5UFtrJlW3ev
Key 1:
Y9ubijAm4kq83CSx4NqXs+0NRjCcIAwcY+22l6RHDXTZ
Key 2:
7UZH5mFiRJGvwOFwCDbh37br05FME8nUPKBY55FRcugn
Key 3:
FkBxSdUQ20/7PeqLwYupru2GoCs2i+f5u48LeCIwPj7K
Key 4:
cWBedZws4GH0VbFiKHUt9vVf3yTEplsQNlySGSkg0Wis
Key 5:
eproM5EpmLLZaMLSJaEkPZpTRIBSzJjvFJnM21YVV9Z6
Key 6:
+nCDDKkwj6vJ/J29j01UbMoqamc7xiM6Zfe/8tyJbyIk
```

##### unseal vault
```
vault operator unseal
```

##### Export vault env setting
```
$ export VAULT_ADDR='http://127.0.0.1:8200'
```

##### get status
```
vault status
```

##### Login with root token  
```
vault login s.LwyIsILu0qR0I5UFtrJlW3ev
```

##### Enable secrets engine
```
vault secrets enable -path=kv kv-v2
vault kv enable-versioning kv
vault write kv/config max_versions=4
```

##### Write some keys
```
vault kv put kv/gkeop/test test=12345
vault kv put kv/cnn/test test=12345
vault kv list kv/gkeop
vault kv list kv/cnn
```

##### Turn on user passwords 
```
vault auth enable userpass
```

##### Turn on user password
```
vault auth enable userpass
```

##### Create a user
```
vault write auth/userpass/users/mick password={password}
```

##### Login as new user
```
vault login -method=userpass username=mick

Key                    Value
---                    -----
token                  s.yrOm2H1At12TeAhaCILoGsGn
token_accessor         A05RZztj794Rn3kc3t6SyP24
token_duration         768h
token_renewable        true
token_policies         ["default"]
identity_policies      []
policies               ["default"]
token_meta_username    mick
```

##### Get my token and more
```
$ vault token lookup

Key                 Value
---                 -----
accessor            A05RZztj794Rn3kc3t6SyP24
creation_time       1608599981
creation_ttl        768h
display_name        userpass-mick
entity_id           cce07b9f-2d1d-c7f4-8a2e-60f42d037577
expire_time         2021-01-23T01:19:41.117400925Z
explicit_max_ttl    0s
id                  s.yrOm2H1At12TeAhaCILoGsGn
issue_time          2020-12-22T01:19:41.117405591Z
meta                map[username:mick]
num_uses            0
orphan              true
path                auth/userpass/login/mick
policies            [default]
renewable           true
ttl                 767h58m41s
type                service
```

##### create an admins policy
```
path "sys/health"
{
  capabilities = ["read", "sudo"]
}

# Create and manage ACL policies broadly across Vault

# List existing policies
path "sys/policies/acl"
{
  capabilities = ["list"]
}

# Create and manage ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Enable and manage authentication methods broadly across Vault

# Manage auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Create, update, and delete auth methods
path "sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}

# Enable and manage the key/value secrets engine at `secret/` path

# List, create, update, and delete key/value secrets
path "kv/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}
```

##### create a use policy HCL file
```
cat user_policy.hcl
path "kv/datai/mick/*" {
  capabilities = ["create", "update", "read", "delete"]
}
path "kv/delete/mick/*" {
  capabilities = ["update"]
}
path "kv/metadata/mick/*" {
  capabilities = ["list", "read", "delete"]
}
path "kv/destroy/mick/*" {
  capabilities = ["update"]
}
# Additional access for UI
path "kv/metadata" {
  capabilities = ["list"]
}
```


##### configure the policy
```
vault login s.LwyIsILu0qR0I5UFtrJlW3ev

vault policy write users ./user_policy.hcl

vault policy write admins ./admins_policy.hcl

vault write auth/userpass/users/mick/policies policies=users,admins
```
