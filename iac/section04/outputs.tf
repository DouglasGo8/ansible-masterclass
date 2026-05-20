output "control_node_instance_id" {
  description = "Instance ID do Control Node"
  value       = aws_instance.control_node.id
}

output "control_node_private_ip" {
  description = "Private IP Control Node"
  value       = aws_instance.control_node.private_ip
}

output "rhel_ami_used" {
  description = "AMI ID used in Control Node"
  value       = data.aws_ami.rhel10.id
}

output "rhel_ami_name" {
  description = "AMI used"
  value       = data.aws_ami.rhel10.name
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.terraform_remote_state.main-vpc.outputs.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = data.terraform_remote_state.main-vpc.outputs.public_subnets[0]
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.ansible_lab_sg.security_group_id
}

output "control_node_public_ip" {
  description = "Public IP Control Node — used over SSH"
  value       = aws_instance.control_node.public_ip
}

output "ssh_command" {
  description = "SSH Command ready to use"
  value       = "ssh -i ../../.secret/generic/key.pem ec2-user@${aws_instance.control_node.public_ip}"
}

output "managed_nodes_info" {
  description = "Managed Nodes information"
  value = {
    for key, node in module.managed_ansible_nodes : key => {
      instance_id = node.id
      private_ip  = node.private_ip
      public_ip   = node.public_ip
    }
  }
}

output "managed_nodes_private_ips" {
  description = "Private Managed Nodes IPs - used for Ansible Inventory"
  value       = [for node in module.managed_ansible_nodes : node.private_ip]
}

output "managed_nodes_public_ips" {
  description = "Public Managed Nodes IPs"
  value       = [for node in module.managed_ansible_nodes : node.public_ip]
}

output "ssh_command_control_node" {
  description = "SSH Command for Control Node"
  value       = "ssh -i ../../.secret/generic/key.pem ec2-user@${aws_instance.control_node.public_ip}"
}

