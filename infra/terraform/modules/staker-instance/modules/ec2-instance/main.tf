locals {
  project_tag   = "${var.project_id}-${var.stage}"
  is_production = var.stage == "production" ? true : false
}

# SG
resource "aws_security_group" "staker" {
  name_prefix = local.project_tag
  description = "Opens ports for SSH, Beacon, Prometheus & Grafana"
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = [
        for x in ingress.value.cidr_ipv4 : x == "private" ? local.private_ipv4 : x
      ]
      ipv6_cidr_blocks = [
        for x in ingress.value.cidr_ipv6 : x == "private" ? local.private_ipv6 : x
      ]
    }
  }
  egress {
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow access to internet"
  }
  tags = {
    Name = "${local.project_tag}-sg"
  }
}

# Instance
resource "aws_instance" "staker" {
  ami                                  = data.aws_ami.staker.id
  instance_type                        = var.instance_type
  disable_api_termination              = var.instance_termination_protection
  instance_initiated_shutdown_behavior = "stop"
  key_name                             = var.key_pair
  security_groups                      = [aws_security_group.staker.name]
  credit_specification {

  }
  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_volume_size
    encrypted   = true
  }

  tags = {
    Name = "${local.project_tag}-instance"
  }
}

# EBS data volume
# AWS recommends to separate boot and data volumes
resource "aws_ebs_volume" "staker" {
  availability_zone = aws_instance.staker.availability_zone
  encrypted         = true
  size              = var.data_volume_size
  type              = "gp2"
  tags = {
    Name = "${local.project_tag}-data-volume"
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_volume_attachment" "staker" {
  device_name = "/dev/sdf"
  instance_id = aws_instance.staker.id
  volume_id   = aws_ebs_volume.staker.id
}

# Elastic IP
resource "aws_eip" "staker" {
  instance = aws_instance.staker.id
  vpc      = true
}
