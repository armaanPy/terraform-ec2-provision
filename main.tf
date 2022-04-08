provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "cryptoorg_blockchain_host" {
  ami = "ami-04245319ab784590d"
  key_name = var.key_name
  instance_type = var.instance_type
  tags= {
    Name = "blockchain_instance"
  }
}
