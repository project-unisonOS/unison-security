# Policy bundle build and publish

- Build/test locally: `opa test policies`
- Build bundle: `opa build --bundle policies -o bundle.tar.gz`
- Sign bundle (keyless): `COSIGN_EXPERIMENTAL=1 cosign sign-blob --yes bundle.tar.gz > bundle.sig`
- Verify: `COSIGN_EXPERIMENTAL=1 cosign verify-blob --certificate-identity-regexp "github.com/project-unisonOS/unison-security" --certificate-oidc-issuer https://token.actions.githubusercontent.com --signature bundle.sig bundle.tar.gz`
- CI: `publish-policy-bundle` workflow builds, signs (keyless), and attaches bundles to tags `policy-*`.
