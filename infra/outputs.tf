output "my_ip_detected" {
  value = local.my_ip_raw
}

output "my_ip_cidr" {
  value = local.my_ip_cidr
}

output "ec2_public_ip" {
  value = aws_eip.juice_ip.public_ip
}

output "ssh_command" {
  description = "SSH command with PEM"
  value       = "ssh -i juice-lab-kp.pem ubuntu@${aws_eip.juice_ip.public_ip}"
}
