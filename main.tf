provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "blockchain_host" {
  ami = "ami-04245319ab784590d"
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  instance_type = var.instance_type
  tags= {
    Name = "blockchain_instance"
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}


#resource "aws_key_pair" "deployer" {
#  key_name   = var.key_name
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZlbbdfzA7dWnXfgnlX2AvLpFBGGFd+ku9VAi4GNk6sooqzHTn6JwUb5dSNt0Ua7MwdcLUVDZ8SBdcEDEsivNLoka3V/wWaRGy7CfP4E5gSrh5I0j9y1nmGQiermr5X2l/kq6VnyNY23f935NaAEfA/Ticsl8YeUkkikwLhes9dlKqZAO6t5ngxauUM0SMEgcMLf6AzQ2S45SHp2laLAfMhv5IyF/Zwf8AoGKCVALG2Kl1guqhkBQpMjrKZlv8LjXhSm+IWPRXjnPWC0yrSYSDlJmQRPfDS6klKRZW6QyVbCzwVxFwnieIPiXv6tcCqOWh+W63rawLKK7lse11soBT ec2-user@ip-172-31-11-149.ap-east-1.compute.internal"
#}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.blockchain_host.id
  vpc      = true
}
