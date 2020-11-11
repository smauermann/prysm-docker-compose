terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.14.1"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.13.2"
    }
  }
}

provider "aws" {
  version = "~> 3.0"
  region = var.aws_region
}

provider "cloudflare" {
  version = "~> 2.0"
  api_token = var.cloudflare_token
}

