# Remove all terraform states
cd terraform
terraform destroy -auto-approve
rm -rf .terraform
rm -f terraform.tfstate
rm -f terraform.tfstate.backup
cd ..

# Shutdown docker
docker-compose down --volumes

# Delete the volumes
rm -rf ~/volumes

