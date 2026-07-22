package unison.authz.context

import future.keywords.in

default allow = false

allow {
  input.action == "context.read"
  role_ok
  classification_ok
}

role_ok {
  input.role in {"admin", "operator", "user"}
}

classification_ok {
  # deny highly-sensitive unless operator/admin
  input.resource.classification != "highly-sensitive"
} else {
  input.resource.classification == "highly-sensitive"
  input.role in {"admin", "operator"}
}

deny_reason[msg] {
  not allow
  msg := "insufficient role for resource classification"
}
