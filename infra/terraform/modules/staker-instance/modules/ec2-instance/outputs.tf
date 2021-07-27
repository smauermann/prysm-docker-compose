output "elastic_ip" {
  value = aws_eip.staker.public_ip
}
