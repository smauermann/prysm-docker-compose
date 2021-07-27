terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "~> 3.21"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.14 "
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
