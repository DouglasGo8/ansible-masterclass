resource "aws_instance" "control_node" {
  ami                    = data.aws_ami.rhel10.id
  instance_type          = var.instance_type
  subnet_id              = data.terraform_remote_state.main-vpc.outputs.public_subnets[0]
  vpc_security_group_ids = [module.ansible_lab_sg.security_group_id]
  #
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key-pub.key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = false # Training mode — not necessary
  }
  #
  user_data_base64 = filebase64("${path.module}/scripts/control-node-setup.sh")


  tags = {
    Name = var.ansible_control_node_name
  }

}

# Provisioner — copy the private key after ec2 instance is ready
resource "null_resource" "copy_ssh_key" {
  provisioner "file" {
    source      = "../../.secret/generic/key.pem"
    destination = "/tmp/id_rsa"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("../../.secret/generic/key.pem")
      host        = aws_instance.control_node.public_ip
      timeout     = "5m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "mv /tmp/id_rsa ~/.ssh/id_rsa",
      "chmod 600 ~/.ssh/id_rsa",
      "mkdir -p ~/ansible"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("../../.secret/generic/key.pem")
      host        = aws_instance.control_node.public_ip
      timeout     = "5m"
    }
  }

  depends_on = [aws_instance.control_node]
}

resource "aws_key_pair" "key-pub" {
  key_name   = "key-pub"
  public_key = file("../../.secret/generic/key.pem.pub")
}
