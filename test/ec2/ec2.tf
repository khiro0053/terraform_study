resource "aws_instance" "sandbox" {
  ami = "ami-785c491f"
  instance_type = "t2.micro"
  # remote_stateを指定している
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_id
}
provider "aws" {
      region = "ap-northeast-1"
}

# remote_state を設定し vpc という名前で参照できるようにします
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "khiro-terraform-study"
    key    = "test/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

terraform {
  backend "s3" {
    bucket = "khiro-terraform-study"
    #キー名はVPCのものとかぶらないようにします
    key = "test/ec2/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
