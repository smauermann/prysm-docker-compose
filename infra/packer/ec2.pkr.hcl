variable "aws_access_key" {
  type    = string
  default = ""
}
variable "aws_secret_key" {
  type    = string
  default = ""
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "ami_name_prefix" {
  type = string
  default = "eth2-staker-ubuntu"
}
variable "source_ami_filter_name" {
  type = string
  default = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "this" {
  access_key    = var.aws_access_key
  ami_name      = "${var.ami_name_prefix} ${local.timestamp}"
  instance_type = "t2.micro"
  region        = var.aws_region
  secret_key    = var.aws_secret_key
  source_ami_filter {
    filters = {
      name                = var.source_ami_filter_name
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.this"]

  provisioner "ansible" {
    extra_arguments = ["-v"]
    playbook_file   = "./provision/playbook.yml"
    user            = "ubuntu"
  }
}
