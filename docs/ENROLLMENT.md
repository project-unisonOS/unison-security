# SPIRE enrollment (starter)

1. Deploy SPIRE server with `spire/server.conf` (adjust trust domain and storage).
2. Configure node attestor (k8s, aws, gcp, x509pop). Avoid long-lived join tokens in prod.
3. Deploy SPIRE agent with `spire/agent.conf`; ensure trust bundle is present.
4. Register workloads:
   ```bash
   # example: orchestrator
   spire-server entry create \\
     -spiffeID spiffe://unisonos.test/ns/default/sa/orchestrator \\
     -selector k8s:ns:default \\
     -selector k8s:sa:orchestrator \\
     -dns orchestrator
   ```
5. Mount Envoy/OPA sidecars using the SVIDs; enforce mTLS and ext_authz.
6. Rotate keys regularly; export bundle to gateways and admission controllers.
