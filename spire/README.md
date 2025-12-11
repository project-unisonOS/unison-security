# SPIRE bootstrap

Purpose: provide a starting point for issuing SPIFFE IDs to UnisonOS services.

Contents:
- `server.conf` — sample SPIRE server config (filesystem bundle, join tokens disabled by default).
- `agent.conf` — sample SPIRE agent config (join token or x509pop configurable).
- `registration.sh` — placeholder for scripted workload registration.

Notes:
- Replace placeholder trust domain (`unisonos.test`) and adjust the trust bundle path.
- Use node attestors appropriate for your environment (k8s, aws, gcp, x509pop).
- For production, prefer node attestation over join tokens and rotate server keys periodically.
