module "sonar-server" {
  source = "./modeuls/sonarQube"
  ami = var.ami
  region = var.region
}

resource "aws_security_group" "jenkins-sg" {

  name = "jenkins-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins-server" {
  ami                         = var.ami
  instance_type               = lookup(var.instance_type, terraform.workspace, "t2.medium")
  key_name                    = "test"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  tags = {
    Env = lookup(var.workspace_tag, terraform.workspace, "dev")
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/sakib/.ssh/key.pem")
    host        = self.public_ip
  }
  
provisioner "remote-exec" {
  inline = [
    "sudo apt update -y",
    "sudo apt install -y curl",
    "sudo apt install -y openjdk-17-jre",
    "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
    "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
    "sudo apt update -y",
    "sudo apt install -y jenkins",
    "sudo systemctl enable jenkins",
    "sudo systemctl start jenkins"
  ]
}

  
}

resource "aws_key_pair" "test" {
  key_name   = "test"
  public_key = file("/home/sakib/.ssh/id_rsa.pub")
}
