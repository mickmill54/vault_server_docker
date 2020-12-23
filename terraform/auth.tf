#--------------------------------
# Enable userpass auth method
#--------------------------------
resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "mick" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/mick"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["fpe-client", "admins"],
  "password": "changeme"
}
EOT
}

resource "vault_generic_endpoint" "sam" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/sam"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["fpe-client", "admins"],
  "password": "changeme"
}
EOT
}

resource "vault_generic_endpoint" "jamie" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/jamie"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["fpe-client", "admins"],
  "password": "changeme"
}
EOT
}