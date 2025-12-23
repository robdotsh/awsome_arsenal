#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Script to generate and store PAT (for use in Azure DevOps pipelines)
# Requires Azure CLI and jq (for JSON parsing)

# Get Azure DevOps PAT token
echo "Creating PAT token.."
az devops login --token $(cat ~/.azure-devops-token)
