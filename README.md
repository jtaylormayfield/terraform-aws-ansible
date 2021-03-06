# terraform-aws-ansible
A Terraform module that uses Ansible to configure EC2 instances in AWS.


## Inputs

| Name | Description | Type | Default |
|------|-------------|:----:|:-----:|
| ami_id | Amazon Machine Image ID used to provision the EC2 instance. | string | `ami-9c0638f9` |
| ansible_pipelining | If true, execute many Ansible modules without actual file transfer. This can result in a very significant performance improvement when enabled, but requires the AMI to be setup correctly. | string | `false` |
| bypass_fingerprint | If `true`, bypass host fingerprint checking during configuration. | string | `false` |
| ec2_ini_path | A path to the configuration file used for Ansible EC2 dynamic inventory. See: https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py for more information. | string | `/etc/ansible/ec2.ini` |
| generate_key | If true, use a local key pair to generate a provision key in AWS. | string | `true` |
| generate_security_groups | If true, uses `inbound_rules` and `outbound_rules` to construct a security group. | string | `true` |
| global_ansible_extra_vars | Array of variables that will always be passed as extra vars. | list | `[]` |
| inbound_rules | Canned inbound security group rules. Ignored if `generate_security_groups` is `false`. If `all` is a value in the list, all ports will be open. Other values include `icmp`, `http`, `https`, `ssh`, `eph`, `nat`, `mysql`, `pgsql`, and `oracle`. | list | `[ "all" ]` |
| instance_type | EC2 instance type. | string | `t3.micro` |
| instance_var_name | Name of the extra variable used to identify the playbook inventory. | string | `instance_ids` |
| jump_spec | Jump host specification map. Ignored if the `host` key is not specified or its value is empty. | map | `{ "bypass_fingerprint": false, "host": "", "key_path": "", "user": "" }` |
| key_name | Name of the generated deployment key. | string | `deployer-key` |
| outbound_rules | Canned outbound security group rules. Ignored if `generate_security_groups` is `false`. If `all` is a value in the list, all ports will be open. Other values include `icmp`, `http`, `https`, `ssh`, `eph`, `nat`, `mysql`, `pgsql`, and `oracle`. | list | `[ "http", "https", "icmp" ]` |
| playbook_file | File name of the playbook (i.e. `site.yml`). | string | `site.yml` |
| playbook_profile | File name of the playbook (i.e. `site.yml`). | string | `default` |
| playbook_user | User account to use during configuration. | string | `centos` |
| playbooks | List of playbook Git URLs. | list | `[ "http://54.68.126.240/apache" ]` |
| private_key_path | Local path to a private key file to use during configuration. | string | `~/.ssh/id_rsa` |
| project_environment | Environment tag value. | string | `default` |
| project_name | Name tag value. | string | - |
| public_key_path | Local path to a public key file to use during provisioning. | string | `~/.ssh/id_rsa.pub` |
| sg_ids | Preconfigured security group IDs. | list | `[]` |
| subnet_id | ID of the subnet in which the EC2 instance will be placed. | string | - |
| volume_size | Size (in GB) of volume to create for the root block device. | string | `8` |
| volume_type | Type of volume to create for the root block device. Valid options are `standard` and `gp2`. | string | `gp2` |
| wait_hook | Provision process will wait on this variable. | string | `` |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | - |
| key_name | - |
| public_hostname | - |
| security_group_ids | - |

