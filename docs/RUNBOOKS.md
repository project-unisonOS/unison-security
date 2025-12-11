# Security runbooks (starter)

- **Secret leak:** rotate affected keys in Vault/Secret Manager; revoke tokens; invalidate bundles; redeploy with new secrets.
- **Compromised workload:** revoke SVID, quarantine node, rotate service creds, invalidate session tokens, audit policy decisions for blast radius.
- **Policy failure:** fail-closed at gateway; roll back to last signed bundle; open break-glass path with explicit approvals.
