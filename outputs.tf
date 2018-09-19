output "key_name" {
  value = "${var.generate_key ? module.ec2.key_name : var.key_name}"
}

