output user_data_bastion {
  value = element(concat(data.template_file.user_data_bastion.*.rendered, [""]), 0)
}

output policy_bastion_general {
  value = element(concat(data.aws_iam_policy_document.bastion_general.*.json, [""]), 0)
}