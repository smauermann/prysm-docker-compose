aws_region    = ""
project_id    = ""
stage         = ""
instance_type = ""
key_pair      = ""
ingress_rules = [
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
    cidr_ipv6   = []
  },
  {
    port        = 3000
    protocol    = "tcp"
    description = "Grafana"
    cidr_ipv4   = ["private"]
    cidr_ipv6   = []
  },
  {
    port        = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_ipv4   = ["private"]
    cidr_ipv6   = []
  }
]
cloudflare_token = ""
cloudflare_zone  = ""
subdomain        = ""
