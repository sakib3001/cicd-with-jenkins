provider "aws" {
  region              = var.region
  shared_config_files = ["/home/sakib/.aws/credentials"]
}

resource "aws_security_group" "sonar-sg" {

  name = "sonar-sg"

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9092
    to_port     = 9092
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

resource "aws_instance" "sonar-server" {
  ami                         = var.ami
  instance_type               = lookup(var.instance_type, terraform.workspace, "t2.medium")
  key_name                    = "test"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sonar-sg.id]
  tags = {
    Env = lookup(var.workspace_tag, terraform.workspace, "dev")
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/sakib/.ssh/key.pem")
    host        = self.public_ip
  }
  
  provisioner "file" {
    source = "./docker.sh"
    destination = "/home/ubuntu/docker.sh"
    
  }
  provisioner "remote-exec" {
    inline = [ 
        "sudo apt update -y",
        "sudo apt upgrade -y",
        "sudo chmod 777 /home/ubuntu/docker.sh",
        "/home/ubuntu/docker.sh",
        "sudo docker run -d -p 9000:9000 -p 9092:9092 --name sonar sonarqube"
     ]
  } 
}

