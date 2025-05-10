data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

locals {
  my_ip_raw   = chomp(data.http.my_ip.response_body)
  my_ip_parts = split(".", local.my_ip_raw)
  my_ip_cidr  = "${local.my_ip_parts[0]}.${local.my_ip_parts[1]}.0.0/16"
}
