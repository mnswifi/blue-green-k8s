#!/bin/bash
cat deployments/blue-deployment.yaml > all-manifests.yaml
echo "---" >> all-manifests.yaml
cat deployments/green-deployment.yaml >> all-manifests.yaml
echo "---" >> all-manifests.yaml
cat deployments/service.yaml >> all-manifests.yaml
echo "All manifests exported to all-manifests.yaml"