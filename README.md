# Zscaler IP Rules for Azure Storage Accounts

Terraform data-only module of Zscaler IP rules to allow for Azure storage accounts

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.cidr](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud"></a> [cloud](#input\_cloud) | Name of the Zscaler cloud for which to return Zscaler Hub IP addresses.<br><br>Must be one of the ZIA clouds (e.g. "zscaler.net").<br>May not be a ZPA cloud (e.g. "private.zscaler.com") or ZDX cloud (e.g. "zdxcloud.net").<br><br>See Also:<br>  https://config.zscaler.com/ | `string` | `"zscaler.net"` | no |
| <a name="input_level"></a> [level](#input\_level) | Logical access level for which to return Zscaler Hub IP addresses.<br><br>Must be either "recommended" or "required", where the "required" set of Zscaler Hub IP addresses<br>is a proper subset of the "recommended" set of Zscaler Hub IP addresses when compared logically;<br>i.e. {required} ⊆ {recommended}. The broader "recommended" access level affords more resiliency<br>and scalability, whereas the narrower "required" access level minimizes exposure.<br>(defaults to "recommended")<br><br>Note:<br>  Zscaler Hub IP address ranges run vital Zscaler cloud services, platform management, and monitoring.<br>  Access to & from these IP addresses is essential for seamless service delivery and resilient and scalable support.<br><br>See Also:<br>  https://config.zscaler.com/zscaler.net/hubs | `string` | `"recommended"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_rules"></a> [ip\_rules](#output\_ip\_rules) | List of Zscaler Hub IP addresses, formatted as Azure Storage Account IP rules.<br><br>Every entry is a distinct IPv4 address or disjoint CIDR of mask size /3 or greater.<br>The entries are distinct, disjoint, and in sorted order.<br><br>See Also:<br>  https://learn.microsoft.com/azure/storage/common/storage-network-security#restrictions-for-ip-network-rules |
