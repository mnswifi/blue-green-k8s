#!/bin/bash
# Usage: ./scripts/test.sh <SERVICE_IP> <EXPECTED_COLOR>

set -e

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <SERVICE_IP> <EXPECTED_COLOR>"
  exit 1
fi

SERVICE_IP="$1"
EXPECTED_COLOR="$2"

RESPONSE=$(curl -s --max-time 5 http://$SERVICE_IP/ || echo "ERROR")

if [[ "$RESPONSE" == "ERROR" ]]; then
  echo "Error: Could not connect to service at $SERVICE_IP"
  exit 2
fi

if [[ "$RESPONSE" == *"$EXPECTED_COLOR"* ]]; then
  echo "Test passed: $RESPONSE"
  exit 0
else
  echo "Test failed: Expected '$EXPECTED_COLOR' in response, got '$RESPONSE'"
  exit 3
fi