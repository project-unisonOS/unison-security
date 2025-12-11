# Threat model (starter)

Assumptions:
- Edge devices and servers run hardened OS builds with host firewalls.
- SPIRE issues SVIDs to workloads; Envoy/OPA enforces authz.
- Secrets are fetched from Vault/Secret Manager; no static secrets in code.

Assets:
- Context/intent/consent data, credentials/tokens, actuation channels, model API keys, logs/telemetry.

Key risks:
- Supply chain tampering (deps/actions/images).
- AuthZ bypass via misconfigured sidecars or missing identity.
- Secrets leakage in logs or local env.
- IO module compromise leading to device control.

Controls (to implement here):
- Service identity (SPIFFE), mTLS everywhere.
- Policy bundles with consent + role checks.
- Signed images and policy bundles.
- Audit logging for policy decisions and sensitive actions.
