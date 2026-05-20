module "ansible_lab_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.3"
  #
  name        = "${var.project_name}-sg"
  description = "Security Group with SSH egress port open for internet"
  vpc_id      = data.terraform_remote_state.main-vpc.outputs.vpc_id
  #
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"] # open for internet
  #
  egress_rules = ["all-all"]
  #`
  tags = local.common_tags
}
