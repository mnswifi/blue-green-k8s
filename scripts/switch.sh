#!/bin/bash
# Usage: ./scripts/switch.sh [blue|green]

set -e

if [[ "$1" != "blue" && "$1" != "green" ]]; then
  echo "Usage: $0 [blue|green]"
  exit 1
fi

if ! kubectl get service myapp-service &>/dev/null; then
  echo "Error: myapp-service does not exist in the current namespace."
  exit 2
fi

kubectl patch service myapp-service -n default -p \
  "{\"spec\": {\"selector\": {\"app\": \"myapp\", \"version\": \"$1\"}}}"

if [ $? -eq 0 ]; then
  echo "Switched service to $1 deployment."
else
  echo "Failed to switch service."
  exit 3
fi