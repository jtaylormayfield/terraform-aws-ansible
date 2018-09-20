output "key_name" {
  value = "${var.generate_key ? aws_key_pair.deployer.*.key_name[0] : var.key_name}"
}
