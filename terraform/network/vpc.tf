# create an IGW (Internet Gateway)
# It enables the vpc to connect to the internet
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.dex_vpc.id

  tags = {
    Name = "prod_igw"
  }
}

# create a custom route table for public subnets
# public subnets can reach the internet buy using this
resource "aws_route_table" "prod_public_crt" {
  vpc_id = aws_vpc.dex_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "prod_public_crt"
  }
}

# route table associations
resource "aws_route_table_association" "prod_crta_public_subnet_1" {
  subnet_id      = aws_subnet.dex_subnet_public_1.id
  route_table_id = aws_route_table.prod_public_crt.id
}

resource "aws_vpc" "dex_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "dex_vpc"
  }
}

resource "aws_subnet" "dex_subnet_public_1" {
  vpc_id                  = aws_vpc.dex_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AVAILABILITY_ZONE

  tags = {
    Name = "dex_subnet_public_1"
  }
}

# security groups
resource "aws_security_group" "dex_secgroup" {

  vpc_id = aws_vpc.dex_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dex_secgroup"
  }
}


#ssh key
resource "aws_key_pair" "aws_key" {
  key_name   = "my_key"
  public_key = file("${var.key_path}")
}
