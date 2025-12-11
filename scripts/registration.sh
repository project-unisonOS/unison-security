#!/usr/bin/env bash
# SPIRE workload registration examples. Adjust selectors and trust domain.

set -euo pipefail

TRUST_DOMAIN=${TRUST_DOMAIN:-"unisonos.test"}
NAMESPACE=${NAMESPACE:-"default"}
SPIRE_SERVER=${SPIRE_SERVER:-"spire-server"}

register_service() {
  local spiffe_id="$1"
  shift
  local selectors=("$@")
  local args=()
  for sel in "${selectors[@]}"; do
    args+=("-selector" "$sel")
  done
  spire-server entry create \
    -spiffeID "spiffe://${TRUST_DOMAIN}/${spiffe_id}" \
    -parentID "spiffe://${TRUST_DOMAIN}/spire/server" \
    "${args[@]}"
}

# Kubernetes examples
register_k8s() {
  local name="$1"
  local sa="$2"
  register_service "ns/${NAMESPACE}/sa/${sa}" \
    "k8s:ns:${NAMESPACE}" \
    "k8s:sa:${sa}" \
    "k8s:pod-label:app:${name}"
}

register_k8s "orchestrator" "orchestrator"
register_k8s "context" "context"
register_k8s "storage" "storage"
register_k8s "auth" "auth"
register_k8s "policy" "policy"
register_k8s "actuation" "actuation"

# Container/Docker examples (unix workload attestor)
# register_service "workload/orchestrator" "unix:uid:1000" "unix:gid:1000"

echo "Registration complete."
