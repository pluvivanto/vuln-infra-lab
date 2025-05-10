output "my_ip_detected" {
  value = local.my_ip_raw
}

output "my_ip_cidr" {
  value = local.my_ip_cidr
}

output "instance_public_ip" {
  description = "Public IP of the Juice Shop EC2 instance"
  value       = aws_instance.juiceshop.public_ip
}

output "ssh_command" {
  description = "SSH command with PEM"
  value       = "ssh -i juice-lab-kp.pem ubuntu@${aws_instance.juiceshop.public_ip}"
}
