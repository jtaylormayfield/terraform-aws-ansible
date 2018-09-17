locals {
  playbook_urls = "${var.playbooks}"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.deployer.id}"
  vpc_security_group_ids = "${var.sg_ids}"
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
  template = "${file("${path.module}/play.tpl")}"

  vars {
    git_cmds  = "${formatlist("git clone %s %s", var.playbooks, random_id.repo_id.*.b64_url)}"
    play_cmds = "${formatlist("ansible-playbook %s/site.yml --extra-vars \"instance_ids=${aws_instance.default.id}\" --user %s --key-file %s", random_id.repo_id.*.b64_url, var.playbook_user, var.private_key_path)}"
  }
}

resource "local_file" "ansible" {
  content  = "${data.template_file.ansible.rendered}"
  filename = "play.sh"
}

resource "null_resource" "default" {
  depends_on = ["local_file.ansible"]

  triggers {
    instance_id = "${aws_instance.default.id}"
  }

  provisioner "local-exec" {
    command = "play.sh"
  }
}
