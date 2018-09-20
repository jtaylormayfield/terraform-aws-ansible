locals {
  sg_fmt = "%s_%s"

  inbound_open  = "${contains(var.inbound_rules, "all")}"
  outbound_open = "${contains(var.outbound_rules, "all")}"

  tag_prefix_name = "${var.tag_name}-security"

  tcp_rules = {
    all_from    = "0"
    all_to      = "65535"
    icmp_from   = "-1"
    icmp_to     = "-1"
    http_from   = "80"
    http_to     = "80"
    https_from  = "443"
    https_to    = "443"
    ssh_from    = "22"
    ssh_to      = "22"
    eph_from    = "32768"
    eph_to      = "65535"
    nat_from    = "1024"
    nat_to      = "65535"
    mysql_from  = "3306"
    mysql_to    = "3306"
    pgsql_from  = "5432"
    pgsql_to    = "5432"
    oracle_from = "1521"
    oracle_to   = "1521"
  }
}

resource "aws_security_group" "default" {
  count  = "${var.enabled ? 1 : 0}"
  vpc_id = "${var.vpc_id}"

  tags {
    Environment = "${var.tag_env}"
    Name        = "${local.tag_prefix_name}"
  }
}

resource "aws_security_group_rule" "inbound" {
  count             = "${!var.enabled ? 0 : local.inbound_open ? "1" : length(var.inbound_rules)}"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "${local.inbound_open ? "all" : var.inbound_rules[count.index] == "icmp" ? "icmp" : "tcp"}"
  from_port         = "${lookup(local.tcp_rules, format(local.sg_fmt, var.inbound_rules[count.index], "from"))}"
  to_port           = "${lookup(local.tcp_rules, format(local.sg_fmt, var.inbound_rules[count.index], "to"))}"
  security_group_id = "${aws_security_group.default.*.id[0]}"
  type              = "ingress"
}

resource "aws_security_group_rule" "outbound" {
  count             = "${!var.enabled ? 0 : local.outbound_open ? "1" : length(var.outbound_rules)}"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "${local.outbound_open ? "all" : var.outbound_rules[count.index] == "icmp" ? "icmp" : "tcp"}"
  from_port         = "${lookup(local.tcp_rules, format(local.sg_fmt, var.outbound_rules[count.index], "from"))}"
  to_port           = "${lookup(local.tcp_rules, format(local.sg_fmt, var.outbound_rules[count.index], "to"))}"
  security_group_id = "${aws_security_group.default.*.id[0]}"
  type              = "egress"
}
