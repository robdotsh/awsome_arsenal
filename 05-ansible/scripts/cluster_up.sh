#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Prompt the user for the Ansible sudo password
# read -r -s -p "Enter the Ansible sudo password: " sudo_pass

# Create infrastructure and inventory file
echo "Creating infrastructure"

##Run Ansible playbooks
echo "Ansible provisioning"
ansible-playbook -i inventory/inventory.ini cluster.yml\
  --private-key="~/.ssh/id_rsa"\
  -u ubuntu\
  --extra-vars "ansible_sudo_pass=Password"
  # --extra-vars "ansible_sudo_pass=$sudo_pass"
