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

output id_security_group {
  value       = element(concat(aws_security_group.ec2_sg.*.id , [""]), 0)
}
