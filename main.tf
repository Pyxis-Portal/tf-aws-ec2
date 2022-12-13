locals {
  tags = {
    terraform = true
    name      = var.ec2_name
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.3.0"

  count = var.create_ec2 ? 1 : 0

  name                        = var.ec2_name
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_key_name != null ? var.ec2_key_name : element(concat(aws_key_pair.this.*.key_name, [""]), 0)
  monitoring                  = var.ec2_monitoring
  vpc_security_group_ids      = var.ec2_vpc_security_group_ids != null ? var.ec2_vpc_security_group_ids : [element(concat(aws_security_group.ec2_sg.*.id, [""]), 0)]
  subnet_id                   = var.ec2_subnet_id
  user_data                   = var.ec2_user_data
  user_data_base64            = var.ec2_user_data != null ? null : var.ec2_user_data_base64
  hibernation                 = var.ec2_hibernation
  availability_zone           = var.ec2_availability_zone
  iam_instance_profile        = aws_iam_instance_profile.this.id
  associate_public_ip_address = var.ec2_associate_public_ip_address
  private_ip                  = var.ec2_private_ip
  secondary_private_ips       = var.ec2_secondary_private_ips
  ipv6_address_count          = var.ec2_ipv6_address_count
  ipv6_addresses              = var.ec2_ipv6_addresses
  ebs_optimized               = var.ec2_ebs_optimized
  root_block_device           = var.ec2_ebs_block_device

  tags = merge(
    local.tags,
    var.tags
  )

  volume_tags = merge(
    local.tags,
    var.tags
  )
}

resource "aws_iam_instance_profile" "this" {
  name = var.ec2_name
  role = aws_iam_role.this.id
}

resource "aws_key_pair" "this" {
  count = var.create_key_pair ? 1 : 0

  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "ec2_sg" {
  count = var.create_sg ? 1 : 0

  name        = "${var.ec2_name}-ec2"
  description = "Security Group for ${var.ec2_name} ec2"
  vpc_id      = var.sg_vpc_id

  dynamic "ingress" {
    for_each = var.ec2_sg_ingress_rules

    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      cidr_blocks = ingress.value["cidr_blocks"]
      protocol    = ingress.value["protocol"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    var.tags
  )
}

data "aws_iam_policy_document" "policy_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.ec2_name}-role"
  assume_role_policy = data.aws_iam_policy_document.policy_role.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  count      = var.create_attachment_rol ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = element(concat(aws_iam_policy.this.*.arn, [""]), 0)
}

resource "aws_iam_policy" "this" {
  count       = var.create_attachment_rol && var.create_policy ? 1 : 0
  name        = "${var.ec2_name}-policy"
  description = "A policy for ec2 bastion"
  policy      = var.policy_json
}

resource "aws_launch_template" "this" {
  count = var.create_lauch_template ? 1 : 0

  name_prefix   = var.name_lauch_template
  ebs_optimized = var.ec2_ebs_optimized
  instance_type = var.ec2_instance_type
  image_id      = var.ec2_ami
  key_name      = var.ec2_key_name != null ? var.ec2_key_name : element(concat(aws_key_pair.this.*.key_name, [""]), 0)
  user_data     = var.ec2_user_data_base64

  iam_instance_profile {
    name = aws_iam_instance_profile.this.id
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = var.ec2_associate_public_ip_address
    delete_on_termination       = true
    security_groups             = var.ec2_vpc_security_group_ids != null ? var.ec2_vpc_security_group_ids : [element(concat(aws_security_group.ec2_sg.*.id, [""]), 0)]
  }

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", null) == null ? [] : ["ebs"]
        content {
          delete_on_termination = lookup(block_device_mappings.value.ebs, "delete_on_termination", null)
          encrypted             = lookup(block_device_mappings.value.ebs, "encrypted", null)
          iops                  = lookup(block_device_mappings.value.ebs, "iops", null)
          kms_key_id            = lookup(block_device_mappings.value.ebs, "kms_key_id", null)
          snapshot_id           = lookup(block_device_mappings.value.ebs, "snapshot_id", null)
          volume_size           = lookup(block_device_mappings.value.ebs, "volume_size", null)
          volume_type           = lookup(block_device_mappings.value.ebs, "volume_type", null)
        }
      }
    }
  }

  dynamic "instance_market_options" {
    for_each = var.instance_market_options != null ? [var.instance_market_options] : []
    content {
      market_type = lookup(instance_market_options.value, "market_type", null)

      dynamic "spot_options" {
        for_each = (instance_market_options.value.spot_options != null ?
        [instance_market_options.value.spot_options] : [])
        content {
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.tags,
      var.tags
    )
  }

  tags = merge(
    local.tags,
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  count = var.create_lauch_template && var.autoscaling_name != "" ? 1 : 0

  name                = var.autoscaling_name
  vpc_zone_identifier = var.autoscaling_subnets
  max_size            = var.autoscaling_max_size
  min_size            = var.autoscaling_min_size
  desired_capacity    = var.autoscaling_desired_capacity
  #termination_policies    = var.termination_policies
  #enabled_metrics         = var.enabled_metrics
  #service_linked_role_arn = var.service_linked_role_arn

  launch_template {
    id      = element(concat(aws_launch_template.this.*.id, [""]), 0)
    version = element(concat(aws_launch_template.this.*.latest_version, [""]), 0)
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}

resource "aws_autoscaling_schedule" "up" {
  count                  = var.create_lauch_template ? 1 : 0
  scheduled_action_name  = "up"
  min_size               = var.autoscaling_max_size
  max_size               = var.autoscaling_min_size
  desired_capacity       = var.autoscaling_desired_capacity
  recurrence             = var.up_recurrence
  start_time             = var.up_star_time
  end_time               = var.up_end_time
  autoscaling_group_name = element(concat(aws_autoscaling_group.this.*.name, [""]), 0)
}

resource "aws_autoscaling_schedule" "down" {
  count                  = var.create_lauch_template ? 1 : 0
  scheduled_action_name  = "down"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.down_recurrence
  start_time             = var.down_star_time
  end_time               = var.down_end_time
  autoscaling_group_name = element(concat(aws_autoscaling_group.this.*.name, [""]), 0)
}