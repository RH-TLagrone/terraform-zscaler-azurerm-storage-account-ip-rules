terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4.0"
    }
  }
}

data "http" "cidr" {
  url = "https://config.zscaler.com/api/${var.cloud}/hubs/cidr/json/${var.level}"

  request_headers = {
    Accept = "application/json"
  }

  retry {
    attempts = 2
  }

  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "Status code invalid: ${self.status_code}"
    }
  }
}

locals {
  hub_prefixes = jsondecode(data.http.cidr.response_body).hubPrefixes
  ip_rules     = flatten([
    for cidr in local.hub_prefixes : (
      endswith(cidr, "/32") ? [substr(cidr, 0, length(cidr) - 3)] :  # Refactor */32 CIDRs to 1 individual IP address.
      endswith(cidr, "/31") ? [  # Refactor */31 CIDRs to 2 individual IP addresses.
        join("", [substr(cidr, 0, length(cidr) - 4), "0"]),
        join("", [substr(cidr, 0, length(cidr) - 4), "1"]),
      ] :
      [cidr]
      # All conditional branches must return the same data type.
      # Thus, we return list(string) on every branch even if it is a singleton.
    )
    if !strcontains(cidr, ":")  # Include only IPv4. (i.e. exclude all IPv6)
  ])
}
