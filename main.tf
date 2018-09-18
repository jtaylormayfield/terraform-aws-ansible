provider "aws" {
  region = "${var.aws_region}"
}

locals {
  tag_prefix_env  = "${var.project_environment}"
  tag_prefix_name = "${var.project_name}"
}

data "aws_subnet" "default" {
  id = "${var.subnet_id}"
}

module "ec2" {
  source = "./modules/ec2"

  ami_id            = "${var.ami_id}"
  instance_type     = "${var.instance_type}"
  instance_var_name = "${var.instance_var_name}"
  playbook_file     = "${var.playbook_file}"
  playbook_profile  = "${var.playbook_profile}"
  playbook_system   = "${var.playbook_system}"
  playbook_user     = "${var.playbook_user}"
  playbooks         = "${var.playbooks}"
  private_key_path  = "${var.private_key_path}"
  public_key_path   = "${var.public_key_path}"
  sg_ids            = "${compact(concat(var.sg_ids, list(module.security.sg_id)))}"
  subnet_id         = "${var.subnet_id}"
  tag_env           = "${local.tag_prefix_env}"
  tag_name          = "${local.tag_prefix_name}"
  volume_size       = "${var.volume_size}"
  volume_type       = "${var.volume_type}"
}

module "security" {
  source = "./modules/security"

  enabled        = "${var.security_enabled}"
  inbound_rules  = "${var.inbound_rules}"
  outbound_rules = "${var.outbound_rules}"
  tag_env        = "${local.tag_prefix_env}"
  tag_name       = "${local.tag_prefix_name}"
  vpc_id         = "${data.aws_subnet.default.vpc_id}"
}
