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
