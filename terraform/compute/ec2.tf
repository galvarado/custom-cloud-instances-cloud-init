data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


data "aws_subnet" "dex_subnet_public_1" {
  filter {
    name   = "tag:Name"
    values = ["dex_subnet_public_1"]
  }
}

data "aws_security_group" "dex_secgroup" {
  filter {
    name   = "tag:Name"
    values = ["dex_secgroup"]
  }
}

data "cloudinit_config" "server_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = file("../../scripts/cloud-config.yml")
  }
}

resource "aws_instance" "webserver1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  tags = {
    Name = "dexserver"
  }
  user_data              = data.cloudinit_config.server_config.rendered
  subnet_id              = data.aws_subnet.dex_subnet_public_1.id
  vpc_security_group_ids = [data.aws_security_group.dex_secgroup.id]
  key_name               = var.key_name
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }
}