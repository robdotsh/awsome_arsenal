#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-prod}"

echo "[DEPLOY] Deploying to environment: ${ENVIRONMENT}"
echo -e "#TODO: replace with real deploy command\n
# ./deploy.sh "${ENVIRONMENT}""
echo ""
echo "[DEPLOY] Deployment completed."
