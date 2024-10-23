output "ip_rules" {
  value       = local.ip_rules
  description = <<-EOT
    List of Zscaler Hub IP addresses, formatted as Azure Storage Account IP rules.

    Every entry is a distinct IPv4 address or disjoint CIDR of mask size /3 or greater.
    The entries are distinct, disjoint, and in sorted order.

    See Also:
      https://learn.microsoft.com/azure/storage/common/storage-network-security#restrictions-for-ip-network-rules
    EOT
}
