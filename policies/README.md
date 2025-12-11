## Policies

- `authz/` — authorization and consent checks for core services.
- `data/` — data handling rules (classification, logging redaction).
- `tests/` — opa test suites.
- `bundle/` — built bundle artifacts (not checked in; produced by CI).

### Example policy goals
- Enforce consent before accessing context/intents/actuation.
- Require step-up auth for high-risk actions (actuation, payments).
- Deny access when device trust state is unknown (edge attestation failures).
- Ensure data classification tags are present on resources and requests.
