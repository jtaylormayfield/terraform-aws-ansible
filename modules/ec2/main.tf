resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "default" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.deployer.id}"
  vpc_security_group_ids = ["${split(",", join(",", var.sg_ids))}"] # Workaround hashicorp/terraform#13103
  subnet_id              = "${var.subnet_id}"

  # Workaround bug with AWS provider and the new T3 instance types.
  credit_specification {
    cpu_credits = "unlimited"
  }

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
    git_cmds  = "${join(" & ", formatlist("git clone %s ${path.cwd}/%s", var.playbooks, random_id.repo_id.*.b64_url))}"
    play_cmds = "${join(" && ",formatlist("ansible-playbook ${path.cwd}/%s/site.yml --extra-vars \"aws_instance_ids=${aws_instance.default.id}\" --user %s --key-file %s", random_id.repo_id.*.b64_url, var.playbook_user, var.private_key_path))}"
  }
}

resource "null_resource" "default" {
  triggers {
    instance_id = "${aws_instance.default.id}"
  }

  provisioner "local-exec" {
    command = "${data.template_file.ansible.rendered}"
  }
}
