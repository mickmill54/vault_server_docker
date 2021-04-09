#!/bin/bash

# Add keys
for i in {0..2}
  do
     echo "Counter: " $i
     KEY=$(cat ./vault_init.out | jq -r ".unseal_keys_b64[ ${i}]")
     echo $KEY
     vault operator unseal $KEY
  done
