# ./config/vault-config.hcl
istener "tcp" {
 address = "0.0.0.0:8200"
 tls_disable = 1
}
storage "file" {
  path = "$HOME/volumes/file"
}
disable_mlock = true
api_addr = "http://localhost:8200"
ui=true
