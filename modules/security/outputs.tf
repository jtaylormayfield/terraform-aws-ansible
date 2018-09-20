output "sg_id" {
  value = "${var.enabled ? join("", aws_security_group.default.*.id[0]) : ""}"
}
