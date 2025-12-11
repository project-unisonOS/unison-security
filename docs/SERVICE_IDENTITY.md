# Service identity rollout (pilot)

Goal: enforce mTLS and policy for orchestrator ↔ context ↔ storage ↔ auth using SPIRE-issued SVIDs, Envoy mTLS, and OPA ext_authz.

## Prereqs
- SPIRE server + agent deployed on the node/cluster.
- Workload registrations:
  - spiffe://unisonos.test/ns/default/sa/orchestrator
  - spiffe://unisonos.test/ns/default/sa/context
  - spiffe://unisonos.test/ns/default/sa/storage
  - spiffe://unisonos.test/ns/default/sa/auth
- Policy bundle built and available (signed) from `unison-security`.

## Edge/compose pilot steps
1) Run SPIRE agent with Unix workload attestor or k8s attestor.
2) Add Envoy sidecars next to each service with:
   - SDS from SPIRE agent (`/tmp/spire-agent/public/api.sock`).
   - mTLS clusters for peer services (example: `envoy-orchestrator.yaml`).
3) Add OPA sidecar with the policy bundle; configure Envoy `ext_authz` to call OPA.
4) Update services to listen on localhost and trust only Envoy (bind app to 127.0.0.1, Envoy handles TLS).

## K8s pilot steps
1) Deploy SPIRE server/agent (k8s attestor).
2) Create SPIRE entries for the four services (see `scripts/registration.sh`).
3) Use an Envoy sidecar injector or manual sidecars using the provided bootstrap templates.
4) Enable mTLS between services via SPIFFE SDS; enable OPA ext_authz sidecar with policy bundle.

## Envoy config essentials
- Use SDS for certs/keys:
  ```yaml
  tls_certificate_sds_secret_configs:
    - name: spiffe://unisonos.test/ns/default/sa/orchestrator
      sds_config:
        api_config_source:
          api_type: GRPC
          grpc_services:
            - envoy_grpc:
                cluster_name: spire_agent
  validation_context_sds_secret_config:
    name: spiffe://unisonos.test
  ```
- Upstream cluster TLS context: require client cert (SPIFFE) and match SANs.
- HTTP filter chain: `ext_authz` -> `router`, pointing to OPA sidecar.

See `sidecars/envoy-orchestrator.yaml` and `sidecars/opa-config.yaml` for templates.

## Verification
- Curl between services fails without SPIFFE SVIDs.
- Requests are authorized only when OPA policy allows (consent + role, actuation step-up).
- Logs show SPIFFE IDs for both sides of each connection.
