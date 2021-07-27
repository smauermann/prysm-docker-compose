# ec2-instance
variable "aws_region" {
  type = string
}
variable "project_id" {
  type    = string
  default = "eth2-staker"
}
variable "stage" {
  type    = string
  default = "dev"
  validation {
    condition     = var.stage == "dev" || var.stage == "production"
    error_message = "Stage must be either 'dev' or 'production'!"
  }
}
variable "ami_filter_name" {
  type        = string
  description = "Used to find AMI."
}
variable "ingress_rules" {
  type = list(object({
    port        = string
    protocol    = string
    description = string
    cidr_ipv4   = list(string)
    cidr_ipv6   = list(string)
  }))
}
variable "instance_type" {
  type    = string
  default = "t3a.medium"
}
variable "key_pair" {
  type    = string
  default = ""
}
variable "data_volume_size" {
  type    = number
  default = 100
}
variable "root_volume_size" {
  type    = number
  default = 16
}
variable "instance_termination_protection" {
  type = bool
}
variable "ebs_volume_attachment_skip_destroy" {
  type = bool
}

# cloudflare
variable "cloudflare_token" {
  type = string
}
variable "cloudflare_zone" {
  type = string
}
variable "subdomain" {
  type = string
}
