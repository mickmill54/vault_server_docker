# Create keys and root tokens
# Test to see if init already ran
INIT_STATUS=$(vault operator init -status)

echo "Init Status: " $INIT_STATUS

# Generate keys and token and write to file

if [  $"INIT_STATUS" = "Vault is initialized"  ]; then
  echo "Vault already ran init"
  exit
else
  echo "Vault needs to be initailized"
  vault operator init -format=json > ./vault_init.out
fi
