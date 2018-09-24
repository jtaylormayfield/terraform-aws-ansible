variable "ami_id" {
  description = "Amazon Machine Image ID used to provision the EC2 instance."
}

variable "ansible_pipelining" {
  description = "If true, execute many Ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled, but requires the AMI to be setup correctly."
}

variable "bypass_fingerprint" {
  description = "If 'true', bypass host fingerprint checking during configuration."
}

variable "ec2_ini_path" {
  description = "A path to the configuration file used for Ansible EC2 dynamic inventory. See: https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py for more information."
}

variable "generate_key" {
  description = "If true, use a local key pair to generate a provision key in AWS."
}

variable "global_ansible_extra_var" {
  description = "Array of variables that will always be passed as extra vars."
  type        = "list"
}

variable "instance_type" {
  description = "EC2 instance type."
}

variable "instance_var_name" {
  description = "Name of the extra variable used to identify the playbook inventory."
}

variable "jump_bypass_fingerprint" {
  description = "Bypass jump host fingerprint check. Ignored if 'jump_host' is empty."
}

variable "jump_host" {
  description = "Host to use to jump the SSH connection over (i.e. for private subnets). Ignored if empty."
}

variable "jump_key_path" {
  description = "Private key path for jump host. Ignored if 'jump_host' is empty."
}

variable "jump_user" {
  description = "User for jump host. Ignored if 'jump_host' is empty."
}

variable "key_name" {
  description = "Name of the deployment key."
}

variable "playbooks" {
  description = "List of playbook Git URLs."
  type        = "list"
}

variable "playbook_file" {
  description = "File name of the playbook (i.e. 'site.yml')."
}

variable "playbook_profile" {
  description = "AWS profile to use during Ansible configuration."
}

variable "playbook_user" {
  description = "User account to use during configuration."
}

variable "private_key_path" {
  description = "Local path to a private key file to use during configuration."
}

variable "public_key_path" {
  description = "Local path to a public key file to use during provisioning."
}

variable "sg_ids" {
  description = "Security group IDs."
  type        = "list"
}

variable "subnet_id" {
  description = "ID of the subnet in which the EC2 instance will be placed."
}

variable "tag_env" {
  description = "Environment tag value."
}

variable "tag_name" {
  description = "Name tag value."
}

variable "volume_size" {
  description = "Size (in GB) of volume to create for the root block device."
}

variable "volume_type" {
  description = "Type of volume to create for the root block device. Valid options are 'standard' and 'gp2'."
}

variable "wait_hook" {
  description = "Provision process will wait on this variable."
}
