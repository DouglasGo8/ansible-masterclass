data "aws_ami" "rhel10" {
  most_recent = true
  owners      = ["309956199498"] # Owner oficial CentOS

  filter {
    name   = "name"
    values = [var.rhel_ami_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

