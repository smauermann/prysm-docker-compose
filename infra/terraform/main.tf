data "cloudflare_zones" "staker" {
  filter {
    name = var.cloudflare_zone
  }
}

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
  owners = ["self"]
  filter {
    name = "name"
    values = ["eth2-staker-ubuntu*"]
  }
}

# SG
resource "aws_security_group" "staker" {
  name_prefix = "eth2-staker"
  description = "Opens ports for SSH, Beacon, Prometheus & Grafana"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = [
        for x in ingress.value.cidr_ipv4: x == "private" ? local.private_ipv4: x
      ]
      ipv6_cidr_blocks = [
        for x in ingress.value.cidr_ipv6: x == "private" ? local.private_ipv6: x
      ]
    }
  }
  tags = {
    Name = "${var.project_id}-sg"
  }
}

# Instance
resource "aws_instance" "staker" {
  ami = data.aws_ami.staker.id
  instance_type = var.instance_type
  disable_api_termination = var.stage == "production" ? true : false
  instance_initiated_shutdown_behavior = "stop"
  key_name = var.key_pair
  security_groups = [aws_security_group.staker.name]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted = true
  }
  tags = {
    Name = "${var.project_id}-instance"
  }
}

# EBS data volume
# AWS recommends to separate boot and data volumes
resource "aws_ebs_volume" "staker" {
  availability_zone = aws_instance.staker.availability_zone
  encrypted = true
  size = var.data_volume_size
  type = "gp2"
  tags = {
    Name = "${var.project_id}-data-volume"
  }
}

resource "aws_volume_attachment" "staker" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.staker.id
  volume_id = aws_ebs_volume.staker.id
  skip_destroy = var.stage == "production" ? true : false
}

# Elastic IP
resource "aws_eip" "staker" {
  instance = aws_instance.staker.id
  vpc      = true
}

# cloudflare record to make staker reachable via subdomain
resource "cloudflare_record" "staker" {
  name = var.staker_subdomain
  type = "A"
  zone_id = lookup(data.cloudflare_zones.staker.zones[0], "id")
  value = aws_eip.staker.public_ip
}