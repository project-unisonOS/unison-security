# unison-security

Security guidance, sidecar configuration, SPIRE bootstrap assets, and policy-supporting artifacts for UnisonOS.

## Status
Documentation and configuration repo. This repo does not expose an application server; it centralizes cross-cutting security material used by the service repos and deployment stacks.

## What is here today
- `docs/` — threat models, enrollment notes, service identity guidance, logging/audit schema, runbooks, and data-classification material.
- `sidecars/` — example Envoy and OPA sidecar configuration.
- `spire/` — SPIRE server and agent configuration plus usage notes.
- `scripts/registration.sh` — helper script for registration flows.
- `policies/` — policy repo support docs and bundle references.

## Intended use
- Reference security architecture while implementing or reviewing service behavior.
- Reuse sidecar and SPIRE configuration patterns in secure deployments.
- Keep audit/logging schema guidance aligned with service implementations.

## Related repos
- `unison-policy` for runtime policy evaluation and grant endpoints.
- `unison-auth` and `unison-consent` for authn/authz and consent tokens.
- `unison-platform` and `unison-workspace` for deployment wiring.

## Docs
- Public docs: https://project-unisonos.github.io/reference/security/
- Repo docs: `docs/README.md`, `spire/README.md`, `policies/README.md`
