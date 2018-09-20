provider "aws" {}

locals {
  tag_prefix_env  = "${var.project_environment}"
  tag_prefix_name = "${var.project_name}"
}

data "aws_subnet" "default" {
  id = "${var.subnet_id}"
}

module "ec2" {
  source = "./modules/ec2"

  ami_id                    = "${var.ami_id}"
  generate_key              = "${var.generate_key}"
  instance_type             = "${var.instance_type}"
  instance_var_name         = "${var.instance_var_name}"
  key_name                  = "${var.key_name}"
  playbook_file             = "${var.playbook_file}"
  playbook_profile          = "${var.playbook_profile}"
  playbook_system           = "${var.playbook_system}"
  playbook_user             = "${var.playbook_user}"
  playbooks                 = "${var.playbooks}"
  private_key_path          = "${var.private_key_path}"
  public_key_path           = "${var.public_key_path}"
  remote_config             = "${var.remote_config}"
  remote_config_host        = "${var.remote_config_host}"
  remote_config_host_key    = "${var.remote_config_host_key}"
  remote_config_private_key = "${var.remote_config_private_key}"
  sg_ids                    = "${compact(concat(var.sg_ids, list(module.security.sg_id)))}"
  subnet_id                 = "${data.aws_subnet.default.id}"
  tag_env                   = "${local.tag_prefix_env}"
  tag_name                  = "${local.tag_prefix_name}"
  volume_size               = "${var.volume_size}"
  volume_type               = "${var.volume_type}"
}

module "security" {
  source = "./modules/security"

  enabled        = "${var.generate_security_groups}"
  inbound_rules  = "${var.inbound_rules}"
  outbound_rules = "${var.outbound_rules}"
  tag_env        = "${local.tag_prefix_env}"
  tag_name       = "${local.tag_prefix_name}"
  vpc_id         = "${data.aws_subnet.default.vpc_id}"
}
