locals {
  globals = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

include {
  path = find_in_parent_folders()
}

dependency "data" {
  config_path = "../data"
}

terraform {
  source = ""
}

inputs = {
  create_ec2                      = true
  ec2_associate_public_ip_address = true
  create_key_pair                 = true
  create_sg                       = true
  ec2_name                        = "example"
  ec2_instance_type               = "t3.medium"
  ec2_subnet_id                   = "subnet-xxxxx"
  ec2_availability_zone           = "us-east-1a"
  sg_vpc_id                       = "vpc-xxxx"
  key_name                        = "example"
  public_key                      = "****************************************"
  ec2_user_data                   = dependency.data.outputs.user_data_bastion

  ec2_ebs_block_device = [
    {
      delete_on_termination = true
      device_name           = "/dev/sdh"
      volume_size           = 30
    }
  ]

  ec2_sg_ingress_rules = [
    {
      description = "load blancer"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    }
]