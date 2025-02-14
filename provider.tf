terraform {

  # If using TF Cloud
  #  cloud {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.51.1"
    }
  }

  # Given that S3 should be created prior to this terraform
  # S3 native locking (Terraform v1.6+)  
  # No need for DynamoDB
  backend "s3" {
    bucket       = "terraform-state-bucket2"
    key          = "state/statefile.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

# If you are using a multiple accounts
provider "aws" {
  # AWS account profile name
  profile  = "remote"
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::${var.account}:role/TerraformRole"
  }
}