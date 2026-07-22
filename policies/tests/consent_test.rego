package unison.authz.consent

test_consent_scope_matches {
  allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true, "scope": "default"}, "resource": {"scope": "default"}}
}

test_consent_scope_mismatch {
  not allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true, "scope": "a"}, "resource": {"scope": "b"}}
}
