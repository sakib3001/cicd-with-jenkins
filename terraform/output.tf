output "jenkins_public_id" {
  value = aws_instance.jenkins-server.public_ip
}
output "sonar_server_ip" {
  value = module.sonar-server.public_ip_sonar_server
  
}