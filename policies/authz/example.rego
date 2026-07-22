package unison.authz

import future.keywords.in

# Example authz: consent-aware, step-up for actuation, minimal context rules.

default allow = false

allow {
  input.consent.granted == true
  action_allowed
}

action_allowed {
  input.action == "context.read"
  input.role in {"admin", "operator", "user"}
  # protect sensitive fields
  not contains_sensitive_field
}

action_allowed {
  input.action == "actuation.execute"
  input.role in {"admin", "operator"}
  input.step_up == true  # require step-up auth for actuation
}

deny_reason[msg] {
  not allow
  msg := "consent missing or role unauthorized"
}

contains_sensitive_field {
  some path
  input.fields[path]
  path == "secrets"
}
