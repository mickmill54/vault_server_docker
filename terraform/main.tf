#------------------------------------------------------------------------------
# The best practice is to use remote state file and encrypt it since your
# state files may contains sensitive data (secrets).
#------------------------------------------------------------------------------
# terraform {
#       backend "s3" {
#             bucket = "remote-terraform-state-dev"
#             encrypt = true
#             key = "terraform.tfstate"
#             region = "us-east-1"
#       }
# }

#-----------------------------------------------------------------------------------
# To configure Transform secrets engine, you need vault provider v2.12.0 or later
#-----------------------------------------------------------------------------------
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.12"
    }
    rundeck = {
      source = "terraform-providers/rundeck"
      version = "~> 0.4.0"
    }
  }
}

# Use Vault provider
provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables:
  #    - VAULT_ADDR
  #    - VAULT_TOKEN
  #    - VAULT_CACERT
  #    - VAULT_CAPATH
  #    - etc.  
}