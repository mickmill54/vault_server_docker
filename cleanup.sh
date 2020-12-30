# Remove all terraform states
cd terraform
terraform destroy -auto-approve

# Shutdown docker
docker-compose down

# Delete the volumes
rm -rf ~/volumes

