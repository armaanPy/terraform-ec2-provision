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


resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsTwpJZjJ2ZQI3/Ac/SKRb96+2xC86VMN8N4ld6duYdIQdUlg3Omp914o7JHPl3PWFS54Tk3KamN6MownXTC2WWiRHvIWLYNXfISGXNGRisK7Ems6INCI8SGsbZLoIC59uRWBgqwmlrFv4+y57kpZIQlpp8m3QnaKDpkcNifhNi30xgCCc2R8xN2Hj/YddYIxIF4oMBYlzNtHBngXVQhzm8c0FJ16gGkbiejt1ejkQZetCATFPRqTkGrlPuHi6ucTwtgN8a0JGYOb0Dbzqq5ot8hIzrI1w5KVtyyRYtXq6qT4FGMiAZYUMp0tXJN7dpExtGuaDKHk99tQW6B1XgE+r ec2-user@ip-172-31-11-149.ap-east-1.compute.internal"
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.blockchain_host.id
  vpc      = true
}
