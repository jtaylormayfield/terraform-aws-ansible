variable "ami_id" {
  default     = "ami-9c0638f9"                                                # CentOS 1805 in us-east-2
  description = "Amazon Machine Image ID used to provision the EC2 instance."
}

variable "ansible_pipelining" {
  default     = false
  description = "If true, execute many Ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled, but requires the AMI to be setup correctly."
}

variable "bypass_fingerprint" {
  default     = false
  description = "If `true`, bypass host fingerprint checking during configuration."
}

variable "ec2_ini_path" {
  default     = "/etc/ansible/ec2.ini"
  description = "A path to the configuration file used for Ansible EC2 dynamic inventory. See: https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py for more information."
}

variable "generate_key" {
  default     = true
  description = "If true, use a local key pair to generate a provision key in AWS."
}

variable "generate_security_groups" {
  default     = true
  description = "If true, uses `inbound_rules` and `outbound_rules` to construct a security group."
}

variable "global_ansible_extra_vars" {
  default     = []
  description = "Array of variables that will always be passed as extra vars."
  type        = "list"
}

variable "inbound_rules" {
  default     = ["all"]
  description = "Canned inbound security group rules. Ignored if `generate_security_groups` is `false`. If `all` is a value in the list, all ports will be open. Other values include `icmp`, `http`, `https`, `ssh`, `eph`, `nat`, `mysql`, `pgsql`, and `oracle`."
  type        = "list"
}

variable "instance_type" {
  default     = "t3.micro"           # 2x1 burstable
  description = "EC2 instance type."
}

variable "instance_var_name" {
  default     = "instance_ids"
  description = "Name of the extra variable used to identify the playbook inventory."
}

variable "jump_spec" {
  default = {
    bypass_fingerprint = false
    host               = ""
    key_path           = ""
    user               = ""
  }

  description = "Jump host specification map. Ignored if the `host` key is not specified or its value is empty."
  type        = "map"
}

variable "key_name" {
  default     = "deployer-key"
  description = "Name of the generated deployment key."
}

variable "outbound_rules" {
  default     = ["http", "https", "icmp"]
  description = "Canned outbound security group rules. Ignored if `generate_security_groups` is `false`. If `all` is a value in the list, all ports will be open. Other values include `icmp`, `http`, `https`, `ssh`, `eph`, `nat`, `mysql`, `pgsql`, and `oracle`."
  type        = "list"
}

variable "playbook_file" {
  default     = "site.yml"
  description = "File name of the playbook (i.e. `site.yml`)."
}

variable "playbook_profile" {
  default     = "default"
  description = "File name of the playbook (i.e. `site.yml`)."
}

variable "playbook_user" {
  default     = "centos"
  description = "User account to use during configuration."
}

variable "playbooks" {
  default     = ["http://54.68.126.240/apache"] # Simple apache
  description = "List of playbook Git URLs."
  type        = "list"
}

variable "private_key_path" {
  default     = "~/.ssh/id_rsa"
  description = "Local path to a private key file to use during configuration."
}

variable "project_environment" {
  default     = "default"
  description = "Environment tag value."
}

variable "project_name" {
  description = "Name tag value."
}

variable "public_key_path" {
  default     = "~/.ssh/id_rsa.pub"
  description = "Local path to a public key file to use during provisioning."
}

variable "sg_ids" {
  default     = []
  description = "Preconfigured security group IDs."
  type        = "list"
}

variable "subnet_id" {
  description = "ID of the subnet in which the EC2 instance will be placed."
}

variable "volume_size" {
  default     = "8"
  description = "Size (in GB) of volume to create for the root block device."
}

variable "volume_type" {
  default     = "gp2"
  description = "Type of volume to create for the root block device. Valid options are `standard` and `gp2`."
}

variable "wait_hook" {
  default     = ""
  description = "Provision process will wait on this variable."
}
