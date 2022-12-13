output "id" {
  description = "The ID of the instance"
  value       = element(concat(module.ec2_instance.*.id, [""]), 0 )
}

output "arn" {
  description = "The ARN of the instance"
  value       =  element(concat(module.ec2_instance.*.arn, [""]), 0)
}