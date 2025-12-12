#!/bin/bash
helm template cert-manager jetstack/cert-manager --namespace cert-manager --version v1.7.0 --create-namespace --set installCRDs=true > cert-manager.yaml