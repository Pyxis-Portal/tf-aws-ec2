locals {
  name_instance = var.create_lauch_template ? var.ec2_name : ""
}

output "id" {
  description = "The ID of the instance"
  value       = element(concat(module.ec2_instance.*.id, [""]), 0)
}

output "arn" {
  description = "The ARN of the instance"
  value       = element(concat(module.ec2_instance.*.arn, [""]), 0)
}

output "ip" {
  description = "The ARN of the instance"
  value       = element(concat(module.ec2_instance.*.public_ip, [""]), 0)
}

output "public_dns" {
  description = "The ARN of the instance"
  value       = element(concat(module.ec2_instance.*.public_dns, [""]), 0)
}

output "id_security_group" {
  value = element(concat(aws_security_group.ec2_sg.*.id, [""]), 0)
}



output "name_autoscaling" {
  description = "Name of the Auto Scaling Group"
  value = element(concat(aws_autoscaling_group.this.*.name, [""]), 0)
}


output "name_instance" {
  # Names are not sensitive
  value       = local.name_instance
  description = "Name of instance create for only bastion and ASG"
}
