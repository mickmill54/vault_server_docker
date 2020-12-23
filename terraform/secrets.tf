#----------------------------------------------------------
# Enable secrets engines
#----------------------------------------------------------

# Enable kv-v2 secrets engine in the finance namespace
resource "vault_mount" "kv" {
  provider = vault
  path = "kv"
  type = "kv-v2"
}

#----------------------------------------------------------
# Create key value pair
#----------------------------------------------------------

resource "vault_generic_secret" "cnn00-keys" {
  path = "kv/cnn00/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}

resource "vault_generic_secret" "gke00-keys" {
  path = "kv/gke00/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}
