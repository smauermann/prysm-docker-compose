# provider inheritance is broken for non-hashicorp providers
# see github issue here https://github.com/hashicorp/terraform/issues/26448
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.14"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}
