output user_data_bastion {
  value = element(concat(data.template_file.user_data_bastion.*.rendered, [""]), 0)
}