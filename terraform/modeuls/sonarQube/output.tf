output "public_ip_sonar_server" {
  value = aws_instance.sonar-server.public_ip
}