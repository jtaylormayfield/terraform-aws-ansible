locals {
  git_path_prefix = "${path.cwd}/.terraform/cache/git-"

  ansible_parms_arr = [
    "--extra-vars \"${var.instance_var_name}=${aws_instance.default.id}\"",
    "--key-file ${var.private_key_path}",
    "--user ${var.playbook_user}"
  ]
  ansible_parms = "${join(" ", ansible_parms_arr)}"

  scripts = {
    linux = "sh"
  }
}

resource "aws_key_pair" "deployer" {
  count      = "${var.generate_key ? 1 : 0}"
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.sg_ids}"]
  subnet_id              = "${var.subnet_id}"

  root_block_device {
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
  }

  tags {
    Environment = "${var.tag_env}"
    Name        = "${var.tag_name}"
  }
}

resource "random_id" "repo_id" {
  count       = "${length(var.playbooks)}"
  byte_length = 8
}

data "template_file" "ansible" {
  template = "${file("${path.module}/templates/play.${lookup(local.scripts, var.playbook_system)}.tpl")}"

  vars {
    aws_profile     = "${var.playbook_profile}"
    git_cmds        = "${join(" & ", formatlist("git clone %s ${local.git_path_prefix}%s", var.playbooks, random_id.repo_id.*.b64_url))}"
    git_path_prefix = "${local.git_path_prefix}"
    play_cmds       = "${join(" && ", formatlist("ansible-playbook ${local.git_path_prefix}%s/${var.playbook_file} %s", random_id.repo_id.*.b64_url, local.ansible_parms))}"
  }
}

resource "null_resource" "local_provisioner" {
  triggers {
    instance_id = "${aws_instance.default.id}"
  }

  provisioner "local-exec" {
    command = "${data.template_file.ansible.rendered}"
  }
}
