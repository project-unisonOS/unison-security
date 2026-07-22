package unison.authz.actuation

test_actuation_requires_trust_and_stepup {
  allow with input as {"action": "actuation.execute", "role": "operator", "step_up": true, "device": {"trust_state": "attested"}}
}

test_actuation_denies_untrusted_device {
  not allow with input as {"action": "actuation.execute", "role": "operator", "step_up": true, "device": {"trust_state": "unknown"}}
}
