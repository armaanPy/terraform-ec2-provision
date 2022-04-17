variable "aws_region" {
  description = "Hong Kong ap-east-1."
  default     = "ap-east-1"
}

variable "key_name" {
  description = "SSH key to connect to EC2 instance."
  default     =  "crypt0def1"
}

variable "instance_type" {
  description = "Instance type for EC2."
  default     =  "t3.micro"
}
