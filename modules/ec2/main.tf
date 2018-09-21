locals {
  ansible_parms_arr = [
    "--extra-vars ${var.instance_var_name}=${aws_instance.default.id}",
    "--key-file ${var.private_key_path}",
    "--user ${var.playbook_user}",
  ]

  ansible_parms   = "${join(" ", local.ansible_parms_arr)}"
  git_dirs        = "${random_id.repo_id.*.b64_url}"
  git_path_prefix = "/tmp/terraform/cache/git-"
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

resource "null_resource" "provisioner" {
  triggers {
    instance_id = "${aws_instance.default.id}"
  }

  # Git clone all repositories
  provisioner "local-exec" {
    command = "${format("%s && %s", join(" & ", formatlist("git clone %s %s%s", var.playbooks, local.git_path_prefix, local.git_dirs)), "wait")}"
    interpreter = ["/bin/bash"]
  }

  # Run playbooks
  provisioner "local-exec" {
    command = "${join(" && ", formatlist("ansible-playbook %s%s/%s %s", local.git_path_prefix, local.git_dirs, var.playbook_file, local.ansible_parms))}"
    interpreter = ["/bin/bash"]

    environment {
      AWS_PROFILE               = "${var.playbook_profile}"
      ANSIBLE_HOST_KEY_CHECKING = "${var.bypass_fingerprint ? "False" : "True"}"
      ANSIBLE_PIPELINING        = "${var.ansible_pipelining ? "True" : "False"}"
    }
  }

  # Remove cached Git directories
  provisioner "local-exec" {
    command = "${format("%s && %s", join(" & ", formatlist("rm -rf %s%s", local.git_path_prefix, local.git_dirs)), "wait")}"
    interpreter = ["/bin/bash"]
  }
}
