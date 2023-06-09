module "vpc_service" {
  source = "../.."

  security_group_name = "module-single-security-group"

  security_group_rules_configuration = [
    {direction="ingress", ethertype="IPv4", protocol="icmp"},
    {direction="ingress", ethertype="IPv6", protocol="icmp", remote_ip_prefix="::/0"},
    {direction="egress", ethertype="IPv4"},
    {direction="egress", ethertype="IPv6", remote_ip_prefix="::/0"},
  ]
}
