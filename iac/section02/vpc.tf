data "terraform_remote_state" "main-vpc" {
  backend = "local" # or S3
  config = {
    path = "../vpc/terraform.tfstate"
  }
}
