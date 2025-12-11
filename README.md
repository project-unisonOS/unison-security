## unison-security (bootstrap)

Purpose: centralize cross-cutting security artifacts and services for UnisonOS.

Proposed responsibilities:
- Identity: SPIFFE/SPIRE configuration and helper scripts for issuing SVIDs; templates for service identity bootstrapping.
- Policy: OPA/Cedar bundles for authZ/consent; sidecar config snippets for Envoy/ext_authz.
- Secrets: Interfaces to Vault/Secret Manager; guidance and SDK stubs for secret retrieval.
- Audit: Schemas and forwarders for security/audit events.
- CI/CD: Reusable workflows for signing, SBOM, policy validation.

Workflows:
- `ci`: validate policies and run security checks.
- `publish-policy-bundle`: build, sign (cosign keyless), and attach bundles to tagged releases (`policy-*`).

Structure:
- `policies/` — Rego/Cedar policies, tests, and bundles.
- `sidecars/` — Example Envoy/OPA sidecar configs.
- `scripts/` — Enrollment/onboarding scripts (e.g., SPIRE node/agent).
- `docs/` — Threat models, runbooks, and integration guides.
- `.github/workflows/` — CI for policy validation and bundle build/publish.

Next steps:
1. Decide policy engine (OPA vs Cedar) and wire initial ABAC/RBAC rules.
2. Add SPIRE server/agent configs and enrollment flow for core services.
3. Publish bundles to an internal bucket/registry and enforce via admission/sidecars.
4. Integrate cosign signing/verification of bundles and images.
