data "cloudflare_zones" "this" {
  filter {
    name = var.zone
  }
}

resource "cloudflare_record" "a_record" {
  count   = var.create_record ? 1 : 0
  name    = var.subdomain
  type    = "A"
  zone_id = lookup(data.cloudflare_zones.this.zones[0], "id")
  value   = var.a_record_value
}
