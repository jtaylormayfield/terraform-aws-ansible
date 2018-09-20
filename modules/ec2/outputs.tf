output "key_name" {
  value = "${var.key_name}"
}

output "sg_ids" {
  value = "${aws_instance.default.vpc_security_group_ids}"
}
