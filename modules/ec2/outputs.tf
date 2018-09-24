output "instance_id" {
  value = "${aws_instance.i.id}"
}

output "key_name" {
  value = "${var.key_name}"
}

output "public_hostname" {
  value = "${aws_instance.i.public_dns}"
}

output "sg_ids" {
  value = "${aws_instance.i.vpc_security_group_ids}"
}
