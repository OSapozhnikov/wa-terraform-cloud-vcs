output "instance_name" {
  description = "Instance name"
  value       = aws_instance.wa_demo_instance.tags
  precondition {
    condition     = aws_instance.wa_demo_instance.tags["Name"] != null && aws_instance.wa_demo_instance.tags["Name"] != ""
    error_message = "The instance must be named."
  }
}

output "instance_public_ip" {
  description = "Instance public IP"
  value       = aws_instance.wa_demo_instance.public_ip
}