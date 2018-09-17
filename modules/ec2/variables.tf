variable "ami_id" {
  description = "Amazon Machine Image ID used to provision the EC2 instance."
}

variable "instance_type" {
  description = "EC2 instance type."
}

variable "playbooks" {
  description = "List of playbook descriptors containing a valid Git URL to a playbook, name of local copy, extra variables, user, and key file."
  type = "list"
  default = [
    {
      git_url = ""
      local_name = ""
      extra_vars = ""
      user = ""
      key_file = ""
    }
  ]
}

variable "public_key_path" {
  description = "Local path to a public key file to use during provisioning."
}

variable "sg_ids" {
  description = "Security group IDs."
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
