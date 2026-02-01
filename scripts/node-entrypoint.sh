#!/bin/sh
set -e

# Wait for step-ca to be ready
sleep 5

# Bootstrap with step-ca
step ca bootstrap --ca-url https://step-ca:9000 --fingerprint $(step certificate fingerprint /home/step/certs/root_ca.crt) --install --force

# Get certificate using ACME standalone (runs temporary HTTP server on port 80)
step ca certificate $NODE_ID /tmp/$NODE_ID.crt /tmp/$NODE_ID.key \
  --provisioner acme \
  --san $NODE_ID \
  --standalone \
  --force

# Start the application
exec node src/index.js
