variable "ec2_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = ""
}

variable "ec2_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-0ed9277fb7eb570c9"
}

variable "ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "ec2_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "ec2_vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "ec2_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "ec2_user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "ec2_user_data_base64" {
  description = "Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "ec2_hibernation" {
  description = "If true, the launched EC2 instance will support hibernation"
  type        = bool
  default     = false
}

variable "ec2_availability_zone" {
  description = "AZ to start the instance in"
  type        = string
}


variable "ec2_associate_public_ip_address" {
  description = "Whether to associate a public IP address with an instance in a VPC"
  type        = bool
  default     = false
}

variable "ec2_private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "ec2_secondary_private_ips" {
  description = "A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a `network_interface block`"
  type        = list(string)
  default     = null
}

variable "ec2_ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet"
  type        = number
  default     = null
}

variable "ec2_ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "ec2_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "ec2_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = any
  default     = []
}

variable "create_key_pair" {
  type        = bool
  default     = false
  description = "if true, enable create key pair"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "The name for the key pair."
}

variable "public_key" {
  type        = string
  default     = ""
  description = "The public key material."
}


variable "create_sg" {
  type        = string
  default     = ""
  description = "if true, enable create security gruop"
}

variable "ec2_sg_ingress_rules" {
  type        = any
  default     = []
  description = "all configuration for rules ingress of security group"
}

variable "tags" {
  type        = any
  default     = null
  description = "all tags for all recursives"
}

variable "create_attachment_rol" {
  type        = bool
  default     = false
  description = "if true, enable create attachment rol"
}

variable "create_policy" {
  type        = bool
  default     = false
  description = "if true, enable create rol"
}

variable "policy_json" {
  type        = string
  default     = null
  description = ""
}

variable "sg_vpc_id" {
  type        = string
  default     = ""
  description = ""
}

variable "name_lauch_template" {
  type        = string
  default     = ""
  description = "description"
}

variable autoscaling_name {
  type        = string
  default     = ""
  description = "description"
}

variable up_star_time {
  type        = string
  default     = ""
  description = "description"
}

variable up_end_time {
  type        = string
  default     = ""
  description = "description"
}

variable down_star_time {
  type        = string
  default     = ""
  description = "description"
}

variable down_end_time {
  type        = string
  default     = ""
  description = "description"
}















variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"

  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}

variable "instance_market_options" {
  description = "The market (purchasing) option for the instances"

  type = object({
    market_type = string
    spot_options = object({
      block_duration_minutes         = number
      instance_interruption_behavior = string
      max_price                      = number
      spot_instance_type             = string
      valid_until                    = string
    })
  })

  default = null
}