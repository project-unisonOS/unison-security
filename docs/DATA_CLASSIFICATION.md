# Data classification (starter)

- **Public:** docs, marketing content. No auth required.
- **Internal:** non-prod configs and code. Keep in private repos.
- **Sensitive:** user profiles, context/intent graphs, telemetry with identifiers. Encrypt at rest; restrict access via policy; redact in logs.
- **Highly-sensitive:** credentials, tokens, model keys, consent records, actuation control channels. Store only in Vault/Secret Manager; short TTL; strict mTLS + step-up auth for access.
