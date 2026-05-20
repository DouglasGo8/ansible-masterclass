variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  description = "Project name - used in tags, names and resources"
  type        = string
  default     = "ansible-masterclass"
}

variable "instance_type" {
  description = "EC2 instance — t4g.micro cost-effective"
  type        = string
  default     = "t4g.micro"
}

variable "rhel_ami_filter" {
  description = "Filter looking for AMI RHEL9/CentOS Stream most recent version"
  type        = string
  default     = "RHEL-10.1.0_HVM-*arm64*" # Can be changed to RHEL with appropriated subscription
}


variable "root_volume_size" {
  description = "Tamanho do root volume em GB"
  type        = number
  default     = 20
}

variable "ansible_control_node_name" {
  description = "Nome da EC2 Control Node"
  type        = string
  default     = "ansible-control-node"
}
