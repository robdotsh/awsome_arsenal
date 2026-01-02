#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Prompt for the Ansible sudo password securely (input is hidden)
read -r -s -p "Enter the Ansible sudo password: " sudo_pass
echo " " 

# Add your infrastructure creation commands here
echo "Creating infrastructure..."

echo "Running Ansible provisioning..."

# Run the Ansible playbook
ansible-playbook -i inventory/inventory.ini cluster.yml \
  --private-key="${HOME}/.ssh/id_rsa" \
  -u ubuntu \
  --become \
  --become-method=sudo \
  --extra-vars "ansible_become_password=$sudo_pass"
