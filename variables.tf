variable "cloud" {
  type        = string
  nullable    = false
  default     = "zscaler.net"
  description = <<-EOT
    Name of the Zscaler cloud for which to return Zscaler Hub IP addresses.

    Must be one of the ZIA clouds (e.g. "zscaler.net").
    May not be a ZPA cloud (e.g. "private.zscaler.com") or ZDX cloud (e.g. "zdxcloud.net").

    See Also:
      https://config.zscaler.com/
    EOT

  validation {
    condition = contains(
      [
        "zscaler.net",
        "zscalerone.net",
        "zscalertwo.net",
        "zscalerthree.net",
        "zscloud.net",
        "zscalerbeta.net",
        "zscalergov.net",
        "zscalerten.net",
      ],
      var.cloud
    )
    error_message = "The cloud argument must be one of the ZIA clouds. See: https://config.zscaler.com/"
  }
}

variable "level" {
  type        = string
  nullable    = false
  default     = "required"
  description = <<-EOT
    Logical access level for which to return Zscaler Hub IP addresses.

    Must be either "required" or "recommended", where the "required" set of Zscaler Hub IP addresses
    is a proper subset of the "recommended" set of Zscaler Hub IP addresses when compared logically;
    i.e. {required} ⊆ {recommended}. The broader "recommended" access level affords more resiliency
    and scalability, whereas the narrower "required" access level minimizes exposure.

    Note:
      Zscaler Hub IP address ranges run vital Zscaler cloud services, platform management, and monitoring.
      Access to & from these IP addresses is essential for seamless service delivery and resilient and scalable support.

    See Also:
      https://config.zscaler.com/zscaler.net/hubs
    EOT

  validation {
    condition     = contains(["required", "recommended"], var.level)
    error_message = "The level argument must be either \"required\" or \"recommended\"."
  }
}
