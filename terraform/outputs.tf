output "vpc_id" {
  description = "ID of the Dream Vacation VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "security_group_id" {
  description = "ID of the application security group"
  value       = aws_security_group.app.id
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "ec2_public_ip" {
  description = "Public IP address of the application EC2 instance"
  value       = aws_instance.app.public_ip
}
