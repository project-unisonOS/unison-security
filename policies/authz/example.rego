package unison.authz

# Simple example: allow only if consent is granted and role is authorized.

default allow = false

allow {
  input.consent.granted == true
  action_allowed
}

action_allowed {
  input.action == "context.read"
  input.role in {"admin", "operator", "user"}
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
