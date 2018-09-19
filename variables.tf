variable "ami_id" {
  default     = "ami-9c0638f9"                                                # CentOS 1805 in us-east-2
  description = "Amazon Machine Image ID used to provision the EC2 instance."
}

variable "generate_key" {
  default     = true
  description = "If true, use a local key pair to generate a provision key in AWS."
}

variable "inbound_rules" {
  default     = ["all"]
  description = "Canned inbound security group rules. If 'all' is a value in the list, all ports will be open. Other values include 'http', 'https', 'ssh', and 'eph'."
  type        = "list"
}

variable "instance_type" {
  default     = "t3.micro"           # 2x1 burstable
  description = "EC2 instance type."
}

variable "instance_var_name" {
  default     = "aws_instance_ids"
  description = "Name of the extra variable used to identify the playbook inventory."
}

variable "key_name" {
  default     = "deployer-key"
  description = "Name of the generated deployment key."
}

variable "outbound_rules" {
  default     = ["http", "https", "icmp"]
  description = "Canned outbound security group rules. If 'all' is a value in the list, all ports will be open. Other values include 'http', 'https', 'ssh', and 'eph'."
  type        = "list"
}

variable "playbook_file" {
  default     = "site.yml"
  description = "File name of the playbook (i.e. 'site.yml')."
}

variable "playbook_profile" {
  default     = "default"
  description = "File name of the playbook (i.e. 'site.yml')."
}

variable "playbook_system" {
  default     = "linux"
  description = "OS of system running ansible. Only supported value is 'linux'."
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

variable "security_enabled" {
  default     = true
  description = "If true, uses 'inbound_rules' and 'outbound_rules' to construct a security group."
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
  description = "Type of volume to create for the root block device. Valid options are 'standard' and 'gp2'."
}
