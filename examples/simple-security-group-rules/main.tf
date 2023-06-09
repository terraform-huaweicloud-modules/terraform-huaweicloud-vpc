module "vpc_service" {
  source = "../.."

  is_vpc_create = false

  security_group_name = "module-single-security-group"

  security_group_rules_configuration = [
    {direction="ingress", ethertype="IPv4", protocol="icmp"},
    {direction="ingress", ethertype="IPv6", protocol="icmp", remote_ip_prefix="::/0"},
    {direction="egress", ethertype="IPv4"},
    {direction="egress", ethertype="IPv6", remote_ip_prefix="::/0"},
  ]
  remote_address_group_rules_configuration = [
    {direction="ingress", ethertype="IPv4", protocol="tcp", ports="80", remote_addresses=["192.168.10.22","192.168.11.0-192.168.11.240"]},
  ]
}
