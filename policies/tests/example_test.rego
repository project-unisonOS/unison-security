package unison.authz

test_allow_context_read {
  allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true}}
}

test_block_without_consent {
  not allow with input as {"action": "context.read", "role": "user", "consent": {"granted": false}}
}

# Consent policy tests
package unison.authz.consent

test_consent_scope_matches {
  allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true, "scope": "default"}, "resource": {"scope": "default"}}
}

test_consent_scope_mismatch {
  not allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true, "scope": "a"}, "resource": {"scope": "b"}}
}

# Actuation tests
package unison.authz.actuation

test_actuation_requires_trust_and_stepup {
  allow with input as {"action": "actuation.execute", "role": "operator", "step_up": true, "device": {"trust_state": "attested"}}
}

test_actuation_denies_untrusted_device {
  not allow with input as {"action": "actuation.execute", "role": "operator", "step_up": true, "device": {"trust_state": "unknown"}}
}

# Context classification tests
package unison.authz.context

test_context_sensitive_user_ok {
  allow with input as {"action": "context.read", "role": "user", "resource": {"classification": "sensitive"}}
}

test_context_highly_sensitive_requires_operator {
  allow with input as {"action": "context.read", "role": "operator", "resource": {"classification": "highly-sensitive"}}
  not allow with input as {"action": "context.read", "role": "user", "resource": {"classification": "highly-sensitive"}}
}
