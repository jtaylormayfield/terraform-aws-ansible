output "sg_id" {
  value = "${ var.enabled ? aws_security_group.default.*.id[0] : ""}"
}
