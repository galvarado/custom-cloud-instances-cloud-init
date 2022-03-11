variable "aws_profile" {
  default     = "staging:eks_example"
  description = "Identity section from ~/.aws/credentials to be used by terraform"
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AVAILABILITY_ZONE" {
  default = "eu-west-1a"
}


variable "key_path" {
  description = "Key pair to access the EC2 instance"
  default     = "~/.ssh/id_rsa.pub"
}
