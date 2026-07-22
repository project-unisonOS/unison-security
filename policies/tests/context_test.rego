package unison.authz.context

test_context_sensitive_user_ok {
  allow with input as {"action": "context.read", "role": "user", "resource": {"classification": "sensitive"}}
}

test_context_highly_sensitive_requires_operator {
  allow with input as {"action": "context.read", "role": "operator", "resource": {"classification": "highly-sensitive"}}
  not allow with input as {"action": "context.read", "role": "user", "resource": {"classification": "highly-sensitive"}}
}
