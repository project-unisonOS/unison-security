# Security and audit logging schema

Goals:
- Uniform fields across services for auth, policy, consent, actuation.
- Machine-parsable (JSONL recommended).
- Safe by default: redact tokens/PII; include SPIFFE IDs where available.

## Common fields
- `ts` (ISO8601 UTC)
- `service` (e.g., orchestrator, context, storage, auth, policy, actuation, io-speech)
- `instance` (hostname/pod)
- `severity` (DEBUG|INFO|WARN|ERROR)
- `event` (string identifier; see below)
- `principal`:
  - `user_id` (nullable)
  - `role`
  - `spiffe_id` (service identity, if mTLS)
- `request_id` (trace/correlation id)
- `resource`:
  - `type` (e.g., context, intent, actuation)
  - `id` (redacted/hashed when sensitive)
  - `classification` (public|internal|sensitive|highly-sensitive)
- `decision`:
  - `outcome` (allow|deny|error)
  - `policy` (name/version)
  - `reason` (for denies/errors)
- `network`:
  - `src_ip` (if available; avoid storing client IP for sensitive deployments)
  - `dst_service`
- `client`:
  - `ua` (optional; avoid if sensitive)

## Event types (examples)
- `auth.login`, `auth.refresh`, `auth.failure`
- `policy.decision`
- `consent.update`, `consent.check`
- `context.read`, `context.write`
- `actuation.command`, `actuation.denied`
- `io.request`, `io.denied` (speech/vision/sign/braille/bci)

## Redaction rules
- Never log secrets, tokens, API keys, or full JWTs. If needed, log the key ID only.
- Hash or truncate identifiers for sensitive/highly-sensitive resources.
- Strip/avoid PII payloads; log metadata (classification, size) instead of content.
- Apply redaction at the edge of each service (middleware) before emitting logs.

## Transport and storage
- Prefer JSONL to a central collector (Fluent Bit/Vector) with TLS/mTLS.
- Tag logs with environment (dev/staging/prod) and data classification.
- Retain audit logs per compliance needs; ensure immutability/WORM where required.

## Alerting thresholds (examples)
- auth:
  - >10 login failures per user per 5m (WARN), >50 (ALERT)
  - token refresh failures spike >20% over baseline
- policy:
  - >5% policy.denied over 10m per service
  - policy bundle verification failures >0
- actuation:
  - any actuation.denied with reason `untrusted_device`
  - bursts >5 actuation.command per minute per principal
- IO:
  - io.denied spike >10% over baseline
- system:
  - unsigned image/bundle verification failure (ALERT)
