# ec2-instance
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
  default = [
    {
      port        = 12000
      protocol    = "udp"
      description = "Beacon node UDP"
      cidr_ipv4   = ["0.0.0.0/0"]
      cidr_ipv6   = ["::/0"]
    },
    {
      port        = 13000
      protocol    = "tcp"
      description = "Beacon node tcp"
      cidr_ipv4   = ["0.0.0.0/0"]
      cidr_ipv6   = ["::/0"]
    },
    {
      port        = 9090
      protocol    = "tcp"
      description = "Prometheus"
      cidr_ipv4   = ["private"]
      cidr_ipv6   = ["private"]
    },
    {
      port        = 3000
      protocol    = "tcp"
      description = "Grafana"
      cidr_ipv4   = ["private"]
      cidr_ipv6   = ["private"]
    },
    {
      port        = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_ipv4   = ["private"]
      cidr_ipv6   = ["private"]
    }
  ]
}
variable "instance_type" {
  type    = string
  default = "t3a.medium"
}
variable "key_pair" {
  type = string
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

# cloudflare
variable "create_cloudflare_record" {
  type    = bool
  default = true
}
variable "cloudflare_token" {
  type    = string
  default = ""
}
variable "cloudflare_zone" {
  type    = string
  default = ""
}
variable "subdomain" {
  type    = string
  default = ""
}
