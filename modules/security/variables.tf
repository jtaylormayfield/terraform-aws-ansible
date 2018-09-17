variable "enabled" {
  description = "If true, uses 'inbound_rules' and 'outbound_rules' to construct a security group."
}

variable "inbound_rules" {
  description = "Canned inbound security group rules. If 'all' is a value in the list, all ports will be open. Other values include 'http', 'https', 'ssh', and 'eph'."
  type        = "list"
}

variable "outbound_rules" {
  description = "Canned outbound security group rules. If 'all' is a value in the list, all ports will be open. Other values include 'http', 'https', 'ssh', and 'eph'."
  type        = "list"
}

variable "tag_env" {
  description = "Environment tag value."
}

variable "tag_name" {
  description = "Name tag value."
}

variable "vpc_id" {
  description = "VPC ID."
}
