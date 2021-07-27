module "staker_instance" {
  source = "../modules/staker-instance"

  project_id = var.project_id
  stage      = var.stage

  instance_type    = var.instance_type
  ami_filter_name  = var.ami_filter_name
  key_pair         = var.key_pair
  data_volume_size = var.data_volume_size

  instance_termination_protection = var.instance_termination_protection
  cloudflare_token = var.cloudflare_token
  cloudflare_zone  = var.cloudflare_zone
  subdomain        = var.subdomain
}
