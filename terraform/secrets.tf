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

resource "vault_generic_secret" "cnn-foo" {
  path = "kv/cnn/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}

resource "vault_generic_secret" "cnn-bar" {
  path = "kv/cnn/bar"

  data_json = <<EOT
{
  "bar":   "foo",
  "pizza": "cheese"
}
EOT
}

resource "vault_generic_secret" "gke-foo" {
  path = "kv/gke/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}



resource "vault_generic_secret" "gke-bar" {
  path = "kv/gke/bar"

  data_json = <<EOT
{
  "bar":   "foo",
  "pizza": "cheese"
}
EOT
}