variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "cloudflare_token" {
  type = string
}
variable "ingress_rules" {
  type = list(object({
    port = string
    protocol = string
    description = string
    cidr_ipv4 = list(string)
    cidr_ipv6 = list(string)
  }))
}
variable "instance_type" {
  type = string
  default = ""
}
variable "key_pair" {
  type = string
  default = ""
}
variable "project_id" {
  type = string
  default = "eth2-staker"
}
variable "stage" {
  type = string
  default = "dev"
  validation {
    condition = var.stage == "dev" || var.stage == "production"
    error_message = "Stage must be either 'dev' or 'production'!"
  }
}
variable "data_volume_size" {
  type = number
  default = 100
}
variable "cloudflare_zone" {
  type = string
}
variable "staker_subdomain" {
  type = string
}
