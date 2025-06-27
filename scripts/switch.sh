#!/bin/bash
# Usage: ./scripts/switch_and_test.sh [blue|green]

set -e

if [[ "$1" != "blue" && "$1" != "green" ]]; then
  echo "Usage: $0 [blue|green]"
  exit 1
fi

# Switch the service selector
kubectl patch service myapp-service -n default -p \
  "{\"spec\": {\"selector\": {\"app\": \"myapp\", \"version\": \"$1\"}}}"

echo "Switched service to $1 deployment."

# Wait for a few seconds to allow the switch to take effect
sleep 5

# Get the service URL (for Minikube)
SERVICE_URL=$(minikube service myapp-service --url)

# Test the service
RESPONSE=$(curl -s --max-time 5 "$SERVICE_URL" || echo "ERROR")

if [[ "$RESPONSE" == *"$1"* ]]; then
  echo "Test passed: $RESPONSE"
else
  echo "Test failed: Expected '$1' in response, got '$RESPONSE'"
  exit 2
fi