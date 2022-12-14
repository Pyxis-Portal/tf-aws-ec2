data "template_file" "user_data_bastion" {
  count    = var.create_user_data_bastion ? 1 : 0
  template = filebase64("${path.module}/users_data/user_data_bastion_general.sh")
}