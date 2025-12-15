output "ec2_public_ip" {
  description = "Public IP of the Flask EC2 instance"
  value       = aws_instance.flask_app.public_ip
}

