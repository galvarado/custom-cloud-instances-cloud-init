variable "aws_profile" {
  default     = "default"
  description = "Identity section from ~/.aws/credentials to be used by terraform"
}

variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AVAILABILITY_ZONE" {
  default = "us-west-2a"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair to access the EC2 instance"
  default     = "my_key"
}
