package unison.authz

test_allow_context_read {
  allow with input as {"action": "context.read", "role": "user", "consent": {"granted": true}}
}

test_block_without_consent {
  not allow with input as {"action": "context.read", "role": "user", "consent": {"granted": false}}
}
