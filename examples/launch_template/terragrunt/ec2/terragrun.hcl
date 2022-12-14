locals {
  globals = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
}

include {
  path = find_in_parent_folders()
}

dependency "data" {
  config_path = "../data+"
}

terraform {
  source = "../../../../resources/submodule/infra-devops-tf-aws-bastion"
}

inputs = {
  create_lauch_template           = true
  ec2_associate_public_ip_address = true
  create_key_pair                 = true
  create_sg                       = true
  name_lauch_template             = "example"
  autoscaling_name                = "example"
  ec2_name                        = "example"
  key_name                        = "example" 
  ec2_instance_type               = "m5a.xlarge"
  autoscaling_subnets             = ["subnet-xxxxx"]
  sg_vpc_id                       = "vpc-xxx"
  public_key                      = "**************************"
  up_star_time                    = "2022-03-25T07:00:00Z"
  down_star_time                  = "2022-03-25T07:15:00Z"
  up_recurrence                   = "0 7 * * *"
  down_recurrence                 = "30 7 * * *"
  ec2_user_data_base64            = dependency.data.outputs.user_data_bastion

  block_device_mappings = [
    {
      device_name  = "/dev/xvda"
      no_device    = null
      virtual_name = null
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 120
        volume_type           = "gp2"
        iops                  = null
        kms_key_id            = null
        snapshot_id           = null
      }
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

}