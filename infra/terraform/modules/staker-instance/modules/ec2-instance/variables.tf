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
  type = string
}
variable "key_pair" {
  type = string
}
variable "project_id" {
  type = string
}
variable "stage" {
  type = string
  validation {
    condition     = var.stage == "dev" || var.stage == "production"
    error_message = "Stage must be either 'dev' or 'production'!"
  }
}
variable "data_volume_size" {
  type = number
}
variable "root_volume_size" {
  type = number
}
variable "instance_termination_protection" {
  type = bool
}
