terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "pftd-special-project"
    region = "eu-west-2"
    key = "pftd/dev/terraform.tfstate"
    
  }
}



provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      BillingID = "PFTD-Team"
      Project   = "PFTD"
      terraform = true
    }
  }
}