#!/usr/bin/env bash

echo "#  deploy Gatekeeper components to your Kubernetes cluster."
# Gatekeeper Helm Chart

echo "Get Repo Info"

helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
helm repo update

# Helm install and create namespace
helm install -n gatekeeper-system gatekeeper gatekeeper/gatekeeper --create-namespace

# kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
