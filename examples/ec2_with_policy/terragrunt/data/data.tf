data "template_file" "user_data_bastion" {
  count    = var.create_user_data_bastion ? 1 : 0
  template = file("${path.module}/users_data/user_data_bastion_general.sh")
}

data "aws_iam_policy_document" "bastion_general" {
  count = var.create_policy_bastion_general ? 1 : 0

  statement {
    sid = "1"

    actions = [
      "secretsmanager:*",
    ]

    resources = var.bastion_general_resources
  }
}
