package unison.authz.actuation

default allow = false

allow {
  input.action == "actuation.execute"
  input.role in {"admin", "operator"}
  input.step_up == true
  device_trusted
}

device_trusted {
  input.device.trust_state == "attested"
}

deny_reason[msg] {
  not allow
  msg := "actuation requires operator with step-up and trusted device"
}
