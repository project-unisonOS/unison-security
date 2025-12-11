package unison.authz.consent

default allow = false

allow {
  input.action == "context.read"
  consent_ok
  role_ok
}

allow {
  input.action == "intent.write"
  consent_ok
  role_ok
}

consent_ok {
  input.consent.granted == true
  input.consent.scope == input.resource.scope
}

role_ok {
  input.role in {"admin", "operator", "user"}
}

deny_reason[msg] {
  not allow
  msg := "consent not granted for scope or role unauthorized"
}
