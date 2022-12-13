locals {
  tags = {
    terraform = true
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.3.0"

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
  root_block_device            = var.ec2_ebs_block_device

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
  count       = var.create_sg ? 1 : 0
  name        = "${var.ec2_name}-ec2 "
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