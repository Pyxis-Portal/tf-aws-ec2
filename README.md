<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_instance"></a> [ec2\_instance](#module\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | 3.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_schedule.down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.test-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.ec2_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_iam_policy_document.policy_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_desired_capacity"></a> [autoscaling\_desired\_capacity](#input\_autoscaling\_desired\_capacity) | description | `number` | `1` | no |
| <a name="input_autoscaling_max_size"></a> [autoscaling\_max\_size](#input\_autoscaling\_max\_size) | description | `number` | `1` | no |
| <a name="input_autoscaling_min_size"></a> [autoscaling\_min\_size](#input\_autoscaling\_min\_size) | description | `number` | `1` | no |
| <a name="input_autoscaling_name"></a> [autoscaling\_name](#input\_autoscaling\_name) | description | `string` | `""` | no |
| <a name="input_autoscaling_subnets"></a> [autoscaling\_subnets](#input\_autoscaling\_subnets) | description | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | Specify volumes to attach to the instance besides the volumes specified by the AMI | <pre>list(object({<br>    device_name  = string<br>    no_device    = bool<br>    virtual_name = string<br>    ebs = object({<br>      delete_on_termination = bool<br>      encrypted             = bool<br>      iops                  = number<br>      kms_key_id            = string<br>      snapshot_id           = string<br>      volume_size           = number<br>      volume_type           = string<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_create_attachment_rol"></a> [create\_attachment\_rol](#input\_create\_attachment\_rol) | if true, enable create attachment rol | `bool` | `false` | no |
| <a name="input_create_autoscaling_group"></a> [create\_autoscaling\_group](#input\_create\_autoscaling\_group) | n/a | `bool` | `false` | no |
| <a name="input_create_ec2"></a> [create\_ec2](#input\_create\_ec2) | description | `bool` | `false` | no |
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_create_key_pair"></a> [create\_key\_pair](#input\_create\_key\_pair) | if true, enable create key pair | `bool` | `false` | no |
| <a name="input_create_lauch_template"></a> [create\_lauch\_template](#input\_create\_lauch\_template) | description | `bool` | `false` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | if true, enable create rol | `bool` | `false` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | n/a | `bool` | `false` | no |
| <a name="input_create_sg"></a> [create\_sg](#input\_create\_sg) | if true, enable create security gruop | `bool` | `false` | no |
| <a name="input_down_end_time"></a> [down\_end\_time](#input\_down\_end\_time) | description | `string` | `null` | no |
| <a name="input_down_recurrence"></a> [down\_recurrence](#input\_down\_recurrence) | description | `string` | `""` | no |
| <a name="input_down_star_time"></a> [down\_star\_time](#input\_down\_star\_time) | description | `string` | `"2014-06-01T00:00:00Z"` | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | ID of AMI to use for the instance | `string` | n/a | yes |
| <a name="input_ec2_associate_public_ip_address"></a> [ec2\_associate\_public\_ip\_address](#input\_ec2\_associate\_public\_ip\_address) | Whether to associate a public IP address with an instance in a VPC | `bool` | `false` | no |
| <a name="input_ec2_availability_zone"></a> [ec2\_availability\_zone](#input\_ec2\_availability\_zone) | AZ to start the instance in | `string` | `null` | no |
| <a name="input_ec2_ebs_block_device"></a> [ec2\_ebs\_block\_device](#input\_ec2\_ebs\_block\_device) | Additional EBS block devices to attach to the instance | `any` | `[]` | no |
| <a name="input_ec2_ebs_optimized"></a> [ec2\_ebs\_optimized](#input\_ec2\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| <a name="input_ec2_hibernation"></a> [ec2\_hibernation](#input\_ec2\_hibernation) | If true, the launched EC2 instance will support hibernation | `bool` | `false` | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | The type of instance to start | `string` | n/a | yes |
| <a name="input_ec2_ipv6_address_count"></a> [ec2\_ipv6\_address\_count](#input\_ec2\_ipv6\_address\_count) | A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet | `number` | `null` | no |
| <a name="input_ec2_ipv6_addresses"></a> [ec2\_ipv6\_addresses](#input\_ec2\_ipv6\_addresses) | Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface | `list(string)` | `null` | no |
| <a name="input_ec2_key_name"></a> [ec2\_key\_name](#input\_ec2\_key\_name) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `null` | no |
| <a name="input_ec2_monitoring"></a> [ec2\_monitoring](#input\_ec2\_monitoring) | If true, the launched EC2 instance will have detailed monitoring enabled | `bool` | `false` | no |
| <a name="input_ec2_name"></a> [ec2\_name](#input\_ec2\_name) | Name to be used on EC2 instance created. | `string` | n/a | yes |
| <a name="input_ec2_private_ip"></a> [ec2\_private\_ip](#input\_ec2\_private\_ip) | Private IP address to associate with the instance in a VPC | `string` | `null` | no |
| <a name="input_ec2_secondary_private_ips"></a> [ec2\_secondary\_private\_ips](#input\_ec2\_secondary\_private\_ips) | A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block` | `list(string)` | `null` | no |
| <a name="input_ec2_sg_ingress_rules"></a> [ec2\_sg\_ingress\_rules](#input\_ec2\_sg\_ingress\_rules) | all configuration for rules ingress of security group | `any` | `[]` | no |
| <a name="input_ec2_subnet_id"></a> [ec2\_subnet\_id](#input\_ec2\_subnet\_id) | The VPC Subnet ID to launch in. REQUIRED IF create\_ec2 = True | `string` | `null` | no |
| <a name="input_ec2_user_data"></a> [ec2\_user\_data](#input\_ec2\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| <a name="input_ec2_user_data_base64"></a> [ec2\_user\_data\_base64](#input\_ec2\_user\_data\_base64) | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| <a name="input_ec2_vpc_security_group_ids"></a> [ec2\_vpc\_security\_group\_ids](#input\_ec2\_vpc\_security\_group\_ids) | A list of security group IDs to associate with | `list(string)` | `null` | no |
| <a name="input_instance_market_options"></a> [instance\_market\_options](#input\_instance\_market\_options) | The market (purchasing) option for the instances | <pre>object({<br>    market_type = string<br>    spot_options = object({<br>      block_duration_minutes         = number<br>      instance_interruption_behavior = string<br>      max_price                      = number<br>      spot_instance_type             = string<br>      valid_until                    = string<br>    })<br>  })</pre> | `null` | no |
| <a name="input_instance_profile_role"></a> [instance\_profile\_role](#input\_instance\_profile\_role) | description | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name for the key pair. | `string` | `""` | no |
| <a name="input_name_lauch_template"></a> [name\_lauch\_template](#input\_name\_lauch\_template) | description | `string` | `""` | no |
| <a name="input_policy_json"></a> [policy\_json](#input\_policy\_json) | n/a | `string` | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key material. | `string` | `""` | no |
| <a name="input_sg_vpc_id"></a> [sg\_vpc\_id](#input\_sg\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | all tags for all recursives | `any` | `null` | no |
| <a name="input_up_end_time"></a> [up\_end\_time](#input\_up\_end\_time) | description | `string` | `null` | no |
| <a name="input_up_recurrence"></a> [up\_recurrence](#input\_up\_recurrence) | description | `string` | `""` | no |
| <a name="input_up_star_time"></a> [up\_star\_time](#input\_up\_star\_time) | description | `string` | `"2014-06-01T00:00:00Z"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the instance |
| <a name="output_id"></a> [id](#output\_id) | The ID of the instance |
<!-- END_TF_DOCS -->