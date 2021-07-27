module "staker_instance" {
  source           = "./modules/ec2-instance"
  project_id       = var.project_id
  stage            = var.stage
  ami_filter_name  = var.ami_filter_name
  instance_type    = var.instance_type
  data_volume_size = var.data_volume_size
  root_volume_size = var.root_volume_size
  ingress_rules    = var.ingress_rules
  key_pair         = var.key_pair

  instance_termination_protection = var.instance_termination_protection
}

locals {
  subdomain = var.stage == "production" ? var.subdomain : "${var.stage}.${var.subdomain}"
}

module "cloudflare_record" {
  source         = "./modules/cloudflare"
  create_record  = var.create_cloudflare_record
  api_token      = var.cloudflare_token
  zone           = var.cloudflare_zone
  subdomain      = local.subdomain
  a_record_value = module.staker_instance.elastic_ip
}
