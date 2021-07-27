data "http" "my_ipv4" {
  url = "http://ipv4.icanhazip.com"
}

data "http" "my_ipv6" {
  url = "http://ipv6.icanhazip.com"
}

locals {
  private_ipv4 = "${chomp(data.http.my_ipv4.body)}/32"
  private_ipv6 = "${chomp(data.http.my_ipv6.body)}/128"
}

data "aws_ami" "staker" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }
}
