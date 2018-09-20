output "sg_ids" {
  depends_on = ["aws_security_group.default"]
  value = "${aws_security_group.default.*.id}"
}
