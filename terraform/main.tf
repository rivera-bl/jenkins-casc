locals {
  service_name = "Jenkins"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Name  = local.service_name
      Owner = "Pablo"
    }
  }
}

module "ec2_instance_basic" {
  source = "github.com/rivera-bl/terraform-modules//terraform-aws-ec2-basic"

  service_name  = local.service_name
  instance_type = "t2.medium"
  user_data     = file("files/user_data.sh")
}

output "instance_public_ip" {
  value = module.ec2_instance_basic.instance_public_ip
}
