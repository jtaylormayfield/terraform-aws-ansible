variable "ami_id" {
  description = "Amazon Machine Image ID used to provision the EC2 instance."
}

variable "generate_key" {
  description = "If true, use a local key pair to generate a provision key in AWS."
}

variable "instance_type" {
  description = "EC2 instance type."
}

variable "instance_var_name" {
  description = "Name of the extra variable used to identify the playbook inventory."
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

variable "playbook_system" {
  description = "OS of system running ansible. Only supported value is 'linux'."
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

variable "remote_config" {
  description = "Configure instance from a remote location."
}

variable "remote_config_host" {
  description = "Remote host used to run configuration."
}

variable "remote_config_host_key" {
  description = "Remote host used to run configuration."
}

variable "remote_config_private_key" {
  description = "Remote host used to run configuration."
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
