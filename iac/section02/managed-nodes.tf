module "managed_ansible_nodes" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.4"
  #
  name          = "managed-node.${each.value}"
  ami           = data.aws_ami.rhel10.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key-pub.key_name
  #
  user_data_base64 = filebase64("${path.module}/scripts/setup.sh")

  for_each = toset(["0", "1"])

  vpc_security_group_ids = [module.ansible_lab_sg.security_group_id]
  subnet_id              = data.terraform_remote_state.main-vpc.outputs.private_subnets[tonumber(each.key)]

  # Storage
  root_block_device = {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = false
  }

  tags = local.common_tags
  #

  depends_on = [aws_key_pair.key-pub]
}
